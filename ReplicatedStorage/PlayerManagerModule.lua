-- PlayerManagerModule.lua
local RobloxAPI = require(game.ReplicatedStorage.RobloxAPI)
local DiscordModule = require(game.ReplicatedStorage.DiscordModule)
local UserRolesSchema = require(game.ReplicatedStorage.UserRolesSchema)
local RoleMappingSchema = require(game.ReplicatedStorage.RoleMappingSchema)
local PlayerDataSchema = require(game.ReplicatedStorage.PlayerDataSchema)
local ListModule = require(game.ReplicatedStorage.ListModule)
local DataStoreModule = require(game.ReplicatedStorage.DataStoreModule)
local PlayerManager = {}

-- Tablica do przechowywania danych graczy
local players = {}

-- Funkcja do pobrania danych gracza
function PlayerManager.getPlayerData(playerId, DataStoreModule, DiscordModule)
	local playerData = players[playerId]

	-- Sprawdź, czy dane gracza istnieją
	if not playerData then
		playerData = {}
		players[playerId] = playerData
	end

	-- Pobierz dane gracza z DataStore
	local storedData = DataStoreModule.loadDataStore("PlayerDataDataStore", tostring(playerId))
	if storedData then
		playerData.data = PlayerDataSchema.validate(storedData)
	end

	-- Pobierz dane gracza z API Roblox
	local robloxData = RobloxAPI.getPlayerData(playerId)
	if robloxData then
		playerData.data.roblox = robloxData
	end

	-- Pobierz dane gracza z Discorda
	local discordData = DiscordModule.getDiscordMemberData(playerId)
	if discordData then
		playerData.data.discord = discordData
	end

	-- Zwróć dane gracza
	return playerData
end

-- Funkcja do aktualizacji danych gracza
function PlayerManager.updatePlayerData(playerId, data,DataStoreModule)
	local playerData = players[playerId]

	-- Zaktualizuj dane gracza
	playerData.data = data

	-- Zapisz dane gracza w DataStore
	DataStoreModule.updateDataStore("PlayerDataDataStore", tostring(playerId), data)
end

-- Funkcja do dodania roli graczowi w Roblox
function PlayerManager.assignRobloxRole(playerId, roleId, DataStoreModule)
	local playerData = players[playerId]

	-- Pobierz obiekt gracza z Roblox
	local player = game:GetService("Players"):GetPlayerByUserId(playerId)

	-- Sprawdź, czy gracz istnieje
	if player then
		-- Dodaj rolę do gracza
		player:AddRole(roleId)
	end

	-- Zaktualizuj dane gracza
	playerData.data.roblox.roles[roleId] = true

	-- Zapisz dane gracza w DataStore
	DataStoreModule.updateDataStore("PlayerDataDataStore", tostring(playerId), playerData.data)
end

-- Funkcja do usunięcia roli graczowi w Roblox
function PlayerManager.revokeRobloxRole(playerId, roleId,DataStoreModule)
	local playerData = players[playerId]

	-- Pobierz obiekt gracza z Roblox
	local player = game:GetService("Players"):GetPlayerByUserId(playerId)

	-- Sprawdź, czy gracz istnieje
	if player then
		-- Usuń rolę od gracza
		player:RemoveRole(roleId)
	end

	-- Zaktualizuj dane gracza
	playerData.data.roblox.roles[roleId] = false

	-- Zapisz dane gracza w DataStore
	DataStoreModule.updateDataStore("PlayerDataDataStore", tostring(playerId), playerData.data)
end

-- Funkcja do walidacji grupy
function PlayerManager.validateGroup(playerId, groupId)
	local playerData = players[playerId]

	-- Pobierz dane gracza z Roblox
	local robloxData = RobloxAPI.getPlayerData(playerId)

	-- Sprawdź, czy gracz jest w grupie
	if robloxData.group and robloxData.group.id == groupId then
		return true
	end

	return false
end

-- Funkcja do walidacji roli Discord
function PlayerManager.validateDiscordRole(playerId, discordRoleId,DiscordModule)
	local playerData = players[playerId]

	-- Pobierz dane gracza z Discorda
	local discordData = DiscordModule.getDiscordMemberData(playerId)

	-- Sprawdź, czy gracz ma rolę
	if discordData and discordData.roles and discordData.roles[discordRoleId] then
		return true
	end

	return false
end

return PlayerManager