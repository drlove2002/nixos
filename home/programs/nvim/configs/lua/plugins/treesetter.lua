return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, _)
      vim.filetype.add({
        pattern = {
          [".*/hypr/.*%.conf"] = "hyprlang",
          [".*/hypr/.*%.cfg"] = "hyprlang",
          [".*hyprland.*%.conf"] = "hyprlang",
        },
        extension = {
          hypr = "hyprlang",
        },
      })
    end,
  },
}
