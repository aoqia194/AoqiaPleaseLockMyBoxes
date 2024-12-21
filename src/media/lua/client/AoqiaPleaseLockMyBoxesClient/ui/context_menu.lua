-- -------------------------------------------------------------------------- --
--                 Handles the context menu for world objects.                --
-- -------------------------------------------------------------------------- --

-- My requires.
local mod_constants = require("AoqiaPleaseLockMyBoxesShared/mod_constants")

-- TIS function caching.
local instanceof = instanceof
local getSpecificPlayer = getSpecificPlayer

local logger = mod_constants.LOGGER

-- ------------------------------ Module Start ------------------------------ --

local context_menu = {}

--- @param object IsoThumpable
function context_menu.on_make_lockable(object)
    object:setCanBeLockByPadlock(true)
    sendClientCommand(mod_constants.MOD_ID, "make_lockable", {
        object = {
            x = object:getX(),
            y = object:getY(),
            z = object:getZ(),
            index = object:getObjectIndex(),
        },
    })
end

--- @param container_obj IsoThumpable
--- @param context ISContextMenu
function context_menu.do_context_menu(container_obj, context)
    context:addOption(
        getText(("ContextMenu_%s_MakeLockable"):format(mod_constants.MOD_ID)),
        container_obj, context_menu.on_make_lockable)
end

--- @param player_idx integer
--- @param context ISContextMenu
--- @param worldobjects IsoObject[]
--- @param test boolean
--- @return boolean?
function context_menu.create_world_menu(player_idx, context, worldobjects, test)
    local player = getSpecificPlayer(player_idx)
    local player_inv = player:getInventory()

    local padlock = player_inv:getFirstTypeRecurse("Padlock")
    if padlock == nil then return end

    -- If no world objects, don't create menu.
    if worldobjects == nil or #worldobjects == 0 then
        logger:debug("No world objects.")
        return
    end

    --- @type IsoThumpable
    local container_obj = nil

    -- Loop through square's objects because worldobjects arg is weird.
    local sq = worldobjects[1]:getSquare()
    local objs = sq:getObjects()
    for i = 1, objs:size() do
        local obj = objs:get(i - 1) --[[@as IsoObject]]
        if instanceof(obj, "IsoThumpable") and obj:getItemContainer() then
            container_obj = obj --[[@as IsoThumpable]]
            break
        end
    end

    if container_obj == nil then return end
    if container_obj:canBeLockByPadlock() then return end

    context_menu.do_context_menu(container_obj, context)
end

return context_menu
