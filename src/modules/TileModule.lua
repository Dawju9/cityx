local TileModule = {}

-- Constants
local ANIMATION_DURATION = 1
local TILE_SIZE = 5

-- Constructor
function TileModule.new(model, id, position, sector)
    local self = setmetatable({}, {__index = TileModule})
    self.model = model
    self.id = id
    self.position = position
    self.sector = sector
    self.state = "inactive"
    self.billboard = nil
    self:initialize()
    return self
end

-- Initialize the tile
function TileModule:initialize()
    self:createBillboard()
    self:setPosition()
end

-- Create and update billboard
function TileModule:createBillboard()
    self.billboard = Instance.new("BillboardGui")
    self.billboard.Adornee = self.model.PrimaryPart
    self.billboard.Size = UDim2.new(0, 100, 0, 50)
    self.billboard.StudsOffset = Vector3.new(0, 2, 0)
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.SourceSansBold
    textLabel.TextColor3 = Color3.new(1, 1, 1)
    textLabel.Text = "Tile ID: " .. self.id
    textLabel.Parent = self.billboard
    
    self.billboard.Parent = self.model
end

-- Set tile position
function TileModule:setPosition()
    self.model:SetPrimaryPartCFrame(CFrame.new(self.position))
end

-- Animate tile
function TileModule:animate()
    spawn(function()
        while self.state == "active" do
            local originalY = self.position.Y
            for i = 0, 1, 0.1 do
                if self.state ~= "active" then break end
                local newY = originalY + math.sin(i * math.pi) * TILE_SIZE
                self.model:SetPrimaryPartCFrame(CFrame.new(self.position.X, newY, self.position.Z))
                wait(ANIMATION_DURATION / 20)
            end
            wait(ANIMATION_DURATION)
        end
    end)
end

-- Update tile state
function TileModule:updateState(newState)
    self.state = newState
    if newState == "active" then
        self:animate()
    end
end

-- Handle errors
function TileModule:handleError(errorMsg)
    warn("Tile Error (ID: " .. self.id .. "): " .. errorMsg)
    -- Implement error handling logic here
end

-- Clean up tile
function TileModule:destroy()
    if self.billboard then
        self.billboard:Destroy()
    end
    self.model:Destroy()
end

return TileModule
