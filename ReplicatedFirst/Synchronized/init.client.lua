
local size = script:GetAttribute("Size") or 64
local load = script:GetAttribute("Load") or 16
local unload = script:GetAttribute("Unload") or 32
local events = {["Initialize"] = {}, ["Deinitialize"] = {}, ["Load"] = {}, ["Unload"] = {}}
local modules = {}
local loaded = {}
local cameraX = math.huge
local cameraZ = math.huge
local focusX = math.floor(cameraX / size)
local focusZ = math.floor(cameraZ / size)
local amount = (load * 2 + 1) ^ 2
local distance = size ^ 2
load = load ^ 2 + 1
unload = unload ^ 2 + 1

-- Funkcja ładująca chunk
local function LoadChunk(chunkX, chunkZ)
	if loaded[chunkX] == nil then loaded[chunkX] = {} end
	if loaded[chunkX][chunkZ] ~= nil then return end
	loaded[chunkX][chunkZ] = true
	for i, callback in events.Load do callback(script, modules, chunkX, chunkZ) end
	task.wait()
end

-- Funkcja rozładowująca chunk
local function UnloadChunk(chunkX, chunkZ)
	loaded[chunkX][chunkZ] = nil
	if next(loaded[chunkX]) == nil then loaded[chunkX] = nil end
	for i, callback in events.Unload do callback(script, modules, chunkX, chunkZ) end
	task.wait()
end

-- Ładowanie modułów
for i, descendant in script:GetDescendants() do
	if descendant.ClassName ~= "ModuleScript" then continue end
	local module = require(descendant)
	modules[descendant] = module
	if type(module) ~= "table" then continue end
	for name, callbacks in events do
		if type(module[name]) == "function" then table.insert(callbacks, module[name]) end
	end
end

-- Inicjalizacja
for i, callback in events.Initialize do callback(script, modules) end

-- Obsługa zmian atrybutów
script.AttributeChanged:Connect(function(attribute)
	if attribute == "Size" then
		size = script:GetAttribute("Size") or 64
		distance = size ^ 2
	end
	if attribute == "Load" then
		load = script:GetAttribute("Load") or 16
		amount = (load * 2 + 1) ^ 2
		load = load ^ 2 + 1
	end
	if attribute == "Unload" then
		unload = script:GetAttribute("Unload") or 32
		unload = unload ^ 2 + 1
	end
end)

-- Obsługa zmian punktu skupienia kamery
workspace.CurrentCamera:GetPropertyChangedSignal("Focus"):Connect(function()
	local x, z = workspace.CurrentCamera.Focus.Position.X, workspace.CurrentCamera.Focus.Position.Z
	focusX, focusZ = math.floor(x / size), math.floor(z / size)
	if (cameraX - x) ^ 2 + (cameraZ - z) ^ 2 <= distance then return end
	cameraX, cameraZ = x, z
	local chunkX, chunkZ, directionX, directionZ, count, length = focusX, focusZ, 1, 0, 0, 1
	for i = 1, amount do
		if (chunkX - focusX) ^ 2 + (chunkZ - focusZ) ^ 2 <= load then LoadChunk(chunkX, chunkZ) end
		chunkX += directionX chunkZ += directionZ count += 1
		if count == length then count = 0 directionX, directionZ = -directionZ, directionX if directionZ == 0 then length += 1 end end
	end
	if unload < load then return end
	for chunkX, data in loaded do
		for chunkZ, value in data do
			if (chunkX - focusX) ^ 2 + (chunkZ - focusZ) ^ 2 <= unload then continue end
			UnloadChunk(chunkX, chunkZ)
		end
	end
end)

--[[
Ten kod zarządza chunkami w grze Roblox. Oto główne funkcje:

1. Zarządzanie chunkami: Ładowanie i rozładowywanie chunków w zależności od położenia kamery.
2. Dostosowywanie rozmiaru chunków: Możliwość ustawienia rozmiaru chunków poprzez atrybuty "Size", "Load" i "Unload".
3. Wykonywanie funkcji w chunkach: Możliwość dodawania funkcji do chunków, które są wywoływane podczas ładowania i rozładowywania.
4. Zarządzanie modułami: Możliwość ładowania modułów Lua i wywoływania ich funkcji w chunkach.

Główne elementy kodu:

- Funkcja LoadChunk: Ładuje chunk o podanych współrzędnych.
- Funkcja UnloadChunk: Rozładowuje chunk o podanych współrzędnych.
- Ładowanie modułów: Pętla przechodzi przez wszystkie potomne skryptu i ładuje moduły Lua.
- Inicjalizacja: Wywołuje funkcje inicjalizacji z modułów.
- Obsługa zmian atrybutów: Aktualizuje ustawienia size, load i unload.
- Obsługa zmian punktu skupienia kamery: Ładuje chunki w pobliżu punktu skupienia i rozładowuje te, które są daleko.

Ten system pozwala na optymalizację wydajności gry poprzez dynamiczne zarządzanie zasobami w zależności od położenia kamery gracza.
]]













