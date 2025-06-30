local wezterm = require 'wezterm'
local io = require 'io';
local os = require 'os';
local config = {}

local resurrect = wezterm.plugin.require("https://github.com/MLFlexer/resurrect.wezterm")
wezterm.on("gui-startup", resurrect.state_manager.resurrect_on_gui_startup)
resurrect.state_manager.periodic_save({
    interval_seconds = 300,
    save_tabs = true,
    save_windows = true,
    save_workspaces = true,
})
resurrect.state_manager.set_max_nlines(5000)

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
    args={ 'nvim', '+', name }
    }
  }, pane)

  wezterm.sleep_ms(1000);
  os.remove(name);
end)

wezterm.on('update-right-status', function(window, pane)
  local name = window:active_key_table()
  if name then
    name = 'TABLE: ' .. name .. '  '
  else
    name = 'WINDOW: ' .. window:active_workspace() .. '  '
  end
  window:set_right_status(wezterm.format {
        { Foreground = { Color = '#f6cd61' } },
        { Text = name },
      })
end)

wezterm.on('select-and-paste', function(window, pane)
  wezterm.action.QuickSelectArgs {
   patterns = {
      '[\\w\\-\\.\\/~]+',
    },
  }
  wezterm.action.PasteFrom 'Clipboard'
end)

function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

function log_table(t)
  print(dump(t))
end

Alt = 'ALT'
NonAlt = 'META'
AltAlt = 'ALT'
Desktop = os.getenv("DESKTOP_SESSION")

local ansi_highlight = "#ffd700"
local bright_highlight = "#f6cd61"
local name = 'Grayscale (dark) (terminal.sexy)'
local whitish = wezterm.color.get_builtin_schemes()[name]
whitish.background = "#000000"
whitish.cursor_bg = ansi_highlight
whitish.cursor_border = ansi_highlight
whitish.foreground = "#ffffff"
whitish.selection_bg = "#ffffff"
whitish.brights[4] = ansi_highlight
whitish.ansi[4] = bright_highlight
whitish.brights[6] = "#cccccc"
whitish.ansi[6] = "#eeeeee"
whitish.brights[5] = "#cccccc"
whitish.ansi[5] = "#eeeeee"
config.color_schemes = {
  [name] = whitish
}
log_table(whitish)

config.disable_default_key_bindings = true
config.animation_fps = 30
config.max_fps = 144
config.font = wezterm.font 'JetBrains Mono'
config.font_size = 10
config.enable_scroll_bar = false
config.color_scheme = name
config.leader = { key = 'Space', mods = 'CTRL', timeout_milliseconds = 1000 }
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

config.font_rules = {
  {
    intensity = "Bold",
    italic = false,
    font = wezterm.font("JetBrains Mono", { weight = "Bold", stretch = "Normal", style = "Normal" }),
  },
  {
    intensity = "Bold",
    italic = true,
    font = wezterm.font("JetBrains Mono", { weight = "Bold", stretch = "Normal", style = "Italic" }),
  },
}

