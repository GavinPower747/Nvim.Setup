local dap_status_ok, dap = pcall(require, 'dap')
if not dap_status_ok then
    print('Plugin not loaded: ', 'nvim-dap')
    return
end
local dap_ui_status_ok, dapui = pcall(require, 'dapui')
local dap_virtual_status_ok, dap_virtual_text = pcall(require, 'nvim-dap-virtual-text')

local getMonoPath = function()
    local f = assert(io.popen('which mono', 'r')) local s = assert(f:read('*a'))
    f:close()
    s = s:gsub('^%s*(.-)%s*$', '%1') -- trim

    if s == '' then
        return nil
    end

    return s
end

local dap_python_status_ok, dap_python = pcall(require, 'dap-python')
local dap_go_status_ok, dap_go = pcall(require, 'dap-go')

vim.keymap.set('n', '<F5>', ":lua require'dap'.continue()<CR>")
vim.keymap.set('n', '<C-F5>', ":lua require'dap'.disconnect({ terminateDebuggee = true })<CR>:lua require'dapui'.close()<CR>")
vim.keymap.set('n', '<F10>', ":lua require'dap'.step_over()<CR>")
vim.keymap.set('n', '<F11>', ":lua require'dap'.step_into()<CR>")
vim.keymap.set('n', '<F12>', ":lua require'dap'.step_out()<CR>")
vim.keymap.set('n', '<leader>db', ":lua require'dap'.toggle_breakpoint()<CR>")
vim.keymap.set('n', '<leader>dB', ":lua require'dap'.set_breakpoint(vim.fn.input('breakpoint condition: '))<CR>")

if not dap_virtual_status_ok then
    print('Plugin not loaded: ', 'nvim-dap-virtual-text')
else
    dap_virtual_text.setup()
end

if not dap_ui_status_ok then
    print('Plugin not loaded: ', 'nvim-dap-ui')
    return
end

dap.adapters.unity = {
    type = 'executable',
    command = getMonoPath(),
    args = { os.getenv('HOME') .. '/.UnityDbg/bin/UnityDebug.exe' }
}

dap.configurations.cs = {
    {
        type = 'unity',
        request = 'attach',
        name = 'Unity Editor',
        path = 'Library/EditorInstance.json'
    }
}

dapui.setup({
    expand_lines = true,
    mappings = {
        -- Use a table to apply multiple mappings
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        edit = "e",
        repl = "K",
        toggle = "t",
    },
    layouts = {
        {
            elements = {
                -- Elements can be strings or table with id and size keys.
                "breakpoints",
                "stacks",
                "watches",
            },
            size = 50, -- 40 columns
            position = "left",
        },
        {
            elements = {
                { id = "console", size = 0.50},
                { id = "scopes", size = 0.50},
            },
            size = 0.25, -- 25% of total lines
            position = "bottom",
        },
    },
    windows = { indent = 1 },
    render = {
        max_type_length = nil, -- Can be integer or nil.
        max_value_lines = 100, -- Can be integer or nil.
    }
})

dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end

if not dap_python_status_ok then
    print('Plugin not loaded: ', 'nvim-dap-python')
else
    vim.keymap.set('n', '<leader>dn', ':lua require("dap-python").test_method()<CR>')
    vim.keymap.set('n', '<leader>df', ':lua require("dap-python").test_class()<CR>')
    vim.keymap.set('v', '<leader>ds', '<ESC>:lua require("dap-python").debug_selection()<CR>')
    vim.keymap.set({'n', 'v'}, '<leader>dr', ':lua require("dapui").eval()<CR>')
    -- uses global instance of python3
    -- (better use virtualenv's python executable!)
    dap_python.setup('python3')
end

if not dap_go_status_ok then
    print('Plugin not loaded: ', 'nvim-dap-go')
else
    vim.keymap.set('n', '<leader>dn', ':lua require("dap-go").test_method()<CR>')
    vim.keymap.set('n', '<leader>df', ':lua require("dap-go").test_class()<CR>')
    vim.keymap.set('v', '<leader>ds', '<ESC>:lua require("dap-go").debug_selection()<CR>')
    vim.keymap.set({'n', 'v'}, '<leader>dr', ':lua require("dapui").eval()<CR>')

--    dap_go.setup('go')
end
