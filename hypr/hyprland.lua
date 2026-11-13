-- Hyprland config mirroring ~/.config/sway/config
-- Lua port of hyprland.conf
-- Wiki: https://wiki.hypr.land/Configuring/

------------------
---- MONITORS ----
------------------
hl.monitor({
    output   = "eDP-1",
    mode     = "2560x1600@60",
    position = "auto",
    scale    = 1.25,
})

---------------------
---- VARIABLES ----
---------------------
local mod     = "SUPER"
local alt     = "ALT"
local term    = "wezterm"
local browser = "brave"
local menu    = "wofi --show=drun"
local files   = "dolphin"

-------------------
---- AUTOSTART ----
-------------------
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")

hl.on("hyprland.start", function()
    -- clipboard history
    hl.exec_cmd("command -v wl-paste >/dev/null 2>&1 && wl-paste --watch cliphist store")

    -- wallpaper (see hyprpaper.conf)
    hl.exec_cmd("hyprpaper")

    -- bar, notification center
    hl.exec_cmd("waybar -c ~/.config/waybar/config-hyprland")
    hl.exec_cmd("swaync")

    -- per-app keyd remaps (~/.config/keyd/app.conf); needs user in the keyd group
    hl.exec_cmd("keyd-application-mapper -d")

    -- idle: lock after 10 min, inhibit while audio plays
    hl.exec_cmd("swayidle -w timeout 600 'swaylock -f -c 000000'")
    hl.exec_cmd("sway-audio-idle-inhibit")

    -- portal daemon so file pickers appear in brave/zen
    hl.exec_cmd("/usr/lib/xdg-desktop-portal-gtk")

    -- startup apps, each placed on its workspace
    hl.exec_cmd("wezterm start", { workspace = "name:s.term silent" })
    hl.exec_cmd("brave",         { workspace = "name:2.web silent" })
    hl.exec_cmd("/usr/bin/goofcord", { workspace = "name:1.msg silent" })
end)

-----------------------
---- LOOK AND FEEL ----
-----------------------
hl.config({
    general = {
        gaps_in          = 1,
        gaps_out         = 0,
        border_size      = 4,
        col = {
            active_border   = "rgb(ffc300)",
            inactive_border = "rgba(595959aa)",
        },
        resize_on_border = false,
        allow_tearing    = false,
        layout           = "dwindle",
    },

    decoration = {
        rounding         = 5,
        active_opacity   = 1.0,
        inactive_opacity = 0.9,

        blur = {
            enabled  = false,
            size     = 2,
            passes   = 1,
            vibrancy = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },
})

hl.curve("myBezier", { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05} } })

hl.animation({ leaf = "windows",     enabled = true, speed = 1,  bezier = "myBezier" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 1,  bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border",      enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 8,  bezier = "default" })
hl.animation({ leaf = "fade",        enabled = true, speed = 1,  bezier = "default" })
hl.animation({ leaf = "workspaces",  enabled = true, speed = 6,  bezier = "default" })

hl.config({
    dwindle = {
        preserve_split = true,
    },

    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo   = true,
    },
})

---------------
---- INPUT ----
---------------
hl.config({
    input = {
        kb_layout    = "us",
        follow_mouse = 1,
        sensitivity  = 0,

        touchpad = {
            natural_scroll = false,
        },
    },
})

---------------------
---- KEYBINDINGS ----
---------------------

-- launch
hl.bind(mod .. " + t",         hl.dsp.exec_cmd(term .. " start"))
hl.bind(mod .. " + b",         hl.dsp.exec_cmd(browser .. " --new-window"))
hl.bind(mod .. " + m",         hl.dsp.exec_cmd(files .. " --new-window"))
hl.bind(mod .. " + d",         hl.dsp.exec_cmd(menu))
hl.bind(mod .. " + SHIFT + p", hl.dsp.exec_cmd("~/.config/scripts/aesthetic_switcher"))
hl.bind(mod .. " + p",         hl.dsp.exec_cmd("killall -SIGUSR1 waybar"))
hl.bind(mod .. " + n",         hl.dsp.exec_cmd("swaync-client -t -sw"))

-- window / session
hl.bind(mod .. " + q",         hl.dsp.window.close())
hl.bind(mod .. " + SHIFT + r", hl.dsp.exec_cmd("hyprctl reload"))
hl.bind(mod .. " + SHIFT + e", hl.dsp.exit())

-- focus
hl.bind(mod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + j", hl.dsp.focus({ direction = "down" }))
hl.bind(mod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. " + l", hl.dsp.focus({ direction = "right" }))

-- move window
hl.bind(mod .. " + CONTROL + h", hl.dsp.window.move({ direction = "left" }))
hl.bind(mod .. " + CONTROL + j", hl.dsp.window.move({ direction = "down" }))
hl.bind(mod .. " + CONTROL + k", hl.dsp.window.move({ direction = "up" }))
hl.bind(mod .. " + CONTROL + l", hl.dsp.window.move({ direction = "right" }))

-- next / previous workspace
hl.bind(mod .. " + SHIFT + l", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + SHIFT + h", hl.dsp.focus({ workspace = "e-1" }))

-- workspaces
hl.bind(mod .. " + s", hl.dsp.focus({ workspace = "name:s.term" }))
hl.bind(mod .. " + 1", hl.dsp.focus({ workspace = "name:1.msg" }))
hl.bind(mod .. " + 2", hl.dsp.focus({ workspace = "name:2.web" }))
for i = 3, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = i }))
end

