--snippets; vital for TeX
return {
  "L3MON4D3/LuaSnip",
  -- follow latest release.
  version = "v2.*",
  build = "make install_jsregexp",
  event = "InsertEnter",
  config = function()
    require("luasnip.loaders.from_lua").lazy_load({ paths = "./lua/luasnip/" })
    local ls = require("luasnip")
    local types = require("luasnip.util.types")
    ls.setup({
      update_events = { "TextChanged", "TextChangedI" },
      enable_autosnippets = true,
      store_selection_keys = "<Tab>",
      --add some virtual text for active choice nodes and active/passive insert nodes
      ext_opts = {
        [types.choiceNode] = {
          active = { virt_text = { { "●", "NotifyWarnTitle" } } },
        },
        [types.insertNode] = {
          active = { virt_text = { { "●", "NotifyInfoTitle" } } },
          passive = { virt_text = { { "●", "NotifyHintTitle" } } },
        },
      },
    })
    vim.keymap.set({ "i" }, "<C-k>", function()
      ls.expand()
    end, { silent = true, desc = "expand autocomplete" })
    vim.keymap.set({ "i", "s" }, "<C-j>", function()
      ls.jump(1)
    end, { silent = true, desc = "next autocomplete" })
    vim.keymap.set({ "i", "s" }, "<C-L>", function()
      ls.jump(-1)
    end, { silent = true, desc = "previous autocomplete" })

    vim.keymap.set({ "i", "s" }, "<C-h>", function()
      if ls.choice_active() then
        ls.change_choice(1)
      end
    end, { silent = true, desc = "cycle through choice nodes" })

    vim.keymap.set({ "i", "s" }, "<C-y>", function()
      ls.unlink_current()
    end, { silent = true, desc = "use this to leave choice node" })
    --currently prefer a ui.select option rather than the window
    vim.keymap.set(
      { "i", "s" },
      "<C-z>",
      "<cmd>lua require('luasnip.extras.select_choice')()<cr>",
      { noremap = true, desc = "ui select for choice node" }
    )
  end,
}
