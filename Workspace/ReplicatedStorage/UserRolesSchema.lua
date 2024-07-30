
-- game.ReplicatedStorage.UserRolesSchema.lua
local Schema = require(game.ReplicatedStorage.Schema)

local UserRolesSchema = Schema.new("UserRolesSchema")

UserRolesSchema:add("discordId", true)
UserRolesSchema:add("roles", true)
UserRolesSchema:add("username",  true)
UserRolesSchema:add("globalName",  true)

return UserRolesSchema

--[[


local Schema = require(game.ReplicatedStorage.Schema)

local UserRolesSchema = Schema.new("UserRolesSchema")

UserRolesSchema:add("discordId", true)
UserRolesSchema:add("roles", true)
UserRolesSchema:add("username",  true)
UserRolesSchema:add("globalName",  true)

return UserRolesSchema
]]--