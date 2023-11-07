if vim.loader then vim.loader.enable() end
for _, source in ipairs {
    "Gavin.packer",
    "Gavin.keybinds",
    "Gavin.set"
} do
    local status_ok, error_object = pcall(require, source)
    if not status_ok then vim.api.nvim_err_writeln("Failed to load: " .. source .. "\n\n" .. error_object) end
end

