local wezterm = require 'wezterm'
local io = require 'io';
local os = require 'os';
local config = {}

local function read_file(path)
    local file = io.open(path, "rb") -- r read mode and b binary mode
    if not file then return nil end
    local content = file:read "*a" -- *a or *all reads the whole file
    file:close()
    return content
end
local function tab_title(tab_info)
    local title = tab_info.tab_title
    -- if the tab title is explicitly set, take that
    if title and #title > 0 then
        return title
    end
    -- Otherwise, use the title from the active pane
    -- in that tab
    return tab_info.active_pane.title
end

function on_format_tab_title(tab, _tabs, _panes, _config, _hover, _max_width)
    local zoomed = ''
    local index = tab.tab_index + 1
    local title = tab_title(tab)
    if tab.active_pane.is_zoomed then
        zoomed = '🧐'
    end
    return {
        { Text = string.format('%d %s %s ', index, title, zoomed) }
    }
end

wezterm.on('format-tab-title', on_format_tab_title)

wezterm.on("trigger-vim-with-scrollback", function(window, pane)
  local scrollback = pane:get_lines_as_text(pane:get_dimensions().scrollback_rows);

  local name = os.tmpname();
  local f = io.open(name, "w+");
  f:write(scrollback);
  f:flush();
  f:close();

  window:perform_action(wezterm.action{ SpawnCommandInNewTab = {
    domain = "CurrentPaneDomain",
    args={ "nvim", '-U', '$HOME/.config/nvim/minit.vim', '+', name }
    }
  }, pane)

  wezterm.sleep_ms(1000);
  os.remove(name);
end)

wezterm.on('update-right-status', function(window, pane)
  local name = window:active_key_table()
  if name then
    name = 'TABLE: ' .. name
  end
  window:set_right_status(name or '')
end)

wezterm.on('select-and-paste', function(window, pane)
  wezterm.action.QuickSelectArgs {
   patterns = {
      '[\\w\\-\\.\\/~]+',
    },
  }
  wezterm.action.PasteFrom 'Clipboard'
end)

Alt = 'ALT'
NonAlt = 'META'
AltAlt = 'ALT'
Desktop = os.getenv("DESKTOP_SESSION")

config.disable_default_key_bindings = true
config.font = wezterm.font 'JetBrains Mono Regular'
config.font_size = 10
config.enable_scroll_bar = false
config.color_scheme = "theme"
config.default_prog = { 'fish' }
config.leader = { key = 'Space', mods = 'CTRL|SHIFT', timeout_milliseconds = 1000 }
config.window_close_confirmation = "NeverPrompt"
config.adjust_window_size_when_changing_font_size = false
config.window_background_opacity = 0.99
config.use_fancy_tab_bar = true
config.show_new_tab_button_in_tab_bar = false
config.tab_and_split_indices_are_zero_based = true
config.text_blink_rate = 300
config.cursor_thickness = 1
config.cursor_blink_rate = 300
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"
config.warn_about_missing_glyphs = false
config.colors = {
  tab_bar = {
    background = "rgba(0,0,0,0)",
    active_tab = {
      fg_color = "#ffd700",
      bg_color = "#000000"
    },
    inactive_tab = {
      fg_color = "#8e8e8e",
      bg_color = "#242424"
    }
  },
}
config.window_frame = {
  font_size = 11,
  font = wezterm.font 'JetBrains Mono Bold'
}
config.inactive_pane_hsb = {
  hue = 1.2,
  saturation = 1.0,
  brightness = 0.4,
}
config.foreground_text_hsb = {
  hue = 1.0,
  saturation = 1.8,
  brightness = 1.5,
}

if wezterm.target_triple:find("windows") ~= nil then
  config.default_domain = 'WSL:Ubuntu'
  config.window_decorations = "RESIZE"
  config.window_padding = {
    left = 10,
    right = 10,
    top = 5,
    bottom = 5,
  }
