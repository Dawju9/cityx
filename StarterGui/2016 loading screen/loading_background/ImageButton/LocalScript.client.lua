local plr = game:GetService("Players").LocalPlayer

script.Parent.MouseButton1Click:Connect(function()
	plr:Kick("User has cancelled operation")
end)