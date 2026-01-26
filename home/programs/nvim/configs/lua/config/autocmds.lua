-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local vimtexGroup = vim.api.nvim_create_augroup("vimtex_events", {})
-- completely frivolous notifications about vimtex compilation progress
--
vim.api.nvim_create_autocmd("User", {
  pattern = "VimtexEventCompileSuccess",
  group = vimtexGroup,
  callback = function()
    vimtexCompileDuration = os.difftime(os.time(), vimtexStartTime)
    local id = MiniNotify.add("VimTex: Compilation finished after " .. tostring(vimtexCompileDuration) .. "s", "INFO")
    vim.defer_fn(function()
      MiniNotify.remove(id)
    end, 2000)
  end,
})

vim.api.nvim_create_autocmd("User", {
  pattern = { "VimtexEventCompileStarted", "VimtexEventCompiling" },
  group = vimtexGroup,
  callback = function()
    local id = MiniNotify.add("VimTex: Compilation started", "INFO")
    vim.defer_fn(function()
      MiniNotify.remove(id)
    end, 2000)
    vimtexStartTime = os.time()
  end,
})
vim.api.nvim_create_autocmd("User", {
  pattern = "VimtexEventCompileFailed",
  group = vimtexGroup,
  callback = function()
    local id = MiniNotify.add("VimTex: Compilation FAILED", "ERROR")
    vim.defer_fn(function()
      MiniNotify.remove(id)
    end, 4000)
  end,
})
