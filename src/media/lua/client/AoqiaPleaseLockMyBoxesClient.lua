-- Mod requires.
local events = require("AoqiaPleaseLockMyBoxesClient/events")
local mod_constants = require("AoqiaPleaseLockMyBoxesShared/mod_constants")

local logger = mod_constants.LOGGER

-- Entrypoint --------------------------------- ---

events.register()

logger:debug("Lua init done!")
