-- RoleMappingSchema.lua
local Schema = require(game.ReplicatedStorage.PlayerDataSchema)

local RoleMappingSchema = Schema.new("RoleMappingSchema")

RoleMappingSchema:add("roles",true)

return RoleMappingSchema