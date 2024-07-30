wait(5.8)
while true do
	wait(0.06)
	script.parent.ImageTransparency = script.parent.ImageTransparency + 0.11
	if script.Parent.ImageTransparency == 1 then
		break
	end
end