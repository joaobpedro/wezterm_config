-- Pull in the wezterm API
local wezterm = require "wezterm"

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end
config.window_background_opacity = 0.9

-- windows specific config
-- Detect if running on Windows
local is_windows = wezterm.target_triple:find("windows") ~= nil

if is_windows then
    -- Only set PowerShell as default on Windows
    config.default_prog = { 'pwsh.exe', '-NoLogo' }
    
    -- Optional: Add specific Windows shells to the launch menu
    config.launch_menu = {
        { label = 'PowerShell 7', args = { 'pwsh.exe', '-NoLogo' } },
        { label = 'Windows PowerShell', args = { 'powershell.exe', '-NoLogo' } },
    }
else
    -- Linux-specific settings (optional)
    -- On Linux, WezTerm defaults to your user's shell (e.g., bash/zsh)
end

--
-- !!!!!!!!!!!!!!!!!!!!!!!!!!!!

local tab_style = "square"

config.font =
    wezterm.font_with_fallback { "BerkeleyMono Nerd Font", "BerkeleyMono Nerd Font" }
config.font_size = 13

config.window_decorations = "RESIZE"

local color_scheme = "DjangoRebornAgain"
config.color_scheme = color_scheme

-- shortcut_configuration
config.leader = { key = "q", mods = "ALT", timeout_milliseconds = 2000 }
config.keys = {
    {
        mods = "LEADER",
        key = "t",
        action = wezterm.action.SpawnTab "CurrentPaneDomain",
    },
    {
        mods = "LEADER",
        key = "c",
        action = wezterm.action.CloseCurrentPane { confirm = true }
    },
    {
        mods = "LEADER",
        key = "p",
        action = wezterm.action.ActivateTabRelative(-1)
    },
    {
        mods = "LEADER",
        key = "n",
        action = wezterm.action.ActivateTabRelative(1)
    },
    {
        mods = "LEADER",
        key = "|",
        action = wezterm.action.SplitHorizontal { domain = "CurrentPaneDomain" }
    },
    {
        mods = "LEADER",
        key = "-",
        action = wezterm.action.SplitVertical { domain = "CurrentPaneDomain" }
    },
    {
        mods = "LEADER",
        key = "h",
        action = wezterm.action.ActivatePaneDirection "Left"
    },
    {
        mods = "LEADER",
        key = "j",
        action = wezterm.action.ActivatePaneDirection "Down"
    },
    {
        mods = "LEADER",
        key = "k",
        action = wezterm.action.ActivatePaneDirection "Up"
    },
    {
        mods = "LEADER",
        key = "l",
        action = wezterm.action.ActivatePaneDirection "Right"
    },
    {
        mods = "LEADER",
        key = "LeftArrow",
        action = wezterm.action.AdjustPaneSize { "Left", 5 }
    },
    {
        mods = "LEADER",
        key = "RightArrow",
        action = wezterm.action.AdjustPaneSize { "Right", 5 }
    },
    {
        mods = "LEADER",
        key = "DownArrow",
        action = wezterm.action.AdjustPaneSize { "Down", 5 }
    },
    {
        mods = "LEADER",
        key = "UpArrow",
        action = wezterm.action.AdjustPaneSize { "Up", 5 }
    },
}

for i = 1, 9 do
    -- leader + number to activate that tab
    table.insert(config.keys, {
        key = tostring(i),
        mods = "ALT",
        action = wezterm.action.ActivateTab(i-1),
    })
end

-- tab bar
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = false

config.colors = {
  background = '#000000',
  foreground = '#C1C497',
  
  -- Cursor colors
  cursor_bg = '#D7C995',
  cursor_fg = '#000000',
  cursor_border = '#D7C995',

  -- Selection colors (when you highlight text)
  selection_bg = '#C1C497',
  selection_fg = '#111C18',
  
  -- The dark accents for the terminal blacks/greys
  ansi = {
    '#23372B', -- Black (Color 0)
    '#cc0000', -- Red (Replace with your preferred red)
    '#4e9a06', -- Green (Replace with your preferred green)
    '#c4a000', -- Yellow (Replace with your preferred yellow)
    '#3465a4', -- Blue (Replace with your preferred blue)
    '#75507b', -- Magenta (Replace with your preferred magenta)
    '#06989a', -- Cyan (Replace with your preferred cyan)
    '#d3d7cf', -- White (Replace with your preferred white)
  },
  brights = {
    '#53685B', -- Bright Black / Grey (Color 8)
    '#ef2929', -- Bright Red
    '#8ae234', -- Bright Green
    '#fce94f', -- Bright Yellow
    '#729fcf', -- Bright Blue
    '#ad7fa8', -- Bright Magenta
    '#34e2e2', -- Bright Cyan
    '#eeeeec', -- Bright White
  },
  tab_bar = {
    -- The background color of the tab bar itself (Deep Jade)
    background = '#000000',

    -- The active tab (Dark Forest Green background, Golden Sand text)
    active_tab = {
      bg_color = '#23372B',
      fg_color = '#D7C995',
    },

    -- Inactive tabs (Deep Jade background, Muted Sage Green text)
    inactive_tab = {
      bg_color = '#000000',
      fg_color = '#53685B',
    },

    -- When you hover over an inactive tab with your mouse
    inactive_tab_hover = {
      bg_color = '#53685B',
      fg_color = '#111C18',
    },

    -- The "+" button to create a new tab
    new_tab = {
      bg_color = '#111C18',
      fg_color = '#C1C497',
    },

    -- When you hover over the new tab button
    new_tab_hover = {
      bg_color = '#53685B',
      fg_color = '#111C18',
    },
}
}

-- config.window_padding = {
--   left = 0,
--   right = 0,
--   top = 0,
--   bottom = 0, -- Forces no extra padding above the bottom tab bar
-- }

config.use_resize_increments =  true


return config

