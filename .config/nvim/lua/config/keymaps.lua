-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.keymap.set('n', 'gd', function()
  -- Jump from an i18n key usage to its definition
  if require('i18n').i18n_definition() then
    return
  end
  -- Jump from current i18n definition to the next locale's definition, following the order in locales
  if require('i18n').i18n_definition_next_locale() then
    return
  end
  -- Fall back to LSP definition
  vim.lsp.buf.definition()
end, { desc = 'i18n or LSP definition' })
