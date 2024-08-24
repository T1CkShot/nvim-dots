return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
      { "WhoIsSethDaniel/mason-tool-installer.nvim" },
      { -- nice loading notifications
        -- PERF: but can slow down startup
        "j-hui/fidget.nvim",
        enabled = true,
        opts = {},
      },
    },
    config = function()
      local lspconfig = require("lspconfig")
      local util = require("lspconfig.util")

      require("mason").setup()
      require("mason-lspconfig").setup({
        automatic_installation = true,
      })
      require("mason-tool-installer").setup({
        ensure_installed = {
          "black",
          "stylua",
          "shfmt",
          "isort",
          "tree-sitter-cli",
        },
      })

      local lsp_flags = {
        allow_incremental_sync = true,
        debounce_text_changes = 150,
      }

      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = vim.tbl_deep_extend("force", capabilities, require("cmp_nvim_lsp").default_capabilities())
      capabilities.textDocument.completion.completionItem.snippetSupport = true

      -- lspconfig.r_language_server.setup({
      --   capabilities = capabilities,
      --   flags = lsp_flags,
      --   settings = {
      --     r = {
      --       lsp = {
      --         rich_documentation = false,
      --       },
      --     },
      --   },
      -- })

      lspconfig.cssls.setup({
        capabilities = capabilities,
        flags = lsp_flags,
      })

      lspconfig.html.setup({
        capabilities = capabilities,
        flags = lsp_flags,
      })

      lspconfig.emmet_language_server.setup({
        capabilities = capabilities,
        flags = lsp_flags,
        filetypes = {
          "jsx",
          "tsx",
          "svelte",
          "css",
          "html",
          "astro",
        },
      })

      lspconfig.yamlls.setup({
        capabilities = capabilities,
        flags = lsp_flags,
        settings = {
          yaml = {
            schemaStore = {
              enable = true,
              url = "",
            },
          },
        },
      })

      lspconfig.tsserver.setup({
        capabilities = capabilities,
        flags = lsp_flags,
        filetypes = { "js", "ts", "tsx", "javascript", "typescript", "ojs" },
      })

      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        flags = lsp_flags,
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
            runtime = {
              version = "LuaJIT",
            },
            diagnostics = {
              disable = { "trailing-space" },
            },
            workspace = {
              checkThirdParty = false,
            },
            telemetry = {
              enable = false,
            },
          },
        },
      })

      lspconfig.bashls.setup({
        capabilities = capabilities,
        flags = lsp_flags,
        filetypes = { "sh", "bash" },
      })

      -- Add additional languages here.
      -- See `:h lspconfig-all` for the configuration.
      -- Like e.g. Haskell:
      -- lspconfig.hls.setup {
      --   capabilities = capabilities,
      --   flags = lsp_flags
      -- }

      lspconfig.clangd.setup({
        capabilities = capabilities,
        flags = lsp_flags,
      })

      lspconfig.rust_analyzer.setup({
        capabilities = capabilities,
        settings = {
          ["rust-analyzer"] = {
            diagnostics = {
              enable = true,
            },
          },
        },
      })

      -- See https://github.com/neovim/neovim/issues/23291
      -- disable lsp watcher.
      -- Too lags on linux for python projects
      -- because pyright and nvim both create too many watchers otherwise
      if capabilities.workspace == nil then
        capabilities.workspace = {}
        capabilities.workspace.didChangeWatchedFiles = {}
      end
      capabilities.workspace.didChangeWatchedFiles.dynamicRegistration = false

      lspconfig.pyright.setup({
        capabilities = capabilities,
        flags = lsp_flags,
        settings = {
          python = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = "workspace",
            },
          },
        },
        root_dir = function(fname)
          return util.root_pattern(".git", "setup.py", "setup.cfg", "pyproject.toml", "requirements.txt")(fname)
            or util.path.dirname(fname)
        end,
      })
    end,
  },
}
