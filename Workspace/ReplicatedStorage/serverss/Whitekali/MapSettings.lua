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

]]--

