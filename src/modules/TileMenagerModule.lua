local ReplicatedStorage = game:GetService("ReplicatedStorage")

local TileManager = {}
TileManager.__index = TileManager

function TileManager.new()
    local self = setmetatable({}, TileManager)
    self.models = {}
    return self
end

function TileManager:loadModels()
    local tileModels = ReplicatedStorage:FindFirstChild("TileModels")
    if not tileModels then
        self:logError("TileModels folder not found in ReplicatedStorage")
        return
    end

    for _, model in ipairs(tileModels:GetChildren()) do
        if model:IsA("Model") then
            self.models[model.Name] = model:Clone()
        end
    end
end

function TileManager:replaceModels(newModels)
    for name, model in pairs(newModels) do
        if self.models[name] then
            self.models[name]:Destroy()
        end
        self.models[name] = model:Clone()
    end
end

function TileManager:logError(errorMessage)
    warn("TileManager Error: " .. errorMessage)
end

return TileManager