elseif wezterm.target_triple:find("darwin") ~= nil then
  Alt = 'OPT'
  NonAlt = 'CMD'
  AltAlt = 'CMD'
  config.window_decorations = "RESIZE"
  config.set_environment_variables = {
   PATH = wezterm.home_dir .. "/.fzf/bin:" .. wezterm.home_dir .. "/.cargo/bin:" .. wezterm.home_dir .. "/.local/bin:/usr/bin:/bin:/opt/homebrew/bin:/usr/local/bin",
  }
  config.window_padding = {
    left = 10,
    right = 10,
    top = 5,
    bottom = 2,
  }
else
  config.window_decorations = "RESIZE"
  config.set_environment_variables = {
   PATH = wezterm.home_dir .. "/.fzf/bin:" .. wezterm.home_dir .. "/.cargo/bin:" .. wezterm.home_dir .. "/.local/bin:/usr/bin:/bin:/home/linuxbrew/bin:/home/linuxbrew/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:" .. wezterm.home_dir .. "/go/bin",
  }
  config.window_padding = {
    left = 10,
    right = 10,
    top = 5,
    bottom = 5,
  }
  -- config.front_end = 'Software'
  if Desktop then
    if Desktop:find('hyprland') ~= nil then
      config.enable_wayland  = false
    end
  end
  os_info = read_file("/etc/os-release")
  if os_info then
    if os_info:find("nixos") ~= nil then
      config.front_end="WebGpu"
      config.set_environment_variables = {
        PATH = "/run/wrappers/bin:/run/current-system/sw/bin:" .. wezterm.home_dir .. "/.nix-profile/bin/:/nix/profile/bin:/nix/var/nix/profiles/default/bin:" ..wezterm.home_dir .. "/.local/state/nix/profile/bin:" .. wezterm.home_dir .. "/.cargo/bin:" .. wezterm.home_dir .. "/.local/bin",
      }
    elseif os_info:find("arch") ~= nil then
      config.font = wezterm.font 'JetBrains Mono'
   end
  end
end

config.key_tables = {

  pane_adjust = {
    { key = 'm', action = wezterm.action.AdjustPaneSize { 'Left', 1 } },
    { key = '/', action = wezterm.action.AdjustPaneSize { 'Right', 1 } },
    { key = '.', action = wezterm.action.AdjustPaneSize { 'Up', 1 } },
    { key = ',', action = wezterm.action.AdjustPaneSize { 'Down', 1 } },
    { key = 'h', action = wezterm.action.ActivatePaneDirection 'Left' },
    { key = 'l', action = wezterm.action.ActivatePaneDirection 'Right' },
    { key = 'k', action = wezterm.action.ActivatePaneDirection 'Up' },
    { key = 'j', action = wezterm.action.ActivatePaneDirection 'Down' },
    { key = 'w', action = wezterm.action.CloseCurrentPane { confirm = false } },
    { key = "Space", action = wezterm.action.RotatePanes('Clockwise')},
    {
      key = '-',
      action = wezterm.action.SplitVertical {
          domain = 'CurrentPaneDomain',
      },
    },
    {
      key = '|',
      action = wezterm.action.SplitHorizontal {
          domain = 'CurrentPaneDomain',
      },
    },
    { key = 'Escape', action = 'PopKeyTable' },
  },
  scroll_mode = {
    { key = "Escape", action = 'PopKeyTable' },

    { key = "UpArrow", action = wezterm.action.ScrollByLine(-1) },
    { key = "DownArrow", action = wezterm.action.ScrollByLine(1) },
    { key = "k", action = wezterm.action.ScrollByLine(-1) },
    { key = "j", action = wezterm.action.ScrollByLine(1) },

    { key = "UpArrow", mods = "SHIFT", action = wezterm.action.ScrollByLine(-5) },
    { key = "DownArrow", mods = "SHIFT", action = wezterm.action.ScrollByLine(5) },
    { key = "K", mods = "SHIFT", action = wezterm.action.ScrollByLine(-5) },
    { key = "J", mods = "SHIFT", action = wezterm.action.ScrollByLine(5) },

    { key = "k", mods = "CTRL", action = wezterm.action.ScrollByPage(-0.5) },
    { key = "j", mods = "CTRL", action = wezterm.action.ScrollByPage(0.5) },
    { key = "k", mods = "CTRL|SHIFT", action = wezterm.action.ScrollByPage(-1) },
    { key = "j", mods = "CTRL|SHIFT", action = wezterm.action.ScrollByPage(1) },

    { key = "p", action = wezterm.action.ScrollToPrompt(-1) },
    { key = "n", action = wezterm.action.ScrollToPrompt(1) },
    { key = "{", action = wezterm.action.ScrollToPrompt(-1) },
    { key = "}", action = wezterm.action.ScrollToPrompt(1) },

    { key = "g", action = wezterm.action.ScrollToTop },
    { key = "G", mods = "SHIFT", action = wezterm.action.ScrollToBottom },

    { key = "z", action = wezterm.action.TogglePaneZoomState },

    { key = "y", action = wezterm.action.ActivateCopyMode },
    { key = "/", action = wezterm.action.Search("CurrentSelectionOrEmptyString") },
  },
}

