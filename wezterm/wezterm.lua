-- Pull in the wezterm API
local wezterm = require 'wezterm'

local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true


config.default_prog = { 'pwsh.exe', '-NoLogo' }

config.color_scheme = 'Tokyo Night'
config.font = wezterm.font('JetBrains Mono')
config.font_size =11

-- scrollbar
config.scrollback_lines = 3000
config.enable_scroll_bar = true
config.default_cursor_style = 'BlinkingBar'

-- background image
config.background = {
    {
        source = {
            File = "D:/Wallpaper/Lost-in-Translation1.jpg",
        },
        opacity = 0.85,
        hsb = { brightness = 0.1 },
    },
}

-- initial size
config.initial_rows = 50
config.initial_cols = 200


-- key bindings
local act = wezterm.action
config.keys = {
   -- shortcuts for directory navigation
   {
    key = 'S',
    mods = 'CTRL|SHIFT',
    action = wezterm.action_callback(function(window, pane)
      -- Here you can dynamically construct a longer list if needed

      local home = wezterm.home_dir
      local workspaces = {
        { id = home, label = 'Home' },
        { id = home .. '/work', label = 'Work' },
        { id = home .. '/personal', label = 'Personal' },
        { id = home .. '/.config', label = 'Config' },
      }

      window:perform_action(
        act.InputSelector {
          action = wezterm.action_callback(
            function(inner_window, inner_pane, id, label)
              if not id and not label then
                wezterm.log_info 'cancelled'
              else
                wezterm.log_info('id = ' .. id)
                wezterm.log_info('label = ' .. label)
                inner_window:perform_action(
                  act.SwitchToWorkspace {
                    name = label,
                    spawn = {
                      label = 'Workspace: ' .. label,
                      cwd = id,
                    },
                  },
                  inner_pane
                )
              end
            end
          ),
          title = 'Choose Workspace',
          choices = workspaces,
          fuzzy = true,
          fuzzy_description = 'Fuzzy find and/or make a workspace',
        },
        pane
      )
    end),
  },
  -- Split the current pane horizontally (new pane below)
  {
    key = "d",
    mods = "CTRL",
    action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" },
  },
  -- Split the current pane vertically (new pane to the right)
  {
    key = "d",
    mods = "ALT",
    action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" },
  },
  -- Close the current pane
  {
    key = "w", -- You can change this key to whatever you prefer
    mods = "CTRL",
    action = wezterm.action.CloseCurrentPane { confirm = true },
  },
}

return config