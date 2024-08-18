return {
  "folke/noice.nvim",
  opts = {
    cmdline = {
      enabled = false,
    },
    messages = {
      enabled = false,
    },
    presets = {
      lsp_doc_border = true,
    },
    lsp = {
      -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        ["cmp.entry.get_documentation"] = true,
      },
      hover = {
        silent = true,
      },
    },
  },
}
