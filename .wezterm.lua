-- Pull in the wezterm API
local wezterm = require "wezterm"

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

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
config.font_size = 14

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
config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = false

return config
