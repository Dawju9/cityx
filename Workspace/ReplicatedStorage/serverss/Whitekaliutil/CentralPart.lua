-- CentralPart.lua

local CentralPart = {}

function CentralPart.generateClones()
	local part = workspace:FindFirstChild("CentralPart")
	local part = workspace:FindFirstChild("CentralPart")
	local positions = {
		Vector3.new(5, 0, 0),
		Vector3.new(0, 0, 5),
		Vector3.new(5, 0, 5),
	}

	for _, offset in ipairs(positions) do
		local clone = part:Clone()
		clone.Position = part.Position + offset
		clone.Parent = workspace
	end
end

return CentralPart
