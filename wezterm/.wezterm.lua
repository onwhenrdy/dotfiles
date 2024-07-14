local wezterm = require("wezterm")
local dotfiles = os.getenv("DOTFILES") or ""

local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.use_fancy_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true

config.default_prog = { "pwsh.exe", "-NoLogo" }

config.font = wezterm.font("JetBrains Mono")
config.font_size = 11
--config.color_scheme = "Ciapre"
config.color_scheme = "Ciapre"
config.default_cursor_style = "BlinkingUnderline"
config.cursor_blink_rate = 500

-- scrollbar
config.scrollback_lines = 3000
config.enable_scroll_bar = false

-- background image
config.background = {
	{
		source = {
			File = dotfiles .. "/art/bg5.png",
		},
		opacity = 1,
		hsb = { brightness = 0.20 },
	},
}

-- Dim inactive panes
config.inactive_pane_hsb = {
  saturation = 0.24,
  brightness = 0.5
}

-- initial size
config.initial_rows = 45
config.initial_cols = 180

-- key bindings
local act = wezterm.action
config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 }
config.keys = {
	{ key = "a",          mods = "LEADER|CTRL", action = act.SendKey { key = "a", mods = "CTRL" } },
	{ key = "c",          mods = "LEADER",      action = act.ActivateCopyMode },
	{ key = "phys:Space", mods = "LEADER",      action = act.ActivateCommandPalette },

	-- Pane keybindings
	{ key = "s",          mods = "LEADER",      action = act.SplitVertical { domain = "CurrentPaneDomain" } },
	{ key = "v",          mods = "LEADER",      action = act.SplitHorizontal { domain = "CurrentPaneDomain" } },
	{ key = "h",          mods = "LEADER",      action = act.ActivatePaneDirection("Left") },
	{ key = "j",          mods = "LEADER",      action = act.ActivatePaneDirection("Down") },
	{ key = "k",          mods = "LEADER",      action = act.ActivatePaneDirection("Up") },
	{ key = "l",          mods = "LEADER",      action = act.ActivatePaneDirection("Right") },
	{ key = "w",          mods = "LEADER",      action = act.CloseCurrentPane { confirm = true } },
	{ key = "z",          mods = "LEADER",      action = act.TogglePaneZoomState },
	{ key = "o",          mods = "LEADER",      action = act.RotatePanes "Clockwise" },
 	{ key = "r",          mods = "LEADER",      action = act.ActivateKeyTable { name = "resize_pane", one_shot = false } },
 	{ key = "h",          mods = "LEADER",      action = act.ReloadConfiguration },

	-- Tab keybindings
	{ key = "t",          mods = "LEADER",      action = act.SpawnTab("CurrentPaneDomain") },
	{ key = ",",          mods = "LEADER",      action = act.ActivateTabRelative(-1) },
	{ key = ".",          mods = "LEADER",      action = act.ActivateTabRelative(1) },
	{ key = "n",          mods = "LEADER",      action = act.ShowTabNavigator },

	{ key = "e", 		  mods = "LEADER",      action = act.PromptInputLine {
		description = wezterm.format {
			{ Attribute = { Intensity = "Bold" } },
			{ Foreground = { AnsiColor = "Fuchsia" } },
			{ Text = "Renaming Tab Title...:" },
		},
		action = wezterm.action_callback(function(window, pane, line)
			if line then
			window:active_tab():set_title(line)
			end
		end)
		}
	},

	-- Key table for moving tabs around
  	{ key = "m", mods = "LEADER", action = act.ActivateKeyTable { name = "move_tab", one_shot = false } },
  	{ key = "[", mods = "LEADER", action = act.MoveTabRelative(-1) },
	{ key = "]", mods = "LEADER", action = act.MoveTabRelative(1) },
}

-- Add keybindings for switching to tabs 1-9
for i = 1, 9 do
  table.insert(config.keys, {
    key = tostring(i),
    mods = "LEADER",
    action = act.ActivateTab(i - 1)
  })
end

-- Key tables
config.key_tables = {
  resize_pane = {
    { key = "h",      action = act.AdjustPaneSize { "Left", 1 } },
    { key = "j",      action = act.AdjustPaneSize { "Down", 1 } },
    { key = "k",      action = act.AdjustPaneSize { "Up", 1 } },
    { key = "l",      action = act.AdjustPaneSize { "Right", 1 } },
    { key = "Escape", action = "PopKeyTable" },
    { key = "Enter",  action = "PopKeyTable" },
  },
  move_tab = {
    { key = "h",      action = act.MoveTabRelative(-1) },
    { key = "j",      action = act.MoveTabRelative(-1) },
    { key = "k",      action = act.MoveTabRelative(1) },
    { key = "l",      action = act.MoveTabRelative(1) },
    { key = "Escape", action = "PopKeyTable" },
    { key = "Enter",  action = "PopKeyTable" },
  }
}

config.use_fancy_tab_bar = false
config.status_update_interval = 1000
config.tab_bar_at_bottom = false

return config
