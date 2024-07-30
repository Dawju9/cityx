game.ReplicatedStorage:WaitForChild("FloweyFlash").OnClientEvent:connect(function()
	for i=1,4*30 do
		script.Parent.ScreenGui.Flash.BackgroundTransparency = 1-(i/(4*30))
		wait()
	end
	wait(2)
	for i=1,2*30 do
		script.Parent.ScreenGui.Flash.BackgroundTransparency = i/(2*30)
		wait()
	end
	script.Parent.ScreenGui.Flash.BackgroundTransparency = 1
end)
