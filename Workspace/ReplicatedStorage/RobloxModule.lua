--[[

local RobloxAPI = require(game.ReplicatedStorage.RobloxAPI)-- Korzystaj z wbudowanego HttpService

local json = game.ReplicatedStorage.json
local RobloxModule = {}

function RobloxModule.getPlayerData(playerId)
	-- Użyj HttpService do pobrania danych gracza z API Roblox
	local requestURL = "https://api.roblox.com/users/" .. playerId
	local response = RobloxAPI:GetAsync(requestURL)

	if response then
		local playerData = json.decode(response)
		return playerData
	else
		print("Error fetching player data")
		return nil
	end
end

function RobloxModule.updatePlayerData(playerId, data)
	-- Użyj HttpService do aktualizacji danych gracza w API Roblox
	-- Upewnij się, że masz odpowiednie uprawnienia
	-- Użyj odpowiednich endpointów API
end

function RobloxModule.assignRobloxRole(playerId, roleId)
	-- Użyj API Roblox do dodania gracza do grupy z rolą
	-- Upewnij się, że masz odpowiednie uprawnienia
	-- Użyj odpowiednich endpointów API
end

function RobloxModule.revokeRobloxRole(playerId, roleId)
	-- Użyj API Roblox do usunięcia gracza z grupy
	-- Upewnij się, że masz odpowiednie uprawnienia
	-- Użyj odpowiednich endpointów API
end

function RobloxModule.getGuildMembers(groupId)
	-- Użyj HttpService do pobrania listy członków grupy z API Roblox
	local requestURL = "https://api.roblox.com/groups/" .. groupId .. "/users"
	local response = RobloxAPI:GetAsync(requestURL)

	if response then
		local guildMembers = json.decode(response)
		return guildMembers
	else
		print("Error fetching guild members")
		return nil
	end
end

return RobloxModule


]]--



local HttpService = game:GetService("HttpService") -- Use HttpService
local RobloxModule = {}

function RobloxModule.getPlayerData(playerId)
	-- Use HttpService to get player data from Roblox API
	local requestURL = "https://api.roblox.com/users/" .. playerId
	local success, response = pcall(function()
		return HttpService:GetAsync(requestURL)
	end)

	if success then
		local playerData = HttpService:JSONDecode(response)
		return playerData
	else
		print("Error fetching player data:", response)
		return nil
	end
end

function RobloxModule.updatePlayerData(playerId, data)
	-- Implement the updatePlayerData logic
	-- Note: You need to use proper endpoint and HTTP method for updating
end

function RobloxModule.assignRobloxRole(playerId, roleId)
	-- Implement the assignRobloxRole logic
	-- Note: You need to use proper endpoint and have the required permissions
end

function RobloxModule.revokeRobloxRole(playerId, roleId)
	-- Implement the revokeRobloxRole logic
	-- Note: You need to use proper endpoint and have the required permissions
end

function RobloxModule.getGuildMembers(groupId)
	-- Use HttpService to get the list of guild members from Roblox API
	local requestURL = "https://api.roblox.com/groups/" .. groupId .. "/users"
	local success, response = pcall(function()
		return HttpService:GetAsync(requestURL)
	end)

	if success then
		local guildMembers = HttpService:JSONDecode(response)
		return guildMembers
	else
		print("Error fetching guild members:", response)
		return nil
	end
end

return RobloxModule