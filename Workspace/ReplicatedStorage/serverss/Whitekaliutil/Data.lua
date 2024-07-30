-- Data.lua

local Data = {}

function Data.loadMapData()
	return {
		gridSize = 3,
		blockSize = Vector3.new(4, 1, 4)
	}
end

return Data
