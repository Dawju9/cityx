-- MapGeneration.lua

local MapGeneration = {}

local function debugPrint(...)
	print("[DEBUG]", ...)
end

function MapGeneration.createBlockSchema(blockData)
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

function MapGeneration.generateGridSchema(gridData)
	local gridSchema = {
		type = gridData.type,
		amount = gridData.blockCountX * gridData.blockCountZ,
		anchored = gridData.anchored,
		color = gridData.color,
		mass = gridData.mass,
		material = gridData.material,
		meta = {
			pergrid = gridData.blockCountX .. "x" .. gridData.blockCountZ,
			schema = "grass"
		},
		visibility = true,
		x = gridData.xOffset,
		y = gridData.yOffset,
		z = gridData.zOffset,
		Map = {
			Grid = {}
		}
	}

	for z = 1, gridData.blockCountZ do
		for x = 1, gridData.blockCountX do
			local blockSchema = MapGeneration.createBlockSchema({
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

function MapGeneration.generateMapLevel()
	local schemaLevel = {
		Level = 1,
		Difficulty = 0.2,
		Map = {
			Locations = {
				gridsVortex = {}
			}
		}
	}

	local grid1 = MapGeneration.generateGridSchema({
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

	local grid2 = MapGeneration.generateGridSchema({
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

	local grid3 = MapGeneration.generateGridSchema({
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

	table.insert(schemaLevel.Map.Locations.gridsVortex, grid1)
	table.insert(schemaLevel.Map.Locations.gridsVortex, grid2)
	table.insert(schemaLevel.Map.Locations.gridsVortex, grid3)

	return schemaLevel
end

function MapGeneration.generateMapFromSchemas(schemaLevel)
	for location, grids in pairs(schemaLevel.Map.Locations) do
		debugPrint("Generowanie lokalizacji:", location)
		for _, grid in ipairs(grids) do
			debugPrint("Generowanie gridu:", grid.type, "na pozycji (x:", grid.x, ", z:", grid.z, ")")

			for _, block in ipairs(grid.Map.Grid) do
				debugPrint("Generowanie bloku:", block.material, "na pozycji (x:", block.x, ", z:", block.z, ")")
			end
		end
	end
end

return MapGeneration
