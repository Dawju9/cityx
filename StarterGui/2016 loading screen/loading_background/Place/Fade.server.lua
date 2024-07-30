wait(5.8)
while true do
	wait(0.06)
	script.parent.TextTransparency = script.parent.TextTransparency + 0.11
	if script.Parent.TextTransparency == 1 then
		break
	end
end