-- OverheadGUIModule.lua
local DataStoreModule = require(game.ReplicatedStorage.DataStoreModule)
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local PlayerModule = require(shared.ReplicatedStorage.PlayerModule)
local OverheadGUIModule = {}

-- Ustawienia GUI
local OwnerOverheadGui = game:FindFirstDescendant("OwnerOverheadGui")
local VIPOverheadGui = game:FindFirstDescendant("VIPOverheadGui")
local DonatorOverheadGui = game:FindFirstDescendant("DonatorOverheadGui")
local OverheadGui = game:FindFirstDescendant("OverheadGui")

function OverheadGUIModule.getOverheadGui(player)
	local highestRole = DataStoreModule.getUserRoles(player.UserId)
	local overheadGui
	if highestRole == "Admin" then
		overheadGui = OwnerOverheadGui
	elseif highestRole == "Moderator" then
		overheadGui = VIPOverheadGui
	elseif highestRole == "Donator" then
		overheadGui = DonatorOverheadGui
	else
		overheadGui = OverheadGui
	end
	return overheadGui
end

function OverheadGUIModule.updateOverheadGui(player)
	local overheadGui = OverheadGUIModule.getOverheadGui(player)

	-- Klonowanie GUI
	local playerGui = player:WaitForChild("PlayerGui")
	local cloneGui = overheadGui:Clone()
	cloneGui.Parent = playerGui

	-- Ustawianie nazwy i innych danych
	local nameLabel = cloneGui:FindFirstDescendant("NameLabel")
	nameLabel.Text = player.Name

	-- Ustawianie koloru poziomu
	local levelLabel = cloneGui:FindFirstDescendant("LevelLabel")
	local level = PlayerModule.getPlayerData(player.UserId).level
	if level >= 100 then
		levelLabel.TextColor3 = Color3.new(1, 0, 0)
	elseif level >= 50 then
		levelLabel.TextColor3 = Color3.new(0, 1, 0)
	else
		levelLabel.TextColor3 = Color3.new(0, 0, 1)
	end

	-- Dodatkowe ustawienia
	-- ...

	-- Upewnij się, że GUI jest widoczne
	cloneGui.Visible = true
end

-- Wywołanie funkcji updateOverheadGui dla każdego gracza
function OverheadGUIModule.init()
	RunService.PlayerAdded:Connect(function(player)
		OverheadGUIModule.updateOverheadGui(player)

		-- Nasłuchiwanie zmian ról gracza
		player.CharacterAdded:Connect(function(character)
			-- Dodaj kod do aktualizacji GUI w przypadku zmian ról
			-- np. nasłuchiwanie Eventów zmieniających role w Roblox.
		end)
	end)
end

return OverheadGUIModule

--[[
```lua

	**Wyjaśnienie:**

	* **`getOverheadGui(player)`:** Określa, które GUI wyświetlić nad głową gracza, w zależności od jego roli na Discordzie (Admin, Moderator, Donator, lub domyślne).
	* **`updateOverheadGui(player)`:** Klonuje odpowiednie GUI i ustawia jego nazwę, poziom i kolor tekstu. Dodatkowo,  zapewnia, że GUI jest widoczne.
	* **`init()`:** Inicjalizuje moduł. W momencie dodania gracza do gry (zdarzenie `PlayerAdded`),  wywołuje funkcję `updateOverheadGui` aby wyświetlić odpowiednie GUI. Dodatkowo, nasłuchuje zdarzenia `CharacterAdded` aby zaktualizować GUI w przypadku zmian ról gracza. 

	**Dodatkowe informacje:**

	* **GUI:** Zostało założone, że w grze istnieją już  GUI o nazwach `OwnerOverheadGui`, `VIPOverheadGui`, `DonatorOverheadGui` i `OverheadGui`. Upewnij się, że te GUI istnieją w Twojej grze i posiadają odpowiednie elementy (np. `NameLabel`, `LevelLabel`).
	* **Zmiana ról:** Aby zaktualizować GUI po zmianie roli gracza, musisz dodać logikę do funkcji `CharacterAdded`, która nasłuchuje zmian ról w grze. Możesz to zrobić, nasłuchując odpowiednich Eventów w Roblox, które sygnalizują zmianę ról.
		* **Dodatkowe ustawienia:**  Możesz dodać więcej logiki do funkcji `updateOverheadGui` aby ustawić dodatkowe elementy GUI (np.  obrazki, animacje).

			Pamiętaj, że ten kod 


local DataStoreModule = require("DataStoreModule.lua")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local OverheadGUIModule = {}

-- Ustawienia GUI
local OwnerOverheadGui = game:FindFirstDescendant("OwnerOverheadGui")
local VIPOverheadGui = game:FindFirstDescendant("VIPOverheadGui")
local DonatorOverheadGui = game:FindFirstDescendant("DonatorOverheadGui")
local OverheadGui = game:FindFirstDescendant("OverheadGui")

function OverheadGUIModule.getOverheadGui(player)
	local highestRole = DataStoreModule.getUserRoles(player.UserId)
	local overheadGui
	if highestRole == "Admin" then
		overheadGui = OwnerOverheadGui
	elseif highestRole == "Moderator" then
		overheadGui = VIPOverheadGui
	elseif highestRole == "Donator" then
		overheadGui = DonatorOverheadGui
	else
		overheadGui = OverheadGui
	end
	return overheadGui
end

function OverheadGUIModule.updateOverheadGui(player)
	local overheadGui = OverheadGUIModule.getOverheadGui(player)

	-- Klonowanie GUI
	local playerGui = player:WaitForChild("PlayerGui")
	local cloneGui = overheadGui:Clone()
	cloneGui.Parent = playerGui

	-- Ustawianie nazwy i innych danych
	local nameLabel = cloneGui:FindFirstDescendant("NameLabel")
	nameLabel.Text = player.Name

	-- Ustawianie koloru poziomu
	local levelLabel = cloneGui:FindFirstDescendant("LevelLabel")
	local level = PlayerModule.getPlayerData(player.UserId).level
	if level >= 100 then
		levelLabel.TextColor3 = Color3.new(1, 0, 0)
	elseif level >= 50 then
		levelLabel.TextColor3 = Color3.new(0, 1, 0)
	else
		levelLabel.TextColor3 = Color3.new(0, 0, 1)
	end

	-- Dodatkowe ustawienia
	-- ...

	-- Upewnij się, że GUI jest widoczne
	cloneGui.Visible = true
end

-- Wywołanie funkcji updateOverheadGui dla każdego gracza
function OverheadGUIModule.init()
	RunService.PlayerAdded:Connect(function(player)
		OverheadGUIModule.updateOverheadGui(player)

		-- Nasłuchiwanie zmian ról gracza
		player.CharacterAdded:Connect(function(character)
			-- Dodaj kod do aktualizacji GUI w przypadku zmian ról
			-- np. nasłuchiwanie Eventów zmieniających role w Roblox.
		end)
	end)
end

return OverheadGUIModule
```
]]--