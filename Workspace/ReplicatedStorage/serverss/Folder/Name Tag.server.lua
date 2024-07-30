--Thanks for using my script!
script.Parent = game.ServerScriptService
local billboard = script.BillboardGui
--Don't touch anything above this line or it will NOT work.

local playername = "NowDoTheHarlemShake" --Change this to the name of the player you want to give the title to.
local redV = 184 --If you want a different color change this. (Must understand RGB)
local greenV = 134
local blueV = 11
local text = "Legit Royalty" --Set this to the text you want in the title.
--This will apply your settings to the player. Don't change what's below.
game.Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(char)
		if player.Name == playername then
			local newgui = billboard:Clone()
			newgui.Parent = char.Head
			newgui.TextLabel.TextColor3 = Color3.fromRGB(redV, greenV, blueV)
			newgui.TextLabel.Text = text
		end
	end)
end)
