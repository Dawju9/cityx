--- Loads and returns a table of all registered modules.
---
--- The `ModuleLoader` module provides a way to load and access various modules
--- that are part of the application. It maintains a table of all registered
--- modules, organized by category (functions, parameters, events).
---
--- To use the `ModuleLoader`, call the `loadModules()` function, which will
--- load all registered modules and return a table containing them.
--local ModuleLoader = require("ModuleLoader")
local ModuleLoader = {}
local function loadModule(moduleName)
    local modulePath = string.format("src/modules/%s.lua", moduleName)
    local module = require(modulePath)
    return module
end

function ModuleLoader.loadModules()
    local modules = {}
    local modulePaths = {
        modulesFunctions = {
            "Chunk",
            "Player",
            "City",
            "Cityx",
            "Miastox",
        },
        modulesParameters = {
            Miastox = {
                name = '    Miastox _G(...)',
                description = '    Miastox _G(...)',
                icon = '    Miastox _G(...)',
            }
        },
        modulesEvents = {
            Miastox = {
                name = '    Miastox _G(...)',
                description = '    Miastox _G(...)',
                icon = '    Miastox _G(...)',
            }
        },
    }

    for _, moduleList in pairs(modulePaths) do
        if type(moduleList) == "table" then
            for moduleName, moduleData in pairs(moduleList) do
                if type(moduleName) == "number" then
                    -- For arrays like modulesFunctions
                    local module = loadModule(moduleData)
                    modules[moduleData] = module
                else
                    -- For nested tables like modulesParameters and modulesEvents
                    local module = loadModule(moduleName)
                    modules[moduleName] = module
                end
            end
        end
    end

    return modules
end

return ModuleLoader





