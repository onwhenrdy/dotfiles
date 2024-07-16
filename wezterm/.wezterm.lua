local wezterm = require("wezterm")
local dotfiles = os.getenv("DOTFILES") or ""

local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

local home_dir = os.getenv("HOME") or os.getenv("USERPROFILE")
if home_dir and home_dir:sub(1, 2):upper() == "D:" then
	config.prefer_egl = true
end

config.use_fancy_tab_bar = true
config.tab_max_width = 25
config.status_update_interval = 1000
config.tab_bar_at_bottom = false
config.hide_tab_bar_if_only_one_tab = false
config.window_decorations = "RESIZE"
config.default_prog = { "pwsh.exe", "-NoLogo" }
config.default_workspace = "main"

config.font = wezterm.font("JetBrains Mono")
config.font_size = 11
config.color_scheme = "Monokai Pro Ristretto (Gogh)"
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
		hsb = { brightness = 0.10 },
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
	{ key = "-",          mods = "LEADER",      action = act.SplitVertical { domain = "CurrentPaneDomain" } },
	{ key = "\\",         mods = "LEADER",      action = act.SplitHorizontal { domain = "CurrentPaneDomain" } },
	{ key = "h",          mods = "LEADER",      action = act.ActivatePaneDirection("Left") },
	{ key = "j",          mods = "LEADER",      action = act.ActivatePaneDirection("Down") },
	{ key = "k",          mods = "LEADER",      action = act.ActivatePaneDirection("Up") },
	{ key = "l",          mods = "LEADER",      action = act.ActivatePaneDirection("Right") },
	{ key = "w",          mods = "LEADER",      action = act.CloseCurrentPane { confirm = true } },
	{ key = "z",          mods = "LEADER",      action = act.TogglePaneZoomState },
	{ key = "o",          mods = "LEADER",      action = act.RotatePanes "Clockwise" },
 	{ key = "r",          mods = "LEADER",      action = act.ActivateKeyTable { name = "resize_pane", one_shot = false } },
 	
	-- Hot reloading
	{ key = "=",          mods = "LEADER",      action = act.ReloadConfiguration },

	-- Tab keybindings
	{ key = "t",          mods = "LEADER",      action = act.SpawnTab("CurrentPaneDomain") },
	{ key = ",",          mods = "LEADER",      action = act.ActivateTabRelative(-1) },
	{ key = ".",          mods = "LEADER",      action = act.ActivateTabRelative(1) },
	{ key = "phys:Tab",   mods = "CTRL",        action = act.ActivateTabRelative(1) },
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

  	{ key = "s", mods = "LEADER", action = act.ShowLauncherArgs { flags = "FUZZY|WORKSPACES" } },
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

wezterm.on("update-status", function(window, pane)
  	local stat = window:active_workspace()
  	local stat_color = "#f7768e"
  	local stat_text = " "

	if window:active_key_table() then
    	stat = window:active_key_table()
    	stat_color = "#7dcfff"
  	end
  
	if window:leader_is_active() then
    	stat = "LDR"
    	stat_color = "#bb9af7"
  	end


	local basename = function(s)
		return string.gsub(s, "(.*[/\\])(.*)", "%2")
  	end

	-- Current working directory
	local cwd = pane:get_current_working_dir()
	if cwd then
		if type(cwd) == "userdata" then
		cwd = basename(cwd.file_path)
		else
		cwd = basename(cwd)
		end
	else
		cwd = ""
	end

	-- Time
  	local time = wezterm.strftime("%b-%d %H:%M")
	-- Current command
  	local cmd = pane:get_foreground_process_name()
  	-- CWD and CMD could be nil
  	cmd = cmd and basename(cmd) or ""

  	window:set_left_status(wezterm.format({
		{ Foreground = { Color = stat_color } },
		{ Text = "  " },
		{ Text = wezterm.nerdfonts.oct_table .. "  " .. stat },
		{ Text = " |" },
  	}))

	window:set_right_status(wezterm.format({
		{ Text = wezterm.nerdfonts.md_folder .. "  " .. cwd },
		{ Text = " | " },
		{ Foreground = { Color = "#e0af68" } },
		{ Text = wezterm.nerdfonts.fa_code .. "  " .. cmd },
		"ResetAttributes",
		{ Text = " | " },
		{ Text = wezterm.nerdfonts.md_clock .. "  " .. time },
		{ Text = "  " },
  	}))

end)

return config
