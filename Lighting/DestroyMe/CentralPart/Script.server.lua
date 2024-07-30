--[[
    Skrypt odpowiedzi został skryptowany przez --[White]--.
]]

local working = true
local iAmScript = script
local maxClones = 10
local cloneCount = 0

-- Tworzenie ValueBase "status"
local status = Instance.new("ValueBase", script)
status.Name = "status"
status.Parent = iAmScript
status.Value = "stopped"

-- Funkcja do tworzenia części z interakcją
local function CreatePart(size, position, color, partName)
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


--[[

-- Schemat mapy
local mapData = {
	gridSize = 3,
	blockSize = Vector3.new(4, 1, 4),  -- Dostosuj rozmiar według potrzeb
}

-- Funkcja generująca platformy
local function generatePlatforms()
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
			CreatePart(mapData.blockSize, position, Color3.new(math.random(), math.random(), math.random()), platformName)
		end
	end
end

-- Główna pętla
while working do
	generatePlatforms()

	-- Klonowanie CentralPart
	cloneCount = cloneCount + 1
	if cloneCount <= maxClones then
		local part = workspace:FindFirstChild("CentralPart")
		local positions = {
			Vector3.new(5, 0, 0),
			Vector3.new(0, 0, 5),
			Vector3.new(5, 0, 5),
		}

		for _, offset in ipairs(positions) do
			local clone = part:Clone()
			clone.Position = part.Position + offset
			clone.Parent = workspace
		end
	else
		working = false
		print("Reached maximum clone limit.")
	end

	wait(1)  -- Dostosuj czas oczekiwania
end

status.Value = "stopped"  -- Ustawienie statusu


-- Funkcja debugPrint do wyświetlania informacji w konsoli
local function debugPrint(...)
	print("[DEBUG]", ...)
end








-- Funkcja tworząca schemat pojedynczego bloku
local function createBlockSchema(blockData)
	return {
		x = blockData.x,
		y = blockData.y,
		z = blockData.z,
		material = blockData.material,
		color = blockData.color,
		anchored = blockData.anchored,
		mass = blockData.mass
	}
end

-- Funkcja generująca schemat gridu
local function generateGridSchema(gridData)
	local gridSchema = {
		type = gridData.type,
		amount = gridData.blockCountX * gridData.blockCountZ,
		anchored = gridData.anchored,
		color = gridData.color,
		mass = gridData.mass,
		material = gridData.material,
		meta = {
			pergrid = gridData.blockCountX .. "x" .. gridData.blockCountZ,
			schema = "grass"  -- Przykładowy schemat, można dostosować
		},
		visibility = true,
		x = gridData.xOffset,
		y = gridData.yOffset,
		z = gridData.zOffset,
		Map = {
			Grid = {}
		}
	}

	-- Generowanie bloków w gridzie
	for z = 1, gridData.blockCountZ do
		for x = 1, gridData.blockCountX do
			local blockSchema = createBlockSchema({
				x = gridData.xOffset + x - 1,
				y = gridData.yOffset,
				z = gridData.zOffset + z - 1,
				material = gridData.material,
				color = gridData.color,
				anchored = gridData.anchored,
				mass = gridData.mass
			})
			table.insert(gridSchema.Map.Grid, blockSchema)
		end
	end

	return gridSchema
end

-- Funkcja generująca poziom mapy
local function generateMapLevel()
	local schemaLevel = {
		Level = 1,
		Difficulty = 0.2,
		Map = {
			Locations = {
				gridsVortex = {}
			}
		}
	}

	-- Generowanie różnych gridów
	local grid1 = generateGridSchema({
		type = "Grass",
		xOffset = 0,
		yOffset = 0,
		zOffset = 0,
		blockCountX = 4,
		blockCountZ = 4,
		material = "grass",
		color = "green",
		anchored = true,
		mass = 2
	})

	local grid2 = generateGridSchema({
		type = "Concrete",
		xOffset = 0,
		yOffset = 0,
		zOffset = 4,
		blockCountX = 3,
		blockCountZ = 3,
		material = "concrete",
		color = "white",
		anchored = true,
		mass = 10
	})

	local grid3 = generateGridSchema({
		type = "Brick",
		xOffset = 0,
		yOffset = 0,
		zOffset = 7,
		blockCountX = 2,
		blockCountZ = 2,
		material = "brick",
		color = "red",
		anchored = true,
		mass = 5
	})

	-- Dodawanie schematów gridów do mapy
	table.insert(schemaLevel.Map.Locations.gridsVortex, grid1)
	table.insert(schemaLevel.Map.Locations.gridsVortex, grid2)
	table.insert(schemaLevel.Map.Locations.gridsVortex, grid3)

	return schemaLevel
end

-- Wygenerowanie poziomu mapy
local level = generateMapLevel()

-- Funkcja generująca mapę na podstawie przekazanych schematów
local function generateMapFromSchemas(schemaLevel)
	-- Przetwarzanie poziomu mapy
	for location, grids in pairs(schemaLevel.Map.Locations) do
		debugPrint("Generowanie lokalizacji:", location)
		for _, grid in ipairs(grids) do
			debugPrint("Generowanie gridu:", grid.type, "na pozycji (x:", grid.x, ", z:", grid.z, ")")

			-- Generowanie bloków w gridzie
			for _, block in ipairs(grid.Map.Grid) do
				debugPrint("Generowanie bloku:", block.material, "na pozycji (x:", block.x, ", z:", block.z, ")")
				-- Tutaj można dodać logikę tworzenia bloków w grze na podstawie danych z block
				-- Na przykład:
				-- local newPart = Instance.new("Part")
				-- newPart.Position = Vector3.new(block.x, block.y, block.z)
				-- newPart.Size = Vector3.new(1, 1, 1)
				-- newPart.Color = Color3.new(1, 1, 1)
				-- newPart.Parent = workspace
			end
		end
	end
end

-- Wywołanie funkcji generującej mapę na podstawie schematów
generateMapFromSchemas(level)

]]--