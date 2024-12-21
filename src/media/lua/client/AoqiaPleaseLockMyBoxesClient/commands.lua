-- Mod requires.
local mod_constants = require("AoqiaPleaseLockMyBoxesShared/mod_constants")

local logger = mod_constants.LOGGER

-- ------------------------------ Module Start ------------------------------ --

local commands = {}

--- @param args MakeLockableCommandArgs
function commands.make_lockable(args)
    local replicated_object = args.object

    local square = getSquare(replicated_object.x, replicated_object.y, replicated_object.z)
    if square == nil then return end

    --- @type IsoThumpable
    local object = square:getObjects():get(replicated_object.index)
    if object == nil then
        logger:warn_server("Container object was nil.")
        return
    end

    if object:canBeLockByPadlock() then
        logger:info_server("Container is already lockable.")
        return
    end

    object:setCanBeLockByPadlock(true)
    logger:debug_server("Container is now lockable as per server request.")
end

return commands
