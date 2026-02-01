return {
  {
    "mrcjkb/rustaceanvim",
    ft = { "rust" },
    opts = {
      dap = {}, -- leave empty; rustaceanvim will use nvim-dap if available
      -- other rustaceanvim options...
    },
  },
  { "saecki/crates.nvim", ft = "toml", opts = {} },
}
