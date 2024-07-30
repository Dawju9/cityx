-- Import the map generation module and schema
generateMap = require(game.ServerScriptService.Whitekali.MapGeneratorModule)
local MapSchema = require(game.ServerScriptService.Whitekali.MapSchema)

-- Generate the map based on the schema
local mapData = generateMap(MapSchema)

-- Debugging settings
local debug = true

-- Function to print debug messages
local function debugPrint(...)
	if debug then
		print("[DEBUG]", ...)
	end
end

-- Print the generated map data
debugPrint("Generated Map Data:")
debugPrint(mapData)

-- Map legend for schema elements
local legendMap = {
	Level = "Level number",
	Difficulty = "Level difficulty",
	Map = {
		Locations = {
			gridsVortex = {
				type = "Grid type",
				amount = "Number of blocks in the grid",
				anchored = "Whether the grid is anchored",
				color = "Block color",
				mass = "Block mass",
				material = "Block material",
				meta = {
					pergrid = "Grid size",
					schema = "Grid schema"
				},
				visibility = "Whether the grid is visible",
				x = "Grid x position",
				y = "Grid y position",
				z = "Grid z position",
				Map = {
					Grid = {
						x = "Block x position",
						y = "Block y position",
						z = "Block z position",
						material = "Block material",
						color = "Block color",
						anchored = "Whether the block is anchored",
						mass = "Block mass"
					}
				}
			}
		}
	}
}

-- Function to create a block schema
local function createBlockSchema(x, y, z, material, color, anchored, mass)
	return {
		x = x,
		y = y,
		z = z,
		material = material,
		color = color,
		anchored = anchored,
		mass = mass
	}
end

-- Function to generate a grid schema
local function generateGridSchema(gridType, xOffset, yOffset, zOffset, blockCountX, blockCountZ, material, color, anchored, mass)
	local gridSchema = {
		type = gridType,
		amount = blockCountX * blockCountZ,
		anchored = anchored,
		color = color,
		mass = mass,
		material = material,
		meta = {
			pergrid = string.format("%dx%d", blockCountX, blockCountZ),
			schema = "grass"  -- Example schema, can be customized
		},
		visibility = true,
		x = xOffset,
		y = yOffset,
		z = zOffset,
		Map = {
			Grid = {}
		}
	}

	-- Generate blocks in the grid
	for z = 1, blockCountZ do
		for x = 1, blockCountX do
			local blockSchema = createBlockSchema(xOffset + x - 1, yOffset, zOffset + z - 1, material, color, anchored, mass)
			table.insert(gridSchema.Map.Grid, blockSchema)
		end
	end

	return gridSchema
end

-- Function to generate a map level
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

	-- Generate various grids
	local grid1 = generateGridSchema("Grass", 0, 0, 0, 4, 4, "grass", "green", true, 2)
	local grid2 = generateGridSchema("Concrete", 0, 0, 4, 3, 3, "concrete", "white", true, 10)
	local grid3 = generateGridSchema("Brick", 0, 0, 7, 2, 2, "brick", "red", true, 5)

	-- Add grid schemas to the map
	table.insert(schemaLevel.Map.Locations.gridsVortex, grid1)
	table.insert(schemaLevel.Map.Locations.gridsVortex, grid2)
	table.insert(schemaLevel.Map.Locations.gridsVortex, grid3)

	return schemaLevel
end

-- Generate the map level
local level = generateMapLevel()

-- Print the generated map level for debugging
debugPrint("Generated Map Level:")
debugPrint(level)

-- Print the map legend
debugPrint("Map Legend:")
for key, value in pairs(legendMap) do
	if type(value) == "table" then
		for k, v in pairs(value) do
			print("[DEBUG] " .. k .. ":", v)
		end
	else
		print("[DEBUG] " .. key .. ":", value)
	end
end
