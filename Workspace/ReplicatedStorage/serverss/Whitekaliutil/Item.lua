-- Item.lua

local Item = {}

function Item.createItem(position, itemName, properties)
	local newItem = Instance.new("Part")
	newItem.Position = position
	newItem.Name = itemName
	newItem.Size = properties.size or Vector3.new(1, 1, 1)
	newItem.Color = properties.color or Color3.new(1, 1, 1)
	newItem.Anchored = true
	newItem.Parent = workspace

	-- Dodanie interakcji
	local proximityPrompt = Instance.new("ProximityPrompt", newItem)
	proximityPrompt.ActionText = "Collect " .. itemName
	proximityPrompt.Triggered:Connect(function(player)
		Item.collectItem(player, newItem)
	end)

	return newItem
end

function Item.collectItem(player, item)
	print(player.Name .. " collected " .. item.Name)
	item:Destroy()
end

function Item.checkItemCollision(player, item)
	-- Logika sprawdzająca kolizję gracza z przedmiotem
end

return Item
