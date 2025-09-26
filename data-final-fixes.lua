local BLOOSH = "__base__/graphics/icons/blueprint.png"
local BLOOSH2 = "__zzz-bloosh-goosh__/bloosh.png"
local GOOSH = 64

--Bloosh goosh
local function bloosh_goosh(prototype)
    prototype.icons = nil
    prototype.icon = BLOOSH
    prototype.icon_size = GOOSH

    if defines.prototypes.item[prototype.type or ""] then
        prototype.pictures = nil
    end

    --Bloosh goosh
    if prototype.type == "space-location" or prototype.type == "planet" then
        prototype.starmap_icons = nil
        prototype.starmap_icon = BLOOSH
        prototype.starmap_icon_size = GOOSH
    end
end

--Bloosh goosh
local subtypes = {"technology", "recipe", "fluid", "equipment-category",
    "item-group", "space-location", "tips-and-tricks-item", "trivial-smoke",
    "virtual-signal", "quality", "tile", "surface", "planet",
}
local big_categories = {"item", "entity", "equipment"}
for _, category in pairs(big_categories) do
    for subtype in pairs(defines.prototypes[category]) do
        table.insert(subtypes, subtype)
    end
end

--Bloosh goosh
for _, subtype in pairs(subtypes) do
    for _, entry in pairs(data.raw[subtype] or {}) do
        bloosh_goosh(entry)
    end
end

--------
--Bloosh goosh

if not settings.startup["bloosh-goosh-util"].value then return end

local blacklist = {"cursor_box", "platform_entity_build_animations", "clouds", "arrow_button",
"explosion_chart_visualization", "refresh_white", "navmesh_pending_icon",
"type", "name", "order", "localised_name", "hidden", "hidden_in_factoriopedia", "BLOOSHfactoriopedia_simulation",

"copper_wire", "red_wire", "green_wire",
"copper_wire_highlight", "red_wire_highlight", "green_wire_highlight",
"wire_shadow",

"gradent", "output_console_gradient"
}
local blacklist_set = {}
for _, not_bloosh in pairs(blacklist) do
    blacklist_set[not_bloosh] = true
end

local util_sprites = data.raw["utility-sprites"]["default"]
local function set_bloosh(name)
    local orig = util_sprites[name]
    local bloosh_sprite = {
        type = "sprite",
        filename = BLOOSH2,
        scale = 0.5,
        width = GOOSH,
        height = GOOSH,

        priority = orig.priority,
        flags = orig.flags,
    }
    util_sprites[name] = bloosh_sprite
end

for name, not_bloosh in pairs(util_sprites) do
    if not_bloosh and not blacklist_set[name] then
        set_bloosh(name)
    end
end