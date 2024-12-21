local logger = require("AoqiaZomboidUtilsShared/logger")

-- ------------------------------ Module Start ------------------------------ --

local mod_constants = {}

mod_constants.MOD_ID = "AoqiaPleaseLockMyBoxes"
mod_constants.MOD_VERSION = "0.1.0"

mod_constants.LOGGER = logger:new(mod_constants.MOD_ID)

--- @class (exact) ReplicatedIsoThumpable
--- @field x integer
--- @field y integer
--- @field z integer
--- @field index integer

--- @class (exact) MakeLockableCommandArgs
--- @field object ReplicatedIsoThumpable

return mod_constants
