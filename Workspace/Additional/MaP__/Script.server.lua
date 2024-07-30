print("World is a map?!")



print('Miastox Gra  w  stylu  Sandbox-OpenWorld  z  Si  "PaE Director"  i  unikalnymi  postaciami  NPC,  przestrzegając  zasady  "Kodeksu  Bieli".	')
print("Updated 30 - 07 - 2024 Stay tunned!")
print("Updated 30 - 07 - 2024 Stay tunned!")
print("Updated 30 - 07 - 2024 Stay tunned!")

print(## Dane:

	* **Styl gry:**  Sandbox-OpenWorld
	* **"PaE Director"**:  Centralny  "NPC"  kontrolujący  grę.
	* **"Kodeks Bieli"**:  Zbiór  zasad  gry  ustalonych  przez  Whitekali.
	* **Elementy  fabularne:**  Tajemnice  miasta  i  unikalne  postacie  NPC.
	* **Współpraca  i  współzawodnictwo:**  Możliwość  gry  w  zespole  lub  konkurowania  z  innymi  graczami.

	1. **Moduł `PartManager.lua`**: Zaktualizowany do zarządzania częściami przy użyciu unikalnych identyfikatorów i nazw. Dodane funkcje do manipulowania metadanymi, statusami i usuwania części.

			2. **Moduł `PlatformCreation.lua`**: Korzysta z `PartManager` do tworzenia platform.

				3. **Moduł `CentralPart.lua`**: Zarządza klonami i ich stanami.

				4. **Moduł `Admin.lua`**: Umożliwia administrację strukturami w grze, z kontrolą uprawnień i logowaniem działań.

				5. **Moduł `PaEDirector.lua`**: Zarządza poziomami mapy i stanem gry, integrując nowe zarządzanie częściami.

				6. **Moduł `GameLoop.lua`**: Kontroluje pętlę gry, aktualizując stan gry i zarządzając cyklem gry.


--[[nowy wzór-- main.lua

-- Import modułu PaEDirector
local PaEDirector = require(game:GetService("ReplicatedStorage").PaEDirector)

-- Utwórz instancję PaEDirector
local paeDirector = PaEDirector.new()

-- Uruchom grę
paeDirector:startGame()

-- Główna pętla gry
game:GetService("RunService").Heartbeat:Connect(function(deltaTime)
    paeDirector:updateGame(deltaTime)
end)]]--




				-- Importowanie modułów
				local MapGeneration = require("MapGeneration")
				local PlatformCreation = require("PlatformCreation")
				local CentralPart = require("CentralPart")
				local Player = require("Player")
				local Item = require("Item")
				local Admin = require("Admin")
				local PaEDirector = require("PaEDirector")

				-- Inicjalizacja gry

				PaEDirector.initialize()

				-- Ładowanie Kodeksu Bieli
				local kodeksBieli = PaEDirector.loadKodeksBieli("path/to/kodeks_bieli.json")
				PaEDirector.applyKodeksBieli(kodeksBieli)

				-- Główna pętla gry
				local function gameLoop()
					while true do
						local level = MapGeneration.generateMapLevel()
						PaEDirector.buildMap(level)

						local clones = CentralPart.generateClones(10)

						for _, player in ipairs(game.Players:GetPlayers()) do
							PaEDirector.monitorPlayerActions(player)

							if Player.checkPlayerCollision(Item) then
								Player.collectItem(Item)
							end

							if PaEDirector.checkMapEnd(player) then
								PaEDirector.handleGameEvent("MapEnd")
							end
						end

						PaEDirector.updateGameState()
						wait(0.1)
					end
				end

				-- Uruchomienie gry
				gameLoop()
