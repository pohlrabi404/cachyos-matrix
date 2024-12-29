local luasnip = {
  "L3MON4D3/LuaSnip",
  build = "make install_jsregexp",
  dependencies = {
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets",
  },
  event = { "InsertEnter" },
  config = function()
    local ls = require("luasnip")
    local jupytersnip = require("jupyter.snippet.jupyter-auto")
    ls.add_snippets("all", jupytersnip, { type = "autosnippets", key = "all_auto" })
    local s = ls.snippet
    local t = ls.text_node

    ls.add_snippets("all", {
      s("autotrigger", {
        t("autosnippet"),
      }),
    }, {
      type = "autosnippets",
      key = "all_auto",
    })
  end,
}
return { luasnip }
