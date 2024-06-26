local M = {}

vim.api.nvim_set_hl(0, 'WinBarPath', { bg = '#44475a', fg = '#b8bed1' })
vim.api.nvim_set_hl(0, 'WinBarModified', { bg = '#3F474C', fg = '#D98483' })

function M.eval()
    local file_path = vim.api.nvim_eval_statusline('%f', {}).str
    local modified = vim.api.nvim_eval_statusline('%M', {}).str == '+' and '⊚' or ''

    file_path = file_path:gsub('/', ' ➤ ')

    return '%#WinBarPath# '
     .. file_path
     .. ' %*'
     .. '%#WinBarModified#'
     .. modified
     .. ' %* '
end

return M
