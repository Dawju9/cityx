local fs = ('@lune/fs')
local roblox = ('@lune/roblox') 
-- Reading a place file
local placeFile = fs.readFile("cityx.rbxl")
local game = roblox.deserializePlace(placeFile)

-- Manipulating and reading instances - just like in Roblox!
local workspace = game:GetService("Workspace")
for _, child in workspace:GetChildren() do
	print("Found child " .. child.Name .. " of class " .. child.ClassName)
end
 
-- Writing a place filerokit add lune
local newPlaceFile = roblox.serializePlace(game)
fs.writeFile("cityx.rbxl", newPlaceFile)