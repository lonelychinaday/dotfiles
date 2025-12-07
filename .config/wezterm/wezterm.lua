---@diagnostic disable: unused-local, lowercase-global
local wezterm = require("wezterm")
local mux = wezterm.mux

-- function tab_title(tab_info)
-- 	local title = tab_info.tab_title
-- 	-- if the tab title is explicitly set, take that
-- 	if title and #title > 0 then
-- 		return title
-- 	end
-- 	-- Otherwise, use the title from the active pane
-- 	-- in that tab
-- 	return tab_info.active_pane.title
-- end

-- wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
-- 	local title = tab_title(tab)
-- 	if tab.is_active then
-- 		return {
-- 			{ Background = { Color = "blue" } },
-- 			{ Text = " " .. title .. " " },
-- 		}
-- 	end
-- 	if tab.is_last_active then
-- 		-- Green color and append '*' to previously active tab.
-- 		return {
-- 			{ Background = { Color = "green" } },
-- 			{ Text = " " .. title .. "*" },
-- 		}
-- 	end
-- 	return title
-- end)

wezterm.on("format-window-title", function(tab, pane, tabs, panes, config)
	local zoomed = ""
	if tab.active_pane.is_zoomed then
		zoomed = "[Z] "
	end

	local index = ""
	if #tabs > 1 then
		index = string.format("[%d/%d] ", tab.tab_index + 1, #tabs)
	end

	-- return zoomed .. index .. tab.active_pane.title .. ";;;;;"
	return "WezTerm " .. index
end)

wezterm.on("gui-startup", function(cmd)
	-- local tab, pane, window = mux.spawn_window(cmd or {})
	-- window:set_title("Hello World!")
	-- window:set_workspace("something")
	-- local new_pane = pane:split({ size = 0.7 })
	-- pane:split({ size = 0.6, direction = "Bottom" })
end)

-- event
wezterm.on("window-config-reloaded", function(window, pane)
	local id = tostring(window:window_id())
	local seen = wezterm.GLOBAL.seen_windows or {}
	local is_new_window = not seen[id]
	seen[id] = true
	wezterm.GLOBAL.seen_windows = seen
	if is_new_window then
		window:set_position(1285, 630)
	end
end)

config = wezterm.config_builder()

-- `wezterm ls-fonts --list-system`

config = {
	-- 自动重新加载配置
	automatically_reload_config = true,

	-- 动画帧率
	animation_fps = 60,

	-- 前端
	front_end = "WebGpu",
	webgpu_power_preference = "HighPerformance",

	-- 窗口装饰
	window_decorations = "RESIZE", -- RESIZE | TITLE

	-- 标签页
	enable_tab_bar = false,
	hide_tab_bar_if_only_one_tab = true,
	use_fancy_tab_bar = false,
	show_new_tab_button_in_tab_bar = false,
	tab_bar_at_bottom = true,
	tab_max_width = 40,
	show_tab_index_in_tab_bar = false,

	-- 窗口关闭确认
	window_close_confirmation = "NeverPrompt",

	-- 光标样式
	default_cursor_style = "BlinkingBar",
	cursor_thickness = "1.5px",

	-- 配色方案
	color_scheme = "Vs Code Dark+ (Gogh)",

	-- 字体
	font = wezterm.font("JetBrainsMono Nerd Font", { weight = "Medium" }),
	font_size = 12.5,
	-- text_background_opacity = 0.25,

	-- 背景
	-- macos_window_background_blur = 50,
	background = {
		{
			source = {
				Color = "#1F1F1F",
			},
			-- opacity = 0.7,
			width = "100%",
			height = "100%",
		},
	},

	-- 内边距
	window_padding = {
		left = 10,
		right = 10,
		top = 10,
		bottom = 4,
	},

	-- 初始窗口大小
	initial_rows = 40,
	initial_cols = 130,

	leader = { key = "a", mods = "CTRL", timeout_milliseconds = 1000 },

	-- 快捷键
	keys = {
		-- {
		-- 	key = "w",
		-- 	mods = "CMD|SHIFT",
		-- 	action = wezterm.action.CloseCurrentPane({ confirm = false }),
		-- },
	},
}

return config
