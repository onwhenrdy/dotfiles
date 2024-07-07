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
config.font_size = 12

local myColors = wezterm.color.get_default_colors()
myColors.foreground = "black"
myColors.split = "#BAB69C"
myColors.brights = {
	"#ffc107",
	"#ffc107",
	"#ffc107",
	"#ffc107",
	"#ffc107",
	"#ffc107",
	"#ffc107",
	"#ffc107",
}
myColors.foreground = "#ffc107"
myColors.cursor_bg = "#ffc107"
myColors.cursor_border = "#ffc107"
--config.colors = myColors

config.default_cursor_style = "BlinkingUnderline"
config.cursor_blink_rate = 500

-- scrollbar
config.scrollback_lines = 3000
config.enable_scroll_bar = true

-- background image
config.background = {
	{
		source = {
			File = dotfiles .. "/art/bg1.jpg",
		},
		opacity = 0.98,
		hsb = { brightness = 0.10 },
	},
}

-- initial size
config.initial_rows = 45
config.initial_cols = 180

-- key bindings
local act = wezterm.action
config.keys = {
	-- Split the current pane horizontally (new pane below)
	{
		key = "d",
		mods = "CTRL",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	-- Split the current pane vertically (new pane to the right)
	{
		key = "d",
		mods = "ALT",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "d",
		mods = "CTRL|ALT",
		action = wezterm.action.Multiple({
			wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
			wezterm.action.Multiple({
				wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
			}),
		}),
	},
	-- Close the current pane
	{
		key = "w", -- You can change this key to whatever you prefer
		mods = "CTRL",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
	{
		key = "LeftArrow",
		mods = "CTRL|SHIFT",
		action = act.ActivatePaneDirection("Left"),
	},
	{
		key = "RightArrow",
		mods = "CTRL|SHIFT",
		action = act.ActivatePaneDirection("Right"),
	},
	{
		key = "UpArrow",
		mods = "CTRL|SHIFT",
		action = act.ActivatePaneDirection("Up"),
	},
	{
		key = "DownArrow",
		mods = "CTRL|SHIFT",
		action = act.ActivatePaneDirection("Down"),
	},
}

return config
