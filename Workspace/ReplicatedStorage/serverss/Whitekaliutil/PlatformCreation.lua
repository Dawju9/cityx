 -- PlatformCreation.lua

local PlatformCreation = {}

function PlatformCreation.CreatePart(size, position, color, partName)
	local newPart = Instance.new("Part")
	newPart.Size = size
	newPart.Position = position
	newPart.Color = color
	newPart.Anchored = true
	newPart.Name = partName
	newPart.Parent = workspace

	-- Tworzenie Billboard
	local billboardGui = Instance.new("BillboardGui", newPart)
	billboardGui.Adornee = newPart
	billboardGui.Size = UDim2.new(0, 200, 0, 50)
	billboardGui.StudsOffset = Vector3.new(0, 2, 0)
	billboardGui.AlwaysOnTop = true

	local textLabel = Instance.new("TextLabel", billboardGui)
	textLabel.Size = UDim2.new(1, 0, 1, 0)
	textLabel.BackgroundTransparency = 1
	textLabel.Text = "E - to interact"
	textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	textLabel.TextScaled = true

	-- Interakcja
	local proximityPrompt = Instance.new("ProximityPrompt", newPart)
	proximityPrompt.ActionText = "Press E to interact"
	proximityPrompt.KeyboardKeyCode = Enum.KeyCode.E
	proximityPrompt.RequiresLineOfSight = false
	proximityPrompt.MaxActivationDistance = 10

	proximityPrompt.Triggered:Connect(function(player)
		print(player.Name .. " interacted with " .. newPart.Name)
	end)

	return newPart
end

function PlatformCreation.generatePlatforms(mapData)
	local part = workspace:FindFirstChild("CentralPart")
	if not part then
		error("CentralPart not found in Workspace!")
	end

	local offsetX = mapData.blockSize.X * (mapData.gridSize - 1) / 2
	local offsetZ = mapData.blockSize.Z * (mapData.gridSize - 1) / 2

	for i = 1, mapData.gridSize do
		for j = 1, mapData.gridSize do
			local position = part.Position + Vector3.new(
				(mapData.blockSize.X * (i - 1)) - offsetX,
				0,
				(mapData.blockSize.Z * (j - 1)) - offsetZ
			)
			local platformName = "PlatformPart_" .. i .. "_" .. j
			PlatformCreation.CreatePart(mapData.blockSize, position, Color3.new(math.random(), math.random(), math.random()), platformName)
		end
	end
end

return PlatformCreation
