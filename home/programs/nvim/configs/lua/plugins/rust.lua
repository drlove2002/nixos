-- ~/.config/nvim/lua/plugins/rust.lua
return {
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    ft = { "rust" },
    opts = {
      server = {
        on_attach = function(client, bufnr)
          vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
        end,
        default_settings = {
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              buildScripts = {
                enable = true,
              },
            },
            checkOnSave = true,
            check = {
              command = "clippy",
              extraArgs = { "--no-deps" },
              workspace = true, -- ← Scan entire workspace
            },
            -- Enable workspace diagnostics
            diagnostics = {
              enable = true,
              experimental = {
                enable = true,
              },
            },
            procMacro = {
              enable = true,
            },
          },
        },
      },
      dap = {},
    },
  },
  { "saecki/crates.nvim", ft = "toml", opts = {} },
}
