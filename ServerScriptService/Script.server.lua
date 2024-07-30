-- Main.lua
local PlayerManager = require(game.ReplicatedStorage.PlayerManagerModule)
local Players = game:GetService("Players")
local DataStoreModule = require(game.ReplicatedStorage.DataStoreModule)
local DiscordModule = require(game.ReplicatedStorage.DiscordModule)
local ListModule = require(game.ReplicatedStorage.ListModule)

-- Stałe (dostosuj wg potrzeb)
local userRolesDataStoreKey = "UserRolesDataStore"
local roleMappingDataStoreKey = "RoleMappingDataStore"
local userDataDataStoreKey = "UserDataDataStore"
local donatorUserId = 1234567890 -- Zastąp ID Donatora

-- GUI
local VIPOverheadGui = game.ReplicatedStorage:WaitForChild("VIPOverheadGui")
local OverheadGui =  game.ReplicatedStorage:WaitForChild("OverheadGui")
local OwnerOverheadGui =  game.ReplicatedStorage:WaitForChild("OwnerOverheadGui")
local DonatorOverheadGui =  game.ReplicatedStorage:WaitForChild("DonatorOverheadGui")

-- Listy użytkowników
local HeadAdmins =  game.ReplicatedStorage.ListModule.newList("HeadAdmins", {"gitninja", "idanaUJ23"})
local Supports =  game.ReplicatedStorage.ListModule.newList("Supports", {"Lionlover7934"})
local NoneUser =  game.ReplicatedStorage.ListModule.newList("NoneUser", {"idanaUJ23"})

-- Funkcja do generowania kluczy DataStore dynamicznie
local function generateDataStoreKey(dataStoreType, additionalInfo)
	local key = ""

	if dataStoreType == "UserRolesDataStore" then
		key = userRolesDataStoreKey
	elseif dataStoreType == "RoleMappingDataStore" then
		key = roleMappingDataStoreKey
	elseif dataStoreType == "UserDataDataStore" then
		key = userDataDataStoreKey
	else
		-- Obsługa innych przypadków lub wyrzucenie błędu, jeśli konieczne
		error("Unsupported DataStore type: " .. dataStoreType)
	end

	-- Dołącz additionalInfo do klucza, jeśli podano
	if additionalInfo then
		key = key .. "_" .. tostring(additionalInfo)
	end

	return key
end

-- Funkcja do pobrania odpowiedniego GUI nad głową
local function getOverheadGui(player,MarketplaceService)
	local playerName = player.Name
	local gamepassId = 1234567890
	if HeadAdmins:contains(playerName) then
		return OwnerOverheadGui
	end

	if Supports:contains(playerName) then
		return VIPOverheadGui
	end

	if NoneUser:contains(playerName) then
		return OverheadGui
	end

	if player.UserId == donatorUserId then
		return DonatorOverheadGui
	end

	if MarketplaceService:UserOwnsGamePassAsync(player.UserId, gamepassId) then
		return VIPOverheadGui
	end

	-- Załaduj role użytkownika z DataStore
	local userRolesData =  game.ReplicatedStorage.DataStoreModule.loadDataStore(userRolesDataStoreKey, player.UserId)
	if userRolesData and #userRolesData.roles > 0 then
		-- Pobierz najwyższą rolę
		local highestRole = userRolesData.roles[1]
		local roleName = game.ReplicatedStorage.DataStoreModule.loadDataStore(roleMappingDataStoreKey, highestRole) or "- Guest -"
		if roleName == "VIP" then
			return VIPOverheadGui
		end
	end

	-- Domyślnie ustaw OverheadGui
	return OverheadGui
end

