
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