-- Set colorscheme on start
local function get_neovim_theme(gtk_theme)
  local theme_map = {
    ["Tokyo-Night"] = "tokyonight-storm",
    ["Gruvbox-Retro"] = "gruvbox",
    ["Rose-Pine"] = "rose-pine",
    ["Catppuccin-Mocha"] = "catppuccin-mocha",
    ["Graphite-Mono"] = "warlock",
    ["Dracula"] = "dracula",
    ["Onedark"] = "onedark"
  }

  return theme_map[gtk_theme] or "gruvbox"
end

local function get_gtk_theme()
  local handle = io.popen("gsettings get org.gnome.desktop.interface gtk-theme")
  local result = handle:read("*a")
  handle:close()
  return result:match("'(.-)'")
end

local gtk_theme = get_gtk_theme()
local neovim_theme = get_neovim_theme(gtk_theme)

return {
  "folke/tokyonight.nvim",
  "ellisonleao/gruvbox.nvim",
  "catppuccin/nvim",
  "rose-pine/neovim",
  "hardselius/warlock",
  "dracula/vim",
  "navarasu/onedark.nvim",
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = neovim_theme,
      transparent = false,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
}