config.colors = {
  tab_bar = {
    background = "rgba(0,0,0,0)",
    active_tab = {
      fg_color = "#f6cd61",
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
  font = wezterm.font 'JetBrains Mono'
}
config.inactive_pane_hsb = {
  hue = 1.0,
  saturation = 0.3,
  brightness = 0.8,
}

-- config.active_pane_hsb = {
--   hue = 1.0,
--   saturation = 1.0,
--   brightness = 2.0,
-- }
if wezterm.target_triple:find("windows") ~= nil then
  config.default_domain = 'WSL:Arch'
  config.window_decorations = "RESIZE"
  config.window_frame = {
    font_size = 9,
    font = wezterm.font 'JetBrains Mono'
  }
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
    mods = 'CTRL|SHIFT',
    action = wezterm.action.ReloadConfiguration,
  },
  {
    key = 'P',
    mods = 'CTRL|SHIFT',
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
    key = 'v',
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
    key = 'h',
    mods = 'LEADER',
    action = wezterm.action.SplitHorizontal {
        domain = 'CurrentPaneDomain',
    },
  },

  {
    key = 'Q',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.CloseCurrentPane { confirm = true },
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
    key = 'T',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.SpawnTab 'CurrentPaneDomain'
  },
  {
    key = 'S',
    mods = 'LEADER',
    action = wezterm.action_callback(function(window, pane)
      local choices = {}
      if wezterm.target_triple:find("windows") ~= nil then
        local wsl_doms = wezterm.default_wsl_domains()
        for _, dom in ipairs(wsl_doms) do
          table.insert(choices, { id = dom.distribution, label = dom.name })
        end
        table.insert(choices, { id = 'local', label = 'local' })
        wezterm.log_info(choices)
      else
        local shells = io.open("/etc/shells", "r"):read("*all")
        for _, shell in ipairs({ 'bash', 'fish', 'zsh', 'sh', 'powershell', 'pwsh', 'nu' }) do
          for line in shells:gmatch("([^\n]*)\n?") do
            if string.find(line, "/" .. shell) then
              table.insert(choices, { id = line, label = shell })
              break
            end
          end
        end
        wezterm.log_info(choices)
      end
      window:perform_action(
        wezterm.action.InputSelector {
          action = wezterm.action_callback(function(inner_window, inner_pane, id, label)
            if not id and not label then
              wezterm.log_info 'Cancelled'
            elseif label == 'local' and wezterm.target_triple:find("windows") ~= nil then
              inner_window:perform_action(
                wezterm.action.SpawnCommandInNewTab {
                  domain = { DomainName = 'local' },
                  args = { 'powershell' }
                },
                inner_pane
              )
            elseif wezterm.target_triple:find("windows") ~= nil then
              inner_window:perform_action(
                wezterm.action.SpawnTab {
                  DomainName = label,
                },
              inner_pane
              )
            else
              inner_window:perform_action(
                wezterm.action.SpawnCommandInNewTab {
                  domain = { DomainName = 'local' },
                  args = { id }
                },
                inner_pane
              )
            end
          end),
          title = 'Domain',
          choices = choices,
        },
        pane
      )
    end),
  },

  {
    key = '"',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.TogglePaneZoomState,
  },

  { key = '{', mods = 'CTRL|SHIFT', action = wezterm.action.MoveTabRelative(-1) },
  { key = '}', mods = 'CTRL|SHIFT', action = wezterm.action.MoveTabRelative(1) },
  { key = 'L', mods = "CTRL|SHIFT", action = wezterm.action.ActivateTabRelative(1) },
  { key = 'H', mods = "CTRL|SHIFT", action = wezterm.action.ActivateTabRelative(-1) },
  { key = 'Tab', mods = AltAlt, action = wezterm.action.ActivatePaneDirection('Next') },
  { key = 'Tab', mods = AltAlt .. "|SHIFT", action = wezterm.action.ActivatePaneDirection('Prev') },
  { key = 'J', mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection('Next') },
  { key = 'K', mods = "CTRL|SHIFT", action = wezterm.action.ActivatePaneDirection('Prev') },
  { key = '+', mods = 'CTRL|SHIFT', action = wezterm.action.IncreaseFontSize },
  { key = '_', mods = 'CTRL|SHIFT', action = wezterm.action.DecreaseFontSize },
  { key = 'e', mods = "LEADER", action = wezterm.action{ EmitEvent = "trigger-vim-with-scrollback" } },
  { key = 'd', mods = 'LEADER', action = wezterm.action.ShowDebugOverlay },
  { key = 'U', mods = 'CTRL|SHIFT', action = wezterm.action.ScrollByPage(-0.5) },
  { key = 'D', mods = 'CTRL|SHIFT', action = wezterm.action.ScrollByPage(0.5) },
  { key = ')', mods = 'CTRL|SHIFT', action = wezterm.action.ScrollByLine(-1) },
  { key = '(', mods = 'CTRL|SHIFT', action = wezterm.action.ScrollByLine(1) },
  { key = 'k', mods = 'LEADER', action = wezterm.action.ScrollToPrompt(-1) },
  { key = 'j', mods = 'LEADER', action = wezterm.action.ScrollToPrompt(1) },
  { key = 't', mods = 'LEADER', action = wezterm.action.ShowTabNavigator },
  { key = 'C', mods = 'CTRL|SHIFT', action = wezterm.action { EmitEvent = "select-and-paste" } },
  { key = 'm', mods = 'CTRL|SHIFT', action = wezterm.action.AdjustPaneSize { 'Left', 5 } },
  { key = '?', mods = 'CTRL|SHIFT', action = wezterm.action.AdjustPaneSize { 'Right', 5 } },
  { key = '>', mods = 'CTRL|SHIFT', action = wezterm.action.AdjustPaneSize { 'Up', 5 } },
  { key = '<', mods = 'CTRL|SHIFT', action = wezterm.action.AdjustPaneSize { 'Down', 5 } },
  { key = 'c', mods = AltAlt, action = wezterm.action.CopyTo 'ClipboardAndPrimarySelection' },
  { key = 'v', mods = AltAlt, action = wezterm.action.PasteFrom 'Clipboard' },

  {
    key = 'M',
    mods = 'LEADER',
    action = wezterm.action.PromptInputLine {
      description = wezterm.format {
        { Foreground = { Color = '#f6cd61' } },
        { Text = 'Workspace name:' },
      },
      action = wezterm.action_callback(function(win, pane, line)
        if line then
          local tab, window = pane:move_to_new_window(line)
          win:perform_action(
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
    key = 'm',
    mods = 'LEADER',
    action = wezterm.action_callback(function(win, pane)
      local tab, window = pane:move_to_new_tab()
    end),
  },

  {
    key = 'f',
    mods = 'CTRL|SHIFT',
    action = wezterm.action.QuickSelectArgs {
      patterns = {
        '[\\w\\-\\.\\/~]+',
      },
    },
  },
  {
    key = 'f',
    mods = 'LEADER',
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
    key = 'g',
    mods = 'LEADER',
    action = wezterm.action_callback(function(window, pane)
      local temp_dir = '/tmp'
      local handle = io.popen("mkdir -p /tmp/shsesh/; mktemp -d /tmp/shsesh/$(basename $(echo $SHELL))-XXXXXX", "r")
      if handle then
        temp_dir = handle:read("*a")
        handle:close()
      end
      temp_dir = string.gsub(temp_dir, '^%s+', '')
      temp_dir = string.gsub(temp_dir, '%s+$', '')
      temp_dir = string.gsub(temp_dir, '[\n\r]+', ' ')
      window:perform_action(
        wezterm.action.SwitchToWorkspace {
          name = temp_dir,
          spawn = {
            domain = "CurrentPaneDomain",
            cwd = temp_dir,
          },
        },
        pane
      )
      end),
  },

  {
    key = 'R',
    mods = 'LEADER',
    action = wezterm.action.PromptInputLine {
      description = wezterm.format {
        { Foreground = { Color = '#f6cd61' } },
        { Text = 'Rename workspace:' },
      },
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          wezterm.mux.rename_workspace(
            wezterm.mux.get_active_workspace(),
            line
          )
        end
        window:set_right_status(window:active_workspace())
      end),
    },
  },
  {
    key = 'r',
    mods = 'LEADER',
    action = wezterm.action.PromptInputLine {
      description = wezterm.format {
        { Foreground = { Color = '#f6cd61' } },
        { Text = 'Rename tab:' },
      },
      action = wezterm.action_callback(function(window, pane, line)
        if line then
          window:active_tab():set_title(line)
        end
      end),
    },
  },

  {
    key = 's',
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
        { Foreground = { Color = '#f6cd61' } },
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
    key = '/',
    mods = "LEADER",
    action = wezterm.action.Multiple({
      wezterm.action.CopyMode("ClearPattern"),
      wezterm.action.Search({ CaseSensitiveString = "" }),
    }),
  },

  { key = 'N', mods = 'CTRL|SHIFT', action = wezterm.action_callback(function(window, pane, line)
      window:perform_action(wezterm.action.SwitchWorkspaceRelative(1), pane)
      window:update_right_status(window:active_workspace())
    end),
  },
  { key = 'B', mods = 'CTRL|SHIFT', action = wezterm.action_callback(function(window, pane, line)
      window:perform_action(wezterm.action.SwitchWorkspaceRelative(-1), pane)
      window:update_right_status(window:active_workspace())
    end),
  },

  {
    key = 'P',
    mods = "LEADER",
    action = wezterm.action_callback(function(win, pane)
        resurrect.state_manager.save_state(resurrect.workspace_state.get_workspace_state())
      end),
  },
  {
    key = 'W',
    mods = "LEADER",
    action = resurrect.window_state.save_window_action(),
  },
  {
    key = 'T',
    mods = "LEADER",
    action = resurrect.tab_state.save_tab_action(),
  },
  {
    key = 'p',
    mods = "LEADER",
    action = wezterm.action_callback(function(win, pane)
        resurrect.state_manager.save_state(resurrect.workspace_state.get_workspace_state())
        resurrect.window_state.save_window_action()
      end),
  },

  {
    key = 'L',
    mods = "LEADER",
    action = wezterm.action_callback(function(win, pane)
      resurrect.fuzzy_loader.fuzzy_load(win, pane, function(id, label)
        local type = string.match(id, "^([^/]+)") -- match before '/'
        id = string.match(id, "([^/]+)$") -- match after '/'
        id = string.match(id, "(.+)%..+$") -- remove file extention
        local opts = {
          relative = true,
          restore_text = true,
          on_pane_restore = resurrect.tab_state.default_on_pane_restore,
        }
        if type == "workspace" then
          local opts = {
            close_open_tabs = true,
            window = pane:window(),
            on_pane_restore = resurrect.tab_state.default_on_pane_restore,
            relative = true,
            restore_text = true,
          }
          local state = resurrect.state_manager.load_state(id, "workspace")
          resurrect.workspace_state.restore_workspace(state, opts)
        elseif type == "window" then
          local opts = {
            close_open_tabs = true,
            window = pane:window(),
            on_pane_restore = resurrect.tab_state.default_on_pane_restore,
            relative = true,
            restore_text = true,
          }
          local state = resurrect.state_manager.load_state(id, "window")
          resurrect.window_state.restore_window(pane:window(), state, opts)
        elseif type == "tab" then
          local state = resurrect.state_manager.load_state(id, "tab")
          resurrect.tab_state.restore_tab(pane:tab(), state, opts)
        end
      end)
    end),
  },

}

return config
