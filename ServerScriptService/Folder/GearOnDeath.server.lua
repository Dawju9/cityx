function HasGamepass(player, passId)
    return game:GetService("MarketplaceService"):PlayerOwnsAsset(player, passId)
end

function Player(p)
	local backpack = p:WaitForChild("Backpack")
	local spawnGear = {}
	local KeepGear = HasGamepass(p, 488956910)
	
	local function Character(char)
		local hmd = char:WaitForChild("Humanoid")
		
		wait(1)
		
		if KeepGear then
			for _,v in pairs (spawnGear) do
				local getGear = game.ServerStorage.Gear:findFirstChild(v)
				if getGear then
					getGear:clone().Parent = p.Backpack
				end
			end
		end
		spawnGear = {}
		
		hmd.Died:connect(function()
			local gear = {}
			for _,v in pairs (p.Backpack:GetChildren()) do
				if v:IsA("Tool") then
					gear[#gear+1] = v
				end
			end
			for _,v in pairs (char:GetChildren()) do
				if v:IsA("Tool") then
					gear[#gear+1] = v
				end
			end
			for _,v in pairs (gear) do
				v.CanBeDropped = false
				spawnGear[#spawnGear+1] = v.Name
			end
		end)
	end
	
	if p.Character then Character(p.Character) end
	p.CharacterAdded:connect(Character)
end

for _,v in pairs (game.Players:GetChildren()) do Player(v) end

game.Players.PlayerAdded:connect(Player)
