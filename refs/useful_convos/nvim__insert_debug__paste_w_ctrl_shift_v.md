# Debugging: Ctrl+Shift+V in nvim insert mode shows `^` instead of pasting

## The problem

On the CachyOS ThinkPad (sway + WezTerm), pressing Ctrl+Shift+V in nvim insert mode
didn't paste. Instead a gray `^` appeared and nvim waited for another key, then
inserted that key as text (Esc became `^[`, Ctrl+Shift+V became `<C-S-V>`).

## The cause

- `wezterm/wezterm.lua` sets `config.disable_default_key_bindings = true`, which
  removes WezTerm's built-in Ctrl+Shift+V paste. Paste was only bound to
  `AltAlt`+v (Alt on Linux, Cmd on Mac).
- With nothing bound to Ctrl+Shift+V, WezTerm passed the key through to nvim.
  `enable_csi_u_key_encoding = true` meant nvim received it as a distinct `<C-S-V>`.
- In insert mode nvim treats `<C-S-V>` like `Ctrl-V`: "insert the next key
  literally" (`:help i_CTRL-V`). The gray `^` is nvim waiting for that next key.

Only this machine was affected because the Mac pastes with Cmd+V, and the Linux
setup relied on keyd to translate shortcuts, which wasn't working here.

## The fix

- Bound Ctrl+Shift+V to `PasteFrom 'Clipboard'` in `wezterm.lua`.
- Rebound Ctrl+Shift+C to `CopyTo 'ClipboardAndPrimarySelection'`. It was bound to a
  `select-and-paste` event whose handler did nothing, so that handler was deleted.
- Added `exec keyd-application-mapper -d` to `sway/config` so the per-app remaps in
  `keyd/app.conf` (Alt+V → Ctrl+Shift+V in terminals) take effect.
- The app mapper needs access to `/var/run/keyd.socket`, which only root and the
  `keyd` group can use: `sudo usermod -aG keyd shane`, then log out and back in.

## How it was debugged

The general approach: work out which program is actually handling the keypress,
and then read that program's config.

### 1. Read the symptom closely

A gray `^` followed by the next key being inserted as text is nvim's `Ctrl-V`
literal-insert mode. That told me something important: **the keypress was reaching
nvim**. A paste in a terminal never reaches the program inside it, because the
terminal catches the key and sends the clipboard text instead. So the question
became why the terminal let the key through.

### 2. Map out the chain the key travels through

A keypress passes through several programs, and any of them can change or swallow it:

```
keyboard → keyd → sway → WezTerm → fish/zsh → nvim
```

"Only on this machine" suggested something machine-specific in that chain, more
likely in the layers above nvim than in nvim itself.

### 3. Identify each layer instead of guessing

- `echo $TERM_PROGRAM` → `WezTerm`
- `pstree -s $$` → `sway---wezterm-gui---fish---...`
- `pgrep -af keyd` → keyd daemon running, `keyd-application-mapper` not running

### 4. Grep each layer's config for the relevant settings

In WezTerm I searched for `disable_default_key_bindings`, `Paste`, `csi_u`, and `mods`:

```
grep -nE "disable_default_key_bindings|kitty_keyboard|csi_u|Paste|mods" ~/.config/wezterm/wezterm.lua
```

That turned up three things:

- `disable_default_key_bindings = true`, which removes the built-in paste binding.
- Paste was only bound to `AltAlt`+v.
- `enable_csi_u_key_encoding = true`, which is why nvim received a precise `<C-S-V>`.

### 5. Check what the program actually loaded, not just the file

```
wezterm show-keys
```

This prints the bindings WezTerm really ended up with. It had no Ctrl+Shift+V
entry, which confirmed the cause. After the fix, running it again confirmed the new
binding was there.

### 6. Keep going past the first answer

Checking keyd turned up two more problems:

- `/etc/keyd/default.conf` has `[alt] v = C-v`, which turns Alt+V into Ctrl+V
  system-wide. So Alt+V paste was broken too (same literal-insert behavior in nvim).
- `keyd/app.conf` overrides that for terminals (`alt.v = C-S-v`), but it only works
  when `keyd-application-mapper` is running, and it wasn't. The mapper also needs
  the `keyd` group (`ls -la /var/run/keyd.socket`, `id -nG`).
- `swaymsg -t get_tree | grep app_id` confirmed the `[*wezterm*]` pattern in
  `app.conf` matches the actual window ids (`org.wezfurlong.wezterm`, `startup-wezterm`).

## Habits worth reusing

- **The symptom often tells you which layer is responding.** `^` meant nvim, so the
  question was why the terminal didn't catch the key.
- **Test each layer on its own.** Try the paste in plain fish with nvim closed. If it
  fails there too, the problem is above nvim. Running `cat` or `showkey -a` and
  pressing the key shows what the terminal sends.
- **Ask each program what it loaded.** For example:
  - `wezterm show-keys`
  - `:verbose imap <C-S-V>` in nvim
  - `swaymsg -t get_tree` for window ids
  - `pgrep` / `systemctl` for what's actually running
- **"Only on machine X"** means looking for differences: your config's per-OS
  branches (like `AltAlt`), daemons running on one machine and not another, and
  files in `/etc`.
