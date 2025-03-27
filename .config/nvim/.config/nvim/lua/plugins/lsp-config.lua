return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      eslint = {},
    },
    inlay_hints = {
      enabled = false,
      -- exclude = { "vue" }, -- filetypes for which you don't want to enable inlay hints
    },
    autoformat = false,
    -- setup = {
    --   eslint = function()
    --     require("lazyvim.util").lsp.on_attach(function(client)
    --       if client.name == "eslint" then
    --         client.server_capabilities.documentFormattingProvider = true
    --       elseif client.name == "tsserver" then
    --         client.server_capabilities.documentFormattingProvider = false
    --       end
    --     end)
    --   end,
    -- },
  },
}
