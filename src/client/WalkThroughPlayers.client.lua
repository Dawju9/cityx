local _player = game.Players.LocalPlayergame:GetService("RunService").Stepped:connect(function()
	for _, player in pairs(game.Players:GetPlayers()) do
		if player ~= game.Players.LocalPlayer then
			local c = player.Character
			if c then
				for _,v in pairs (c:GetChildren()) do
					if v:IsA("BasePart") then
						v.CanCollide = false
					end
				end
			end
		end
	end
end)