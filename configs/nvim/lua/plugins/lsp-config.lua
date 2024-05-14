return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "volar",
          "tsserver",
          "eslint",
          "phpactor"
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({
        capabilites = capabilities
      })
      lspconfig.phpactor.setup({
        capabilites = capabilities
      })
      lspconfig.eslint.setup({
        settings = {
          codeActionOnSave = {
            enable = true,
            mode = "all",
          },
        },
        capabilites = capabilities
      })

      local mason_registry = require('mason-registry')
      local vue_language_server_path = mason_registry.get_package('vue-language-server'):get_install_path() .. '/node_modules/@vue/language-server'
      lspconfig.tsserver.setup({
        init_options = {
          plugins = {
            {
              name = '@vue/typescript-plugin',
              location = vue_language_server_path,
              languages = { 'vue' },
            }
          }
        },
        filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
        capabilites = capabilities
      })
      lspconfig.volar.setup({
        capabilites = capabilities
      })
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, {})
    end,
  },
}
