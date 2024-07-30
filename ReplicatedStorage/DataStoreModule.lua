local DataStoreService = game:GetService("DataStoreService")
local UserRolesDataStore = DataStoreService:GetDataStore("UserRolesDataStore")
local RoleMappingDataStore = DataStoreService:GetDataStore("RoleMappingDataStore")
local PlayerDataMappingDataStore = DataStoreService:GetDataStore("PlayerDataMappingDataStore")

local DataStoreModule = {}

function DataStoreModule.getUserRoles(userId)
	local roles = UserRolesDataStore:GetAsync(userId)
	return roles
end

function DataStoreModule.updateUserRoles(userId, roles)
	UserRolesDataStore:SetAsync(userId, roles)
end

function DataStoreModule.getRoleMapping(roleId)
	local robloxRole = RoleMappingDataStore:GetAsync(roleId)
	return robloxRole
end

function DataStoreModule.updateRoleMapping(roleId, robloxRole)
	RoleMappingDataStore:SetAsync(roleId, robloxRole)
end

function DataStoreModule.getPlayerData(playerId)
	local playerData = PlayerDataMappingDataStore:GetAsync(playerId)
	return playerData
end

function DataStoreModule.updatePlayerData(playerId, data)
	PlayerDataMappingDataStore:SetAsync(playerId, data)
end

return DataStoreModule