config.keys = {
  {
    key = 'R',
    mods = 'LEADER',
    action = wezterm.action.ReloadConfiguration,
  },
  {
    key = 'p',
    mods = 'LEADER',
    action = wezterm.action.ActivateKeyTable {
        name = 'pane_adjust',
        one_shot = false,
    },
  },
  {
    key = ':',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ActivateKeyTable {
        name = 'scroll_mode',
        one_shot = false,
    },
  },
  {
    key = 'Enter',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.SplitVertical {
        domain = 'CurrentPaneDomain',
    },
  },
  {
    key = '-',
    mods = 'LEADER',
    action = wezterm.action.SplitVertical {
        domain = 'CurrentPaneDomain',
    },
  },
  {
    key = '\\',
    mods = 'LEADER',
    action = wezterm.action.SplitHorizontal {
        domain = 'CurrentPaneDomain',
    },
  },
  {
    key = 'q',
    mods = 'LEADER',
    action = wezterm.action.CloseCurrentPane { confirm = false },
  },
  {
    key = 'Q',
    mods = 'LEADER',
    action = wezterm.action.CloseCurrentTab { confirm = false },
  },
  {
    key = 't',
    mods = 'LEADER',
    action = wezterm.action.SpawnTab 'DefaultDomain'
  },
  {
    key = '"',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.TogglePaneZoomState,
  },
  { key = '{', mods = 'CTRL|SHIFT', action = wezterm.action.MoveTabRelative(-1) },
  { key = '}', mods = 'CTRL|SHIFT', action = wezterm.action.MoveTabRelative(1) },
  { key = "L", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTabRelative(1) },
  { key = "H", mods = "CTRL|SHIFT", action = wezterm.action.ActivateTabRelative(-1) },
  { key = "Tab", mods = Alt, action = wezterm.action.ActivatePaneDirection('Next') },
  { key = "Tab", mods = Alt .. "|SHIFT", action = wezterm.action.ActivatePaneDirection('Prev') },
  { key = "J", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection('Next') },
  { key = "K", mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection('Prev') },
  { key = '+', mods = 'CTRL|SHIFT', action = wezterm.action.IncreaseFontSize },
  { key = '_', mods = 'CTRL|SHIFT', action = wezterm.action.DecreaseFontSize },
  { key = "B", mods = "CTRL|SHIFT", action = wezterm.action{ EmitEvent = "trigger-vim-with-scrollback" } },
  { key = 'U', mods = 'CTRL|SHIFT', action = wezterm.action.ScrollByPage(-1) },
  { key = 'D', mods = 'CTRL|SHIFT', action = wezterm.action.ScrollByPage(1) },
  { key = ')', mods = 'CTRL|SHIFT', action = wezterm.action.ScrollByLine(-1) },
  { key = '(', mods = 'CTRL|SHIFT', action = wezterm.action.ScrollByLine(1) },
  { key = 'k', mods = 'LEADER', action = wezterm.action.ScrollToPrompt(-1) },
  { key = 'j', mods = 'LEADER', action = wezterm.action.ScrollToPrompt(1) },
  { key = 's', mods = 'LEADER', action = wezterm.action.ShowTabNavigator },
  { key = 'C', mods = 'CTRL|SHIFT', action = wezterm.action { EmitEvent = "select-and-paste" } },
  { key = 'm', mods = 'CTRL|SHIFT', action = wezterm.action.AdjustPaneSize { 'Left', 5 } },
  { key = '?', mods = 'CTRL|SHIFT', action = wezterm.action.AdjustPaneSize { 'Right', 5 } },
  { key = '>', mods = 'CTRL|SHIFT', action = wezterm.action.AdjustPaneSize { 'Up', 5 } },
  { key = '<', mods = 'CTRL|SHIFT', action = wezterm.action.AdjustPaneSize { 'Down', 5 } },
  { key = 'c', mods = NonAlt, action = wezterm.action.CopyTo 'ClipboardAndPrimarySelection' },
  { key = 'v', mods = NonAlt, action = wezterm.action.PasteFrom 'Clipboard' },
  { key = 'N', mods = 'LEADER', action = wezterm.action_callback(function(win, pane)
      local tab, window = pane:move_to_new_window()
    end)
  },
  {
    key = 'n',
    mods = 'LEADER',
    action = wezterm.action_callback(function(win, pane)
      local tab, window = pane:move_to_new_tab()
    end),
  },
  {
    key = 'f',
    mods = 'LEADER',
    action = wezterm.action.QuickSelectArgs {
      patterns = {
        '[\\w\\-\\.\\/~]+',
      },
    },
  },
  {
    key = 'f',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.QuickSelectArgs {
      patterns = {
        '\\S+',
      },
    },
  },
  {
    key = 'g',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.QuickSelectArgs {
      patterns = {
        '^([🌵 \\-=>_\\.]{4,5}\\s*)?(.+)'
      },
    },
  },
  {
    key = 'r',
    mods = 'LEADER',
    action = wezterm.action.PromptInputLine {
      description = wezterm.format {
        { Foreground = { Color = '#ffd700' } },
        { Text = 'Rename tab:' },
      },
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          window:active_tab():set_title(line)
        end
      end),
    },
  },
  { key = 'W', mods = 'LEADER', action = wezterm.action.SwitchToWorkspace },
  {
    key = 'S',
    mods = 'LEADER',
    action = wezterm.action.ShowLauncherArgs {
      flags = 'WORKSPACES',
    },
  },
  {
    key = 'w',
    mods = 'LEADER',
    action = wezterm.action.PromptInputLine {
      description = wezterm.format {
        { Foreground = { Color = '#ffd700' } },
        { Text = 'Workspace name:' },
      },
    action = wezterm.action_callback(function(window, pane, line)
      if line then
        window:perform_action(
          wezterm.action.SwitchToWorkspace {
            name = line,
          },
          pane
          )
        end
      end),
    },
  },
  {
    key = "g",
    mods = "LEADER",
    action = wezterm.action.Multiple({
      wezterm.action.CopyMode("ClearPattern"),
      wezterm.action.Search({ CaseSensitiveString = "" }),
    }),
  },
  { key = 'l', mods = 'LEADER', action = wezterm.action.SwitchWorkspaceRelative(1) },
  { key = 'h', mods = 'LEADER', action = wezterm.action.SwitchWorkspaceRelative(-1) },
}

return config
