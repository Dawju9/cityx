-- PlayerDataSchema.lua
local Schema = require(game.ReplicatedStorage.Schema)

local PlayerDataSchema = Schema.new("PlayerDataSchema")

PlayerDataSchema:add("roblox", true)
PlayerDataSchema:add("discord",true)

return PlayerDataSchema