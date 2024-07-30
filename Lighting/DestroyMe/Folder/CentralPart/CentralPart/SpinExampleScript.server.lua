while true do
	script.Parent.BigCube.CFrame = script.Parent.BigCube.CFrame * CFrame.Angles(0.01, 0, -0.01)
	script.Parent.SmallCube.CFrame = script.Parent.SmallCube.CFrame * CFrame.Angles(-0.005, 0, 0.01)
	wait(0.01)
end