-- Funkcja do zaktualizowania GUI nad głową
local function updateOverheadGui(player, overheadGui)
	local character = player.Character
	if not character then return end

	local humanoid = character:WaitForChild("Humanoid")
	local head = character:WaitForChild("HumanoidRootPart")
	local level = player.Minutes  -- Zakładając, że 'Minutes' jest atrybutem poziomu

	humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None

	local cloneGui = overheadGui:Clone()
	cloneGui.Name = "OverheadGui"
	cloneGui.Parent = head

	cloneGui.Username.Text = player.Name .. " (@" .. player.DisplayName .. ")"

	local role = "- Guest -"
	local userRolesData = game.ReplicatedStorage.DataStoreModule.loadDataStore(userRolesDataStoreKey, player.UserId)
	if userRolesData and userRolesData.role then
		role = userRolesData.role
	end
	cloneGui.Rank.Text = role

	cloneGui.Level.Text = "LEVEL : " .. level.Value

	local function updateLevelTextColor()
		local levelValue = level.Value
		if levelValue >= 100000 then
			cloneGui.Level.TextColor3 = Color3.new(1, 1, 1)  -- Tęczowy
		elseif levelValue >= 10000 then
			cloneGui.Level.TextColor3 = Color3.new(0.658824, 0, 0)  -- Ciemny czerwony
		elseif levelValue >= 5000 then
			cloneGui.Level.TextColor3 = Color3.new(1, 0.666667, 0)  -- Pomarańczowy
		elseif levelValue >= 1000 then
			cloneGui.Level.TextColor3 = Color3.new(0, 0.666667, 1)  -- Niebieski
		elseif levelValue >= 500 then
			cloneGui.Level.TextColor3 = Color3.new(0.85098, 0.00784314, 1)  -- Fioletowy
		elseif levelValue >= 100 then
			cloneGui.Level.TextColor3 = Color3.new(0.333333, 1, 0)  -- Zielony
		else
			cloneGui.Level.TextColor3 = Color3.new(1, 1, 1)  -- Domyślnie biały
		end
	end

	updateLevelTextColor()
	level.Changed:Connect(updateLevelTextColor)
end

-- Zaktualizuj GUI nad głową dla istniejących graczy
for _, Player in ipairs(Players:GetPlayers()) do
	local overheadGui = getOverheadGui(Player)
	updateOverheadGui(Player, overheadGui)
end

-- Event Listenery
Players.PlayerAdded:Connect(function(Player)
	Player.CharacterAdded:Connect(function(Character)
		local overheadGui = getOverheadGui(Player)
		updateOverheadGui(Player, overheadGui)
	end)

	Player.CharacterRemoving:Connect(function(Character)
		if Character:FindFirstChild("OverheadGui") then
			Character:FindFirstChild("OverheadGui"):Destroy()
		end
	end)
end)