hl.bind(mod .. " + SHIFT + s", hl.dsp.window.move({ workspace = "name:s.term" }))
hl.bind(mod .. " + SHIFT + 1", hl.dsp.window.move({ workspace = "name:1.msg" }))
hl.bind(mod .. " + SHIFT + 2", hl.dsp.window.move({ workspace = "name:2.web" }))
for i = 3, 10 do
    local key = i % 10
    hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- layout
hl.bind(mod .. " + w",         hl.dsp.group.toggle())
hl.bind(mod .. " + SHIFT + v", hl.dsp.layout("togglesplit"))
hl.bind(mod .. " + f",         hl.dsp.window.fullscreen())
-- fake fullscreen: app thinks it is fullscreen, Hyprland keeps it tiled
hl.bind(mod .. " + SHIFT + f", hl.dsp.window.fullscreen_state({ internal = 0, client = 2, action = "toggle" }))

-- toggle floating; when a window becomes floating, make it 50% x 50% of the screen, centered
hl.bind(mod .. " + space", function()
    hl.dispatch(hl.dsp.window.float({ action = "toggle" }))
    local win = hl.get_active_window()
    local mon = hl.get_active_monitor()
    if win and win.floating and mon then
        hl.dispatch(hl.dsp.window.resize({
            x = math.floor(mon.width / mon.scale * 0.5),
            y = math.floor(mon.height / mon.scale * 0.5),
        }))
        hl.dispatch(hl.dsp.window.center())
    end
end)
hl.bind(mod .. " + SHIFT + space", hl.dsp.window.cycle_next({ floating = true }))

-- resize (sway: shrink/grow height on / and m, width on . and ,)
hl.bind(mod .. " + SHIFT + slash",  hl.dsp.window.resize({ x = 0,   y = -30, relative = true }), { repeating = true })
hl.bind(mod .. " + SHIFT + m",      hl.dsp.window.resize({ x = 0,   y = 30,  relative = true }), { repeating = true })
hl.bind(mod .. " + SHIFT + comma",  hl.dsp.window.resize({ x = -30, y = 0,   relative = true }), { repeating = true })
hl.bind(mod .. " + SHIFT + period", hl.dsp.window.resize({ x = 30,  y = 0,   relative = true }), { repeating = true })

-- scratchpad
hl.bind(mod .. " + SHIFT + minus", hl.dsp.window.move({ workspace = "special:scratchpad" }))
hl.bind(mod .. " + minus",         hl.dsp.workspace.toggle_special("scratchpad"))

-- drag floating windows: mod + LMB move, mod + RMB resize
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- resize mode (mod + r)
hl.bind(mod .. " + r", hl.dsp.submap("resize"))
hl.define_submap("resize", function()
    local rep = { repeating = true }
    hl.bind("h",     hl.dsp.window.resize({ x = -10, y = 0,   relative = true }), rep)
    hl.bind("j",     hl.dsp.window.resize({ x = 0,   y = 10,  relative = true }), rep)
    hl.bind("k",     hl.dsp.window.resize({ x = 0,   y = -10, relative = true }), rep)
    hl.bind("l",     hl.dsp.window.resize({ x = 10,  y = 0,   relative = true }), rep)
    hl.bind("left",  hl.dsp.window.resize({ x = -10, y = 0,   relative = true }), rep)
    hl.bind("down",  hl.dsp.window.resize({ x = 0,   y = 10,  relative = true }), rep)
    hl.bind("up",    hl.dsp.window.resize({ x = 0,   y = -10, relative = true }), rep)
    hl.bind("right", hl.dsp.window.resize({ x = 10,  y = 0,   relative = true }), rep)
    hl.bind("return", hl.dsp.submap("reset"))
    hl.bind("escape", hl.dsp.submap("reset"))
end)

-- volume / mic / brightness
hl.bind("XF86AudioRaiseVolume",   hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +5%"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume",   hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -5%"), { locked = true, repeating = true })
hl.bind("XF86AudioMute",          hl.dsp.exec_cmd("pactl set-sink-mute @DEFAULT_SINK@ toggle"), { locked = true })
hl.bind("XF86AudioMicMute",       hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })
hl.bind("XF86MonBrightnessUp",    hl.dsp.exec_cmd("brightnessctl set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",  hl.dsp.exec_cmd("brightnessctl set 5%-"), { locked = true, repeating = true })

-- media (playerctl)
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

-- screenshots
hl.bind(alt .. " + SHIFT + 4", hl.dsp.exec_cmd('grim -g "$(slurp)" - | wl-copy'))
hl.bind(alt .. " + SHIFT + 3", hl.dsp.exec_cmd('grim -g "$(slurp)" - | tee ~/Pictures/screenshot.png'))

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- inhibit idle when any window is fullscreen
hl.window_rule({ match = { class = ".*" }, idle_inhibit = "fullscreen" })

-- browsers: fake fullscreen by default (app thinks fullscreen, stays tiled)
hl.window_rule({ match = { class = "^brave(-browser)?$" }, fullscreen_state = "0 2" })

hl.window_rule({ match = { class = "^org\\.pulseaudio\\.pavucontrol$" }, float = true })

-- brave + dolphin: floating, 58% of the screen, centered
-- hl.window_rule({
--     match  = { class = "^brave(-browser)?$" },
--     float  = true,
--     size   = "monitor_w*0.58 monitor_h*0.58",
--     center = true,
-- })

hl.window_rule({
    match  = { class = "^org\\.kde\\.dolphin$" },
    float  = true,
    size   = "monitor_w*0.58 monitor_h*0.58",
    center = true,
})

-- ignore maximize requests from apps
hl.window_rule({ match = { class = ".*" }, suppress_event = "maximize" })
