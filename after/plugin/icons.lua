local web_dev_icons_ok, web_dev_icons = pcall(require, "nvim-web-devicons")
if not web_dev_icons_ok then
    print("Couldn't find web devicons ")
    return
end

local material_icons_ok, material_icons = pcall(require, "nvim-material-icon")
if not material_icons_ok then
    print("Couldn't find  material icons")
    return
end

web_dev_icons.setup({
    override = material_icons.get_icons()
})

material_icons.setup({
    color_icons = true;
    default = true;
})