-- Zaktualizuj Role Mapping i User Roles DataStore okresowo
while true do
	wait(10) -- Aktualizuj co minutę

	-- Pobierz role z serwera Discord
	local serverRoles = DiscordModule.fetchServerRoles()
	if serverRoles then
		-- Zaktualizuj role mapping DataStore
		game.ReplicatedStorage.DataStoreModule.updateDataStore(roleMappingDataStoreKey, "serverRoles", serverRoles)
		-- Pobierz członków z Discorda i zaktualizuj User Roles DataStore
		local afterUserId = nil
		local limit = 300
		while true do
			local membersData = DiscordModule.fetchDiscordMembers()
			if membersData then
				local userRoles = game.ReplicatedStorage.DataStoreModule.loadDataStore(userRolesDataStoreKey, "userRoles")
				for _, member in ipairs(membersData) do
					if member.roles then
						userRoles[member.user.id] = {
							discordId = member.user.id,
							roles = member.roles,
							username = member.user.username,
							globalName = member.user.global_name,
						}
					end
				end
				game.ReplicatedStorage.DataStoreModule.updateDataStore(userRolesDataStoreKey, "userRoles", userRoles)
				if #membersData < limit then
					break
				end
				afterUserId = membersData[#membersData].user.id
			else
				break
			end
		end
	end
end

-- Przykład aktualizacji DataStore z poprawnymi danymi
local userRoleData = { roles = {"Admin", "Moderator"} }  -- Zastąp rzeczywistymi danymi
local roleMappingData = { ["Admin"] = "Admin Role", ["Moderator"] = "Moderator Role" }  -- Zastąp rzeczywistymi danymi
local userData = { ["IdanaUJ23"] = { name = "Whitekali", score = 100 } }  -- Zastąp rzeczywistymi danymi

game.ReplicatedStorage.DataStoreModule.updateDataStore("UserRolesDataStore", "Player123", userRoleData)
game.ReplicatedStorage.DataStoreModule.updateDataStore("RoleMappingDataStore", "SomeRoleKey", roleMappingData)
game.ReplicatedStorage.DataStoreModule.updateDataStore("UserDataDataStore", "User123", userData)

-- Funkcja do wyświetlenia informacji o wszystkich użytkownikach w obecnej sesji Roblox
local function printAllUserInfo()
	for _, player in ipairs(Players:GetPlayers()) do
		local userId = player.UserId
		local userInfo = {
			Name = player.Name,
			DisplayName = player.DisplayName,
			UserId = userId
		}
		print("User Info:", userInfo)
	end
end

-- Wywołanie funkcji do wyświetlenia informacji o użytkownikach
printAllUserInfo()

-- Funkcja do wyświetlenia informacji o użytkownikach, w tym ról Discord i danych z DataStore
local function printUsersInfo()
	for _, player in ipairs(Players:GetPlayers()) do
		print("Player:", player.Name)
		print("   UserId:", player.UserId)

		local userRoleData = game.ReplicatedStorage.DiscordModule.getDiscordMemberData(player.UserId)
		if userRoleData then
			print("   Discord Roles:", table.concat(userRoleData.roles, ", "))
		end

		-- Zakładając, że chcemy również załadować dane użytkownika z DataStore
		local userData = game.ReplicatedStorage.DataStoreModule.loadDataStore("UserDataDataStore", player.UserId)
		print("   User Data:", userData)
	end
end

-- Wywołanie funkcji do wyświetlenia informacji o użytkownikach
printUsersInfo()

-- Przykład użycia getUserRoleData
local playerDiscordId = 1234567890  -- Zastąp rzeczywistym ID Discord użytkownika
local userRoleData = game.ReplicatedStorage.DiscordModule.getDiscordMemberData(playerDiscordId)

if userRoleData then
	print("User Roles:", userRoleData)
	-- Użyj userRoleData do dodatkowej logiki
else
	print("User not found in the DataStore.")
end

-- Importowanie modułu generującego mapę
local generateMap = require(game.ServerScriptService.Whitekali.MapGeneratorModule)

-- Importowanie schematu konkretnej mapy
local MapSchema = require(game.ServerScriptService.Whitekali.MapSchema)

-- Generowanie mapy na podstawie zaimportowanego schematu
local mapData = game.ReplicatedStorage.generateMap(MapSchema)

-- Wyświetlenie wyników debugowania
print("Wygenerowana mapa:")
print(mapData)

-- Import modułów dla Discorda i zarządzania graczami
local DiscordModule = require("DiscordModule")
local PlayerModule = require("PlayerModule")
local OverheadGUIModule = require("OverheadGUIModule")

-- Token bota Discorda
local discordToken = "TWÓJ_TOKEN_DISCORD"

-- Inicjalizacja bota Discorda
local discordBot = DiscordModule.init(discordToken)

-- Inicjalizacja modułu zarządzania graczami
PlayerModule.init()

-- Inicjalizacja modułu GUI
OverheadGUIModule.init()

-- Dodatkowy kod, np. obsługa innych zdarzeń
-- ...

-- Przykład: Nasłuchiwanie zdarzenia 'PlayerAdded'
game.Players.PlayerAdded:Connect(function(player)
	-- Wyświetlenie komunikatu w konsoli
	print(player.Name .. " dołączył do gry")

	-- Wykonanie dodatkowych akcji, np. nadanie początkowej roli
	PlayerModule.assignRobloxRoleFromDiscord(player.UserId, "NowyGracz")
end)

-- Przykład: Nasłuchiwanie zdarzenia 'Chatted'
game.Players.PlayerChatted:Connect(function(player, message)
	-- Wyświetlenie komunikatu w konsoli
	print(player.Name .. ": " .. message)

	-- Dodaj logikę dla wiadomości od graczy
end)

-- Dodaj więcej kodu do obsługi innych zdarzeń, np.:
-- - "CharacterAdded": Aktualizacja GUI po dodaniu postaci
-- - "PlayerRemoving": Usuwanie GUI po odejściu gracza
-- - "Player.Character.Humanoid.Died": Obsługa śmierci gracza
-- - "DataStoreService.DataStoreAdded": Dodanie DataStores
-- - "DataStoreService.DataStoreRemoved": Usunięcie DataStores
-- - "HttpService.RequestCompleted": Obsługa wyników żądań HTTP










--[[
    SPLASH SCREEN CREATION AND ENHANCEMENT GUIDE

    Basic Information:
    - Purpose: To display a graphical element (splash screen) while a Roblox game is loading.
    - Components: Utilizes Roblox's GUI elements such as ScreenGui, Frame, and ImageLabel.

    Setup Information:
    - ScreenGui is created as a container for the splash screen elements and is parented to the PlayerGui.
    - A Frame is added to the ScreenGui to serve as the splash screen's background.
    - An ImageLabel, containing the splash screen image, is placed inside the Frame.

    Function Information:
    - The splash screen is displayed for a set duration (e.g., 3 seconds) before being removed.
    - The ImageLabel's Image property should be set to the asset ID of the desired splash screen image.

    Future Function Information:
    - Animation: Implementing fade-in and fade-out animations for a smoother transition.
    - Customization: Allowing customization options such as duration, background color, and image scaling.
    - Interactivity: Adding the ability for users to skip the splash screen by clicking or pressing a key.
    - Localization: Supporting different splash screens based on the user's locale or preferences.
    - Performance Optimization: Ensuring the splash screen's assets are preloaded to minimize display delay.

    Enhancement Tips:
    - Use TweenService for animations to enhance the visual appeal of the splash screen.
    - Consider using a higher resolution image for the splash screen to support various screen sizes and resolutions.
    - Implement a loading progress bar or indicator if the game has significant loading times beyond the splash screen.
    - Test the splash screen on different devices to ensure a consistent and responsive design.

]]--








-- Create a ScreenGui to hold the splash screen
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SplashScreen"
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Create a Frame to display the splash screen image
local frame = Instance.new("Frame")
frame.Size = UDim2.new(1, 0, 1, 0)
frame.BackgroundColor3 = Color3.new(0, 0, 0)
frame.Parent = screenGui

-- Create an ImageLabel to show the splash screen image
local imageLabel = Instance.new("ImageLabel")
imageLabel.Size = UDim2.new(1, 0, 1, 0)
imageLabel.Image = "rbxassetid://1234567890" -- Replace with the asset ID of your splash screen image
imageLabel.Parent = frame

-- Wait for a few seconds before removing the splash screen
wait(3)

-- Remove the splash screen
screenGui:Destroy()


--[[            \                                          \            ]]--        
--[[            \Code based on the reference snippet above.\            ]]--
--[[            \                                          \            ]]--        

-- Create a ScreenGui to hold the splash screen
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SplashScreen"
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Create a Frame to display the splash screen image
local frame = Instance.new("Frame")
frame.Size = UDim2.new(1, 0, 1, 0)
frame.BackgroundColor3 = Color3.new(0, 0, 0)
frame.Parent = screenGui

-- Create an ImageLabel to show the splash screen image
local imageLabel = Instance.new("ImageLabel")
imageLabel.Size = UDim2.new(1, 0, 1, 0)
imageLabel.Image = "rbxassetid://1234567890" -- Replace with the asset ID of your splash screen image
imageLabel.Parent = frame

-- Wait for a few seconds before removing the splash screen
wait(3)

-- Remove the splash screen
screenGui:Destroy()
