
--[[
local MapSettings = {
	BlockTypes = {
		Grass = {
			Material = Enum.Material.Grass,
			Color = Color3.fromRGB(85, 170, 0), -- Zielony kolor trawy
			Anchored = true,  -- Czy blok ma być zakotwiczony
			Mass = 0  -- Masa bloku
		},
		Concrete = {
			Material = Enum.Material.Concrete,
			Color = Color3.fromRGB(150, 150, 150), -- Szary kolor betonu
			Anchored = true,
			Mass = 10
		},
		Wood = {
			Material = Enum.Material.Wood,
			Color = Color3.fromRGB(139, 69, 19), -- Brązowy kolor drewna
			Anchored = false,
			Mass = 5
		}
		-- Dodaj inne typy bloków według potrzeb
	}
}

return MapSettings
local MapSettings = {
    BlockTypes = {
        Grass = {
            Material = Enum.Material.Grass,
            Color = Color3.fromRGB(85, 170, 0), -- Zielony kolor trawy
            Anchored = true,  -- Czy blok ma być zakotwiczony
            Mass = 0  -- Masa bloku
        },
        Concrete = {
            Material = Enum.Material.Concrete,
            Color = Color3.fromRGB(150, 150, 150), -- Szary kolor betonu
            Anchored = true,
            Mass = 10
        },
        Wood = {
            Material = Enum.Material.Wood,
            Color = Color3.fromRGB(139, 69, 19), -- Brązowy kolor drewna
            Anchored = false,
            Mass = 5
        }
        -- Dodaj inne typy bloków według potrzeb
    }
}

return MapSettings




]]--
local MapSettings = require(script.Parent.MapSettings)
local MapSchema = {
	MapName = "Example Map",
	Locations = {
		{
			Name = "Location 1",
			Platforms = {
				{
					PlatformID = 1,
					Grids = {{25, 25}, {45, 45}},
					Settings = {
						BlockType = MapSettings.BlockTypes.Grass
					}
				},
				{
					PlatformID = 2,
					Grids = {{100, 100}},
					Settings = {
						BlockType = MapSettings.BlockTypes.Concrete
					}
				},
				{
					PlatformID = 3,
					Grids = {{100, 100}},
					Settings = {
						BlockType = MapSettings.BlockTypes.Concrete
					}
				},
				{
					PlatformID = 4,
					Grids = {{100, 100}},
					Settings = {
						BlockType = MapSettings.BlockTypes.Concrete
					}
				}


			}
		}
	}
}

return MapSchema
-- Importowanie ustawień mapy
-- Importowanie ustawień mapy
--[[
local MapSettings = require(script.Parent.MapSettings)

-- Funkcja do tworzenia bloku
local function createBlock(position, blockType)
	local block = Instance.new("Part")
	block.Position = position
	block.Size = Vector3.new(1, 1, 1)
	block.Material = blockType.Material
	block.Color = blockType.Color
	block.Anchored = blockType.Anchored
--	block.Mass = blockType.Mass
	block.Name = "Block"
	block.Parent = workspace

	return block
end

-- Funkcja do generowania siatki bloków
local function generateGrid(xOffset, yOffset, zOffset, blockCountX, blockCountZ, blockType)
	local grid = {}

	for z = 1, blockCountZ do
		for x = 1, blockCountX do
			local position = Vector3.new(xOffset + x - 1, yOffset, zOffset + z - 1)
			local block = createBlock(position, blockType)
			table.insert(grid, block)
		end
	end

	return grid
end

-- Funkcja generująca platformę z siatkami bloków
local function generatePlatform(platformID, xOffset, yOffset, zOffset, gridSize, platformSettings)
	local platform = {
		PlatformID = platformID,
		Grids = {}
	}

	for _, gridSizeParams in ipairs(gridSize) do
		local blockCountX, blockCountZ = gridSizeParams[1], gridSizeParams[2]
		local grid = generateGrid(xOffset, yOffset, zOffset, blockCountX, blockCountZ, platformSettings.BlockType)
		table.insert(platform.Grids, grid)
	end

	return platform
end

-- Funkcja generująca lokalizację z platformami
local function generateLocation(locationData)
	local location = {
		Name = locationData.Name,
		Platforms = {}
	}

	for _, platformData in ipairs(locationData.Platforms) do
		local xOffset = (platformData.PlatformID - 1) * 16
		local platform = generatePlatform(platformData.PlatformID, xOffset, 0, 0, platformData.Grids, platformData.Settings)
		table.insert(location.Platforms, platform)
	end

	return location
end

-- Funkcja generująca mapę na podstawie schematu
local function generateMap(mapSchema)
	local map = {
		MapName = mapSchema.MapName,
		Locations = {}
	}

	for _, locationData in ipairs(mapSchema.Locations) do
		local location = generateLocation(locationData)
		table.insert(map.Locations, location)
	end

	return map
end

-- Zwracamy moduł z funkcją generującą mapę na podstawie zaimportowanego schematu
return generateMap
]]--

--[[

MapSettings = require(script.MapSettings)

-- Funkcja do tworzenia bloku
local function createBlock(position, blockType)
    local block = Instance.new("Part")
    block.Position = position
    block.Size = Vector3.new(1, 1, 1)
    block.Material = blockType.Material
    block.Color = blockType.Color
    block.Anchored = blockType.Anchored
    block.Mass = blockType.Mass
    block.Name = "Block"
    block.Parent = workspace
    
    return block
end

-- Funkcja do generowania siatki bloków
local function generateGrid(xOffset, yOffset, zOffset, blockCountX, blockCountZ, blockType)
    local grid = {}

    for z = 1, blockCountZ do
        for x = 1, blockCountX do
            local position = Vector3.new(xOffset + x - 1, yOffset, zOffset + z - 1)
            local block = createBlock(position, blockType)
            table.insert(grid, block)
        end
    end

    return grid
end

-- Funkcja generująca platformę z siatkami bloków
local function generatePlatform(platformID, xOffset, yOffset, zOffset, gridSize, platformSettings)
    local platform = {
        PlatformID = platformID,
        Grids = {}
    }

    for _, gridSizeParams in ipairs(gridSize) do
        local blockCountX, blockCountZ = gridSizeParams[1], gridSizeParams[2]
        local grid = generateGrid(xOffset, yOffset, zOffset, blockCountX, blockCountZ, platformSettings.BlockType)
        table.insert(platform.Grids, grid)
    end

    return platform
end

-- Funkcja generująca lokalizację z platformami
local function generateLocation(locationData)
    local location = {
        Name = locationData.Name,
        Platforms = {}
    }

    for _, platformData in ipairs(locationData.Platforms) do
        local xOffset = (platformData.PlatformID - 1) * 16
        local platform = generatePlatform(platformData.PlatformID, xOffset, 0, 0, platformData.Grids, platformData.Settings)
        table.insert(location.Platforms, platform)
    end

    return location
end

-- Funkcja generująca mapę na podstawie schematu
local function generateMap(mapSchema)
    local map = {
        MapName = mapSchema.MapName,
        Locations = {}
    }

    for _, locationData in ipairs(mapSchema.Locations) do
        local location = generateLocation(locationData)
        table.insert(map.Locations, location)
    end

    return map
end

-- Zwracamy moduł z funkcją generującą mapę na podstawie zaimportowanego schematu
return generateMap


]]--
