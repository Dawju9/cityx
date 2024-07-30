-- RobloxAPI.lua
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local RobloxAPI = {}

-- Funkcja do pobrania danych gracza z API Roblox
function RobloxAPI.getPlayerData(playerId)
	local url = string.format("https://api.roblox.com/users/%d", playerId)
	local headers = {
		["Content-Type"] = "application/json"
	}
	local success, response = pcall(function()
		return HttpService:GetAsync(url, false, headers)
	end)
	if success then
		return HttpService:JSONDecode(response)
	else
		warn("Error retrieving player data from API: ", response)
		return nil
	end
end

-- Funkcja do dodania roli graczowi w Roblox
function RobloxAPI.assignRobloxRole(playerId, roleId)
	local player = Players:GetPlayerByUserId(playerId)
	if player then
		player:AddRole(roleId)
	end
end

-- Funkcja do usunięcia roli graczowi w Roblox
function RobloxAPI.revokeRobloxRole(playerId, roleId)
	local player = Players:GetPlayerByUserId(playerId)
	if player then
		player:RemoveRole(roleId)
	end
end

return RobloxAPI