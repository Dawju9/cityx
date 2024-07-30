-- game.ReplicatedStorage.Schema.lua
local Schema = {}

function Schema.new(schemaName)
	local self = {}
	self.schemaName = schemaName
	self.fields = {}

	function self:add(fieldName, required)
		self.fields[fieldName] = { required = required or false }
	end

	function self:validate(data)
		if not data then
			error("No data provided for validation.")
		end

		for fieldName, fieldData in pairs(self.fields) do
			if fieldData.required and data[fieldName] == nil then
				error("Missing required field: " .. fieldName .. " in schema: " .. self.schemaName)
			end
		end

		return true
	end

	return self
end

return Schema
-- local test
