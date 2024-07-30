PlayerModule = {}
-- PlayerModule.lua
local RobloxModule = require("RobloxModule.lua")
local DataStoreModule = require(game.ReplicatedStorage.DataStoreModule)

local OverheadGUIModule = require(shared.ReplicatedStorage.OverheadGUIModule)


function PlayerModule.init()
	-- Nasłuchiwanie zdarzeń gracza w Roblox
	game.Players.PlayerAdded:Connect(function(player)
		PlayerModule.syncPlayerData(player)
	end)
end

function PlayerModule.getPlayerData(playerId)
	local playerData = DataStoreModule.getPlayerData(playerId)

	if playerData == nil then
		playerData = RobloxModule.getPlayerData(playerId)
		DataStoreModule.updatePlayerData(playerId, playerData)
	end

	return playerData
end

function PlayerModule.updatePlayerData(playerId, data)
	RobloxModule.updatePlayerData(playerId, data)
	DataStoreModule.updatePlayerData(playerId, data)
end

function PlayerModule.assignRobloxRoleFromDiscord(playerId, discordRole)
	local robloxRole = DataStoreModule.getRoleMapping(discordRole)
	if robloxRole ~= nil then
		RobloxModule.assignRobloxRole(playerId, robloxRole)
		local player = game.Players:FindFirstChild(playerId)
		if player then
			OverheadGUIModule.updateOverheadGui(player) -- Aktualizacja GUI po zmianie roli
		end
	end
end

function PlayerModule.revokeRobloxRoleFromDiscord(playerId, discordRole)
	local robloxRole = DataStoreModule.getRoleMapping(discordRole)
	if robloxRole ~= nil then
		RobloxModule.revokeRobloxRole(playerId, robloxRole)
		local player = game.Players:FindFirstChild(playerId)
		if player then
			OverheadGUIModule.updateOverheadGui(player) -- Aktualizacja GUI po zmianie roli
		end
	end
end

function PlayerModule.syncPlayerData(player)
	local playerData = PlayerModule.getPlayerData(player.UserId)

	-- Dodatkowa logika, np. ustawienie spawn point, początkowych statystyk
	-- ...
	if playerData.spawnPoint then
		player.CharacterAdded:Connect(function(character)
			character:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(playerData.spawnPoint)
		end)
	end
end

return PlayerModule