--[[     old scrip ]]--
--[[     old scrip ]]--
--[[     old scrip ]]--
--[[     old scrip ]]--
--[[     old scrip ]]--
--[[     old scrip ]]--
--[[     old scrip ]]--
--[[     old scrip ]]--
--[[     old scrip ]]--



--[[


local size = script:GetAttribute("Size") or 64
local load = script:GetAttribute("Load") or 16
local unload = script:GetAttribute("Unload") or 32
local events = {["Initialize"] = {}, ["Deinitialize"] = {}, ["Load"] = {}, ["Unload"] = {}}
local modules = {}
local loaded = {}
local cameraX = math.huge
local cameraZ = math.huge
local focusX = math.floor(cameraX / size)
local focusZ = math.floor(cameraZ / size)
local amount = (load * 2 + 1) ^ 2
local distance = size ^ 2
load = load ^ 2 + 1
unload = unload ^ 2 + 1




local function LoadChunk(chunkX, chunkZ)
	if loaded[chunkX] == nil then loaded[chunkX] = {} end
	if loaded[chunkX][chunkZ] ~= nil then return end
	loaded[chunkX][chunkZ] = true
	for i, callback in events.Load do callback(script, modules, chunkX, chunkZ) end
	task.wait()
end





local function UnloadChunk(chunkX, chunkZ)
	loaded[chunkX][chunkZ] = nil
	if next(loaded[chunkX]) == nil then loaded[chunkX] = nil end
	for i, callback in events.Unload do callback(script, modules, chunkX, chunkZ) end
	task.wait()
end




for i, descendant in script:GetDescendants() do
	if descendant.ClassName ~= "ModuleScript" then continue end
	local module = require(descendant)
	modules[descendant] = module
	if type(module) ~= "table" then continue end
	for name, callbacks in events do
		if type(module[name]) == "function" then table.insert(callbacks, module[name]) end
	end
end



for i, callback in events.Initialize do callback(script, modules) end

script.AttributeChanged:Connect(function(attribute)
	if attribute == "Size" then
		size = script:GetAttribute("Size") or 64
		distance = size ^ 2
	end
	if attribute == "Load" then
		load = script:GetAttribute("Load") or 16
		amount = (load * 2 + 1) ^ 2
		load = load ^ 2 + 1
	end
	if attribute == "Unload" then
		unload = script:GetAttribute("Unload") or 32
		unload = unload ^ 2 + 1
	end
end)




workspace.CurrentCamera:GetPropertyChangedSignal("Focus"):Connect(function()
	local x, z = workspace.CurrentCamera.Focus.Position.X, workspace.CurrentCamera.Focus.Position.Z
	focusX, focusZ = math.floor(x / size), math.floor(z / size)
	if (cameraX - x) ^ 2 + (cameraZ - z) ^ 2 <= distance then return end
	cameraX, cameraZ = x, z
	local chunkX, chunkZ, directionX, directionZ, count, length = focusX, focusZ, 1, 0, 0, 1
	for i = 1, amount do
		if (chunkX - focusX) ^ 2 + (chunkZ - focusZ) ^ 2 <= load then LoadChunk(chunkX, chunkZ) end
		chunkX += directionX chunkZ += directionZ count += 1
		if count == length then count = 0 directionX, directionZ = -directionZ, directionX if directionZ == 0 then length += 1 end end
	end
	if unload < load then return end
	for chunkX, data in loaded do
		for chunkZ, value in data do
			if (chunkX - focusX) ^ 2 + (chunkZ - focusZ) ^ 2 <= unload then continue end
			UnloadChunk(chunkX, chunkZ)
		end
	end
end)






]]--

--[[     old scrip ]]--
--[[     old scrip ]]--
--[[     old scrip ]]--
--[[     old scrip ]]--
--[[     old scrip ]]--
--[[     old scrip ]]--
--[[     old scrip ]]--
--[[     old scrip ]]--
--[[     old scrip ]]--