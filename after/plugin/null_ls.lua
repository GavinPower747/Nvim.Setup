local status_ok, null_ls = pcall(require, 'null-ls')
if not status_ok then
    print('Plugin not loaded: ', 'null-ls')
    return
end

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics
local code_actions = null_ls.builtins.code_actions
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- before adding any new linters/formatters, make sure that you add them
-- to Mason's list of linters_and_formatters. That way they are ensured to
-- be installed and managed through Mason!
null_ls.setup({
    sources = {
        -- Python
        formatting.black.with({
            extra_args = {"--line-length=110"}
        }),
        diagnostics.flake8.with({
            extra_args = {"--max-line-length=110", "--ignore=E501"}
        }),

        -- C#
        formatting.csharpier,

        -- Markdown
        formatting.markdownlint,
        diagnostics.markdownlint,

        -- JSON
        diagnostics.jsonlint,

        -- Misc
        -- add csharp, python etc... for spelling support
        diagnostics.cspell.with({
            filetypes = {"markdown"}
        }),
        code_actions.cspell,
    },

    on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
            vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = augroup,
                buffer = bufnr,
                callback = function()

                    vim.lsp.buf.format()
                end,
            })
        end
    end,
})
