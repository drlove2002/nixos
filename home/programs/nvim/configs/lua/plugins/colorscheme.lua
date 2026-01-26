return {
  { "rebelot/kanagawa.nvim" },
  -- LazyVim's default colorscheme config (optional if you only use Kanagawa)
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "kanagawa", -- Sets the default to Kanagawa
    },
  },
  { "catppuccin/nvim", enabled = false },
  { "folke/tokyonight.nvim", enabled = false },
}
