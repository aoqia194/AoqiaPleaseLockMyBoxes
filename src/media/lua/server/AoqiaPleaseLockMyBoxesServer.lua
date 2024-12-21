-- -------------------------------------------------------------------------- --
--                      The main entry point for the mod.                     --
-- -------------------------------------------------------------------------- --

-- Mod requires.
local constants = require("AoqiaZomboidUtilsShared/constants")
local events = require("AoqiaPleaseLockMyBoxesServer/events")
local mod_constants = require("AoqiaPleaseLockMyBoxesShared/mod_constants")

local logger = mod_constants.LOGGER

-- ------------------------------- Entrypoint ------------------------------- --

-- Don't load on the client (excluding singleplayer).
if constants.IS_CLIENT and constants.IS_SINGLEPLAYER == false then
    logger:debug("Prevented server entrypoint from being executed.")
    return
end

events.register()

logger:debug_server("Lua init done!")
