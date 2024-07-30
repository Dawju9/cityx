local Discord = script
local DataStoreModule = require(game.ReplicatedStorage.DataStoreModule)

local UtilsModule = require(game.ServerScriptService.Whitekaliutil.Utils)

local DiscordModule = {}

-- Token bota Discorda
local discordToken = "TWÓJ_TOKEN_DISCORD"

-- Inicjalizacja bota Discorda
local discordBot = Discord.new(discordToken)

function DiscordModule.init()
	-- Obsługa zdarzeń Discord
	discordBot:on("ready", function()
		print("Discord bot is ready!")
		DiscordModule.syncDiscordData()
	end)

	-- Obsługa zdarzeń Discord:
	discordBot:on("guildMemberAdd", function(member)
		print("New member joined: "..member.user.username)
		-- Dodaj kod do synchronizacji danych dla nowego członka
	end)

	discordBot:on("guildMemberRemove", function(member)
		print("Member left: "..member.user.username)
		-- Dodaj kod do synchronizacji danych dla członka, który opuścił serwer
	end)

	discordBot:on("guildMemberUpdate", function(oldMember, newMember)
		print("Member updated: "..newMember.user.username)
		-- Dodaj kod do synchronizacji danych dla zaktualizowanych danych członka
	end)

	discordBot:connect() -- Connect the bot

	return discordBot
end

function DiscordModule.fetchServerRoles()
	local roles = discordBot:getGuildRoles() 
	return roles
end

function DiscordModule.fetchDiscordMembers()
	local members = discordBot:getGuildMembers()
	return members
end

function DiscordModule.syncDiscordData()
	local roles = DiscordModule.fetchServerRoles()
	local members = DiscordModule.fetchDiscordMembers()

	-- Aktualizuj DataStores
	for _, role in ipairs(roles) do
		DataStoreModule.updateRoleMapping(role.id, role.name)
	end

	for _, member in ipairs(members) do
		DataStoreModule.updateUserRoles(member.user.id, member.roles)
	end

	print("Discord data synchronized!")
end

return DiscordModule