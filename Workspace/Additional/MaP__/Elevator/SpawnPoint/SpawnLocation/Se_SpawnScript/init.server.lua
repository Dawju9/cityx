local spawnLocation = script.Parent:FindFirstChild("SpawnLocation")
local groupValue = script.Parent:FindFirstChild("GroupSpawnRangeTeam")
SpawnModule = require(script:FindFirstChild("SpawnModuleScript"))

if spawnLocation and groupValue then
	SpawnModule.setupSpawn(spawnLocation, groupValue.Value, script)
end

spawnLocation.Touched:Connect(function(hit)
	local player = game.Players:GetPlayerFromCharacter(hit.Parent)
	if player and SpawnModule.checkPermissions(player) then
		-- Handle player spawn logic
		-- Example: Teleport player or set spawn point
	else
		-- Handle case where player lacks permission
		player:Kick("You do not have permission to spawn here.")
	end
end)


--[[ustalmy że element o którym, wspoimna skrypt jest zbudowany tak., -[Part]-SpawnPoint *soon model* -| - SpawnLocation -[SpawnLocation]- 


	i w następujący sposób są elementy tych wyżej wymienionych stosów 
-[Part]- posiada w sobie -[SpawnLocation]-, -[StringValue]- "GroupSpawnRangTeam" 
-[SpawnLocation]-     a następnie posiada w swojej budowie -[Script]- "Se_SpawnScript"  *TEN SKRYPT *, -[TouchInterest]-
	-[Script]- posiada w sobie  -[ModulScript]- o nazwie  "SpawnModuleScript" w skrypcie jest moduł jak budować i funkcjonować ma podany spawn location moduł! 
GroupSpawnRangTeam ma odpowiadacza wybrany zespół grupe i obslujgiwać te wartosćdla spwan location wraz z dodaniem poziomu autoryzacji do panelu spawna!]]--