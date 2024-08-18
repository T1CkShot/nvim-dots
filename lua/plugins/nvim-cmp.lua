return {
  "hrsh7th/nvim-cmp",
  opts = function()
    local cmp = require("cmp")
    cmp.setup({
      sources = {
        { name = "path" },
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
        { name = "luasnip",                keyword_length = 3, max_item_count = 3 },
        { name = "buffer",                 keyword_length = 5, max_item_count = 3 },
        { name = "spell" },
        { name = "treesitter",             keyword_length = 5, max_item_count = 3 },
        { name = "calc" },
        { name = "latex_symbols" },
        { name = "emoji" },
      },
      window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
      },
    })
  end,
}
