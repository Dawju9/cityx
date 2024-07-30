-- Kalimodel modified the script for door handling

disasters = {"001"} -- List of floor models
countdownTime = 60 -- Time to wait between floors
disasterTime = 60 * 60 * 1.4 * 1 -- Time floor stays in game

countdownMessage = "Next Floor in %s seconds!"
disasterMessage = "Floor: %s"

items = {}
local printTime = disasterTime
local leaderboard = game.Workspace:FindFirstChild("BTS Leaderboard")

-- Load disaster items from Lighting
for i = 1, #disasters do
	local item = game.Lighting:FindFirstChild(disasters[i])
	if item then
		table.insert(items, item:Clone())
	else
		warn("Error! ", disasters[i], " was not found in Lighting!")
	end
end

-- Function to choose a random disaster
function chooseDisaster()
	return items[math.random(#items)]
end

-- Function to set hint text
function setHint(text)
	local hint = game.Workspace:FindFirstChild("hint")
	if hint then
		hint.Text = text
	else
		warn("Hint does not exist, creating...")
		local h = Instance.new("Hint")
		h.Name = "hint"
		h.Text = text
		h.Parent = game.Workspace
	end
end

-- Function to remove hint
function removeHint()
	local hint = game.Workspace:FindFirstChild("hint")
	if hint then hint:Destroy() end
end

-- Function to handle countdown
function countdown(time)
	setHint(string.format(countdownMessage, tostring(time)))
	while time > 0 do
		wait(1)
		time = time - 1
		setHint(string.format(countdownMessage, tostring(time)))
	end
	removeHint()
	return true
end

-- Function to log events
function logEvent(action)
	local timestamp = os.date("%H:%M:%S")
	print("Event: " .. action .. " at " .. timestamp)
end

-- Locate the BillboardGui parent part
local billboardPart = game.Workspace:FindFirstChild("BillboardGuiPart")
if not billboardPart then
	error("BillboardGuiPart not found in Workspace.")
end

-- Billboard GUI for event logging
local billboard = Instance.new("BillboardGui", billboardPart)
billboard.Size = UDim2.new(0, 200, 0, 50)
billboard.StudsOffset = Vector3.new(0, 5, 0)
local textLabel = Instance.new("TextLabel", billboard)
textLabel.Size = UDim2.new(1, 0, 1, 0)
textLabel.TextScaled = true
textLabel.BackgroundTransparency = 1

-- Function to update billboard text
function updateBillboard(status)
	local timestamp = os.date("%H:%M:%S")
	textLabel.Text = string.format("Status: %s\nTime: %s", status, timestamp)
end

-- Function to handle elevator doors
local door = script.Parent
function openDoors()
	door.Transparency = 1
	door.CanCollide = false
	logEvent("Doors Opened")
	updateBillboard("Doors Opened")
end

function closeDoors()
	door.Transparency = 0
	door.CanCollide = true
	logEvent("Doors Closed")
	updateBillboard("Doors Closed")
end

-- Main loop
while true do
	countdown(countdownTime)

	if leaderboard and leaderboard:FindFirstChild("running") and leaderboard:FindFirstChild("points") then
		leaderboard.points.Value = 30
		leaderboard.running.Value = true
	end

	local m = chooseDisaster()
	m.Parent = game.Workspace
	m:MakeJoints()

	-- Log and update billboard
	logEvent("Floor: " .. m.Name)
	updateBillboard("Floor: " .. m.Name)

	openDoors()
	wait(3) -- Time doors stay open
	closeDoors()

	wait(disasterTime)
	m:Destroy()

	if leaderboard then
		leaderboard.running.Value = false
	end
end





-- Ajedi32 created the script!
-- Vitorrobloxgames edited Script and instructions!

--disasters = {"001"} -- This is where you list the names models that you want to use for FLOORS.
-- The list must look like this {"001","002",} and so on.
-- Floor names are case-sensitive and all Floor models must be in the lighting
--[[,"002","003"} ]]--
--[[
-- Configuration
countdownTime = 60 -- The amount of time to wait between each Floor.
disasterTime = 60 * 60 * 1.4 * 1 -- The amount of time that the Floor will be in the game before it is removed.
countdownMessage = "Next Floor in %s seconds!" -- The message displayed between disasters. %s will be replaced with the number of seconds left.
disasterMessage = "Floor: %s" -- The message displayed when a disaster occurs. %s will be replaced with the disaster name. Set to nil if you do not want a message

-- Initialization
items = {}
local printTime = disasterTime
leaderboard = game.Workspace:findFirstChild("BTS Leaderboard") -- Used to work with my BTS leaderboard
local w = game.Workspace:getChildren()
for i=1,#w do
	if w[i].Name == "leaderboard" and w[i]:findFirstChild("running") ~= nil and w[i]:findFirstChild("points") ~= nil then
		leaderboard = w[i]
	end
end
for i=1,#disasters do
	local item = game.Lighting:findFirstChild(disasters[i])
	if item ~= nil then
		item.Parent = nil
		table.insert(items, item)
	else
		print("Error! ", disasters[i], " was not found!")
	end
end

-- Function to choose a random disaster
function chooseDisaster()
	return items[math.random(#items)]
end

-- Function to set hint text in the workspace
function sethint(text)
	local hint = game.Workspace:findFirstChild("hint")
	if (hint ~= nil) then
		hint.Text = text
	else
		print("Hint does not exist, creating...")
		local h = Instance.new("Hint")
		h.Name = "hint"
		h.Text = text
		h.Parent = game.Workspace
	end
end

-- Function to remove hint from the workspace
function removeHint()
	local hint = game.Workspace:findFirstChild("hint")
	if (hint ~= nil) then hint:remove() end
end

-- Function to handle countdown and hints
function countdown(time)
	sethint(string.format(countdownMessage, tostring(time)))
	while (time > 0) do
		wait(1)
		time = time - 1
		sethint(string.format(countdownMessage, tostring(time)))
	end
	removeHint()
	return true
end

-- Function to log events with timestamp
function logEvent(action)
	local timestamp = os.date("%H:%M:%S") -- Pobiera bieżący czas
	print("Event: " .. action .. " at " .. timestamp)
end

-- Billboard for displaying events
local billboard = Instance.new("BillboardGui", game.Workspace)
billboard.Size = UDim2.new(0, 200, 0, 50)
billboard.StudsOffset = Vector3.new(0, 5, 0)
local textLabel = Instance.new("TextLabel", billboard)
textLabel.Size = UDim2.new(1, 0, 1, 0)
textLabel.TextScaled = true
textLabel.BackgroundTransparency = 1

-- Function to update text on the billboard
function updateBillboard(action)
	local timestamp = os.date("%H:%M:%S")
	textLabel.Text = action .. " at " .. timestamp
end

-- Main loop
while true do
	countdown(countdownTime)

	if leaderboard ~= nil and leaderboard:findFirstChild("running") and leaderboard:findFirstChild("points") then
		leaderboard.points.Value = 30 -- Points after you survive disasters.
		leaderboard.running.Value = true
	end

	local m = chooseDisaster():clone()

	if disasterMessage ~= nil then
		local msg = Instance.new("Message")
		msg.Name = "DisasterMsg"
		msg.Text = string.format(disasterMessage, m.Name)
		msg.Parent = game.Workspace
		wait(3)
		msg:Destroy()
	end

	m.Parent = game.Workspace
	m:makeJoints()

	-- Log and update billboard
	logEvent("Floor: " .. m.Name)
	updateBillboard("Floor: " .. m.Name)

	wait(disasterTime)
	m:Destroy()

	if leaderboard ~= nil then
		leaderboard.running.Value = false
	end
end-- Ajedi32 created the script!
-- Vitorrobloxgames edited Script and instructions!
]]--











--[[,"002","003"} ]]--

--[[





-- Ajedi32 created the script!
-- Vitorrobloxgames edited Script and instructions!
-- Kalimodel modified the script for door handling

disasters = {"001"} -- List of floor models
countdownTime = 60 -- Time to wait between floors
disasterTime = 60 * 60 * 1.4 * 1 -- Time floor stays in game

countdownMessage = "Next Floor in %s seconds!"
disasterMessage = "Floor: %s"

items = {}
local printTime = disasterTime
local leaderboard = game.Workspace:FindFirstChild("BTS Leaderboard")

-- Load disaster items from Lighting
for i = 1, #disasters do
	local item = game.Lighting:FindFirstChild(disasters[i])
	if item then
		table.insert(items, item:Clone())
	else
		print("Error! ", disasters[i], " was not found!")
	end
end

-- Function to choose a random disaster
function chooseDisaster()
	return items[math.random(#items)]
end

-- Function to set hint text
function setHint(text)
	local hint = game.Workspace:FindFirstChild("hint")
	if hint then
		hint.Text = text
	else
		print("Hint does not exist, creating...")
		local h = Instance.new("Hint")
		h.Name = "hint"
		h.Text = text
		h.Parent = game.Workspace
	end
end

-- Function to remove hint
function removeHint()
	local hint = game.Workspace:FindFirstChild("hint")
	if hint then hint:Destroy() end
end

-- Function to handle countdown
function countdown(time)
	setHint(string.format(countdownMessage, tostring(time)))
	while time > 0 do
		wait(1)
		time = time - 1
		setHint(string.format(countdownMessage, tostring(time)))
	end
	removeHint()
	return true
end

-- Function to log events
function logEvent(action)
	local timestamp = os.date("%H:%M:%S")
	print("Event: " .. action .. " at " .. timestamp)
end

-- Billboard GUI for event logging
local billboard = Instance.new("BillboardGui", game.Workspace)
billboard.Size = UDim2.new(0, 200, 0, 50)
billboard.StudsOffset = Vector3.new(0, 5, 0)
local textLabel = Instance.new("TextLabel", billboard)
textLabel.Size = UDim2.new(1, 0, 1, 0)
textLabel.TextScaled = true
textLabel.BackgroundTransparency = 1

-- Function to update billboard text
function updateBillboard(action)
	local timestamp = os.date("%H:%M:%S")
	textLabel.Text = action .. " at " .. timestamp
end

-- Function to handle elevator doors
local door = script.Parent
function openDoors()
	door.Transparency = 1
	door.CanCollide = false
	logEvent("Doors Opened")
	updateBillboard("Doors Opened")
end

function closeDoors()
	door.Transparency = 0
	door.CanCollide = true
	logEvent("Doors Closed")
	updateBillboard("Doors Closed")
end

-- Main loop
while true do
	countdown(countdownTime)

	if leaderboard and leaderboard:FindFirstChild("running") and leaderboard:FindFirstChild("points") then
		leaderboard.points.Value = 30
		leaderboard.running.Value = true
	end

	local m = chooseDisaster()
	m.Parent = game.Workspace
	m:MakeJoints()

	-- Log and update billboard
	logEvent("Floor: " .. m.Name)
	updateBillboard("Floor: " .. m.Name)

	openDoors()
	wait(3) -- Time doors stay open
	closeDoors()

	wait(disasterTime)
	m:Destroy()

	if leaderboard then
		leaderboard.running.Value = false
	end
end
















disasters = {"001"} -- This is where you list the names models that you want to use for FLOORS.
-- The list must look like this {"001","002",} and so on.
-- Floor names are case-sensitive and all Floor models must be in the lighting

countdownTime = 60 -- The ammount of time to wait between each Floor.
disasterTime = 60*60*1.4*1 -- The ammount of time that the Floor will be in the game before it is removed.

countdownMessage = "Next Floor in %s seconds!" -- The message displayed between disasters. %s will be replaced with the number of seconds left.
disasterMessage = "Floor: %s" -- The message displayed when a disaster occurs. %s will be replaced with the disaster name. Set to nil if you do not want a message

-- Unless you know what you are doing, please leave the below code alone.
items = {}
local printTime = disasterTime
leaderboard = game.Workspace:findFirstChild("BTS Leaderboard") -- Used to work with my BTS leaderboard
local w = game.Workspace:getChildren()
for i=1,#w do
	if w[i].Name == "leaderboard" and w[i]:findFirstChild("running") ~= nil and w[i]:findFirstChild("points") ~= nil then
		leaderboard = w[i]
	end
end
for i=1,#disasters do
	local item = game.Lighting:findFirstChild(disasters[i])
	if item ~= nil then
		item.Parent = nil
		table.insert(items, item)
	else
		print("Error! ", disasters[i], " was not found!")
	end
end

function chooseDisaster()
	return items[math.random(#items)]
end

function sethint(text)
	local hint = game.Workspace:findFirstChild("hint")
	if (hint ~= nil) then
		hint.Text = text
	else
		print("Hint does not exist, creating...")
		local h = Instance.new("Hint")
		h.Name = "hint"
		h.Text = text
		h.Parent = game.Workspace
	end
	--print("Hint set to: ", text)
end

function removeHint()
	local	hint = game.Workspace:findFirstChild("hint")
	if (hint ~= nil) then hint:remove() end
end

function countdown(time)
	sethint(string.format(countdownMessage, tostring(time)))
	while (time > 0) do
		wait(1)
		time = time - 1
		sethint(string.format(countdownMessage, tostring(time)))
	end
	removeHint()
	return true
end

while true do
	countdown(countdownTime)

	if leaderboard ~= nil and leaderboard:findFirstChild("running") and leaderboard:findFirstChild("points") then -- For use with my BTS leaderboard.
		leaderboard.points.Value = 30 --Points after you survive disasters.
		leaderboard.running.Value = true
	end

	local m = chooseDisaster():clone()

	if disasterMessage ~= nil then
		local msg = Instance.new("Message")
		msg.Name = "DisasterMsg"
		msg.Text = string.format(disasterMessage, m.Name)
		msg.Parent = game.Workspace
		wait(3)
		msg.Parent = nil
	end

	m.Parent = game.Workspace
	m:makeJoints()
	wait(disasterTime)
	m:remove()

	if leaderboard ~= nil then -- For use with the bts leaderboard.
		leaderboard.running.Value = false
	end
end
local function logEvent(action)
	local timestamp = os.date("%H:%M:%S") -- Pobiera bieżący czas
	-- Kod do zapisania lub wyświetlenia zdarzenia
	print("Event: " .. action .. " at " .. timestamp)
end

-- Przykład użycia:
logEvent("Elevator Arrived")
logEvent("Doors Opened")
logEvent("Doors Closed")
local textLabel = Instance.new("TextLabel")
local textLabel.Size = 2

-- Funkcja do aktualizacji tekstu na billboardzie
function updateBillboard(action)
	local timestamp = os.date("%H:%M:%S")
	textLabel.Text = action .. " at " .. timestamp
end

-- Przykład użycia funkcji w kontekście zdarzeń windy
-- Można to zintegrować z istniejącymi funkcjami skryptu windy
updateBillboard("Elevator Arrived")
wait(2)
updateBillboard("Doors Opened")
wait(2)
updateBillboard("Doors Closed")
]]--