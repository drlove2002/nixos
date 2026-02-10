return {
  -- LazyVim automatically configures LSP for many languages,
  -- but for specific setups like nixd, we create a custom config.
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        nixd = {
          -- LazyVim handles installation via Mason if configured,
          -- but Nix provides the server.
          -- Use 'lazy = true' to manage it via Lazy.nvim's built-in lazy loading [5].
          lazy = true,
          mason = false,
          -- Command to start the server (ensure nixd is in your PATH)
          cmd = { "nixd" },
          -- Filetypes this server should handle
          filetypes = { "nix" },
          -- Optional: Enable LSP folding if your server supports it
          folds = { enabled = true },
          -- Optional: Add specific keymaps for nixd
          keys = {
            { "gd", vim.lsp.buf.definition, desc = "Go to Definition" },
            { "gr", vim.lsp.buf.references, desc = "Go to References" },
            -- Add other useful keymaps as needed
          },
          settings = {
            nixpkgs = {
              expr = "import <nixpkgs> { }",
            },
            formatting = {
              command = { "alejandra" },
            },
            options = {
              nixos = {
                expr = '(builtins.getFlake ("git+file://" + toString ./.)).nixosConfigurations.k-on.options',
              },
              home_manager = {
                expr = '(builtins.getFlake ("git+file://" + toString ./.)).homeConfigurations."ruixi@k-on".options',
              },
            },
          },
        },
        pyright = {
          -- Example configuration for another LSP server
          settings = {
            python = {
              analysis = {
                diagnosticMode = "workspace",
                typeCheckingMode = "basic",
                reportOptionalMemberAccess = "none",
                reportUnionMemberAccess = "none",
                reportInvalidStringEscapeSequence = false,
                reportPropertyTypeMismatch = true,
                reportDuplicateImport = true,
                reportUntypedFunctionDecorator = true,
                reportUntypedClassDecorator = true,
                reportUntypedBaseClass = true,
                reportUntypedNamedTuple = true,
                reportUnknownLambdaType = true,
                reportInvalidTypeVarUse = true,
                reportUnnecessaryCast = true,
                reportSelfClsParameterName = true,
                reportUnsupportedDunderAll = true,
                reportUnusedVariable = true,
                reportUnnecessaryComparison = true,
                reportUnnecessaryTypeIgnoreComment = true,
              },
            },
          },
          capabilities = {
            textDocument = {
              publishDiagnostics = {
                tagSupport = {
                  valueSet = { 2 },
                },
              },
            },
          },
        },
      },
    },
  },
}
