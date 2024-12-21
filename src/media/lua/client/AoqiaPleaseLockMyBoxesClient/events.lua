-- -------------------------------------------------------------------------- --
--            Handles event stuff like registering listeners/hooks.           --
-- -------------------------------------------------------------------------- --

-- Mod requires.
local commands = require("AoqiaPleaseLockMyBoxesClient/commands")
local context_menu = require("AoqiaPleaseLockMyBoxesClient/ui/context_menu")
local mod_constants = require("AoqiaPleaseLockMyBoxesShared/mod_constants")

-- TIS globals cache.
local Events = Events

local logger = mod_constants.LOGGER

-- ------------------------------ Module Start ------------------------------ --

local events = {}

--- @type Callback_OnServerCommand
function events.on_server_command(module, command, args)
    -- This isn't being called when a client tries to send command to server.
    if module ~= mod_constants.MOD_ID then return end
    if commands[command] == nil then
        logger:info_server("Received non-existent server command (%s).", command)
        return
    end

    logger:info_server("Received server command (%s).", command)
    commands[command](args)
end

function events.register()
    logger:debug_server("Registering events...")

    Events.OnServerCommand.Add(events.on_server_command)
    Events.OnFillWorldObjectContextMenu.Add(context_menu.create_world_menu)
end

return events
