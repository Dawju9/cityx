Lift = script.Parent.Parent.Parent.Parent
Floor = Lift:WaitForChild("Floor")
Direction = Lift:WaitForChild("Direction")
DigA = script.Parent.ARW1
Dig1 = script.Parent.DIG1
Dig2 = script.Parent.DIG2
CustomLabels = require(Lift.CustomLabel)["CUSTOMFLOORLABEL"]

function FloorLift()
	if string.len(Floor.Value) == 1 then
		if CustomLabels[tonumber(Floor.Value)] ~= nil then
			if string.len(CustomLabels[tonumber(Floor.Value)]) == 1 then
				Dig1.Value.Value = "Null"
				Dig2.Value.Value = CustomLabels[tonumber(Floor.Value)]:sub(1,1)
				return
			end
			if string.len(CustomLabels[tonumber(Floor.Value)]) == 2 then
				Dig1.Value.Value = CustomLabels[tonumber(Floor.Value)]:sub(1,1)	
				Dig2.Value.Value = CustomLabels[tonumber(Floor.Value)]:sub(2,2)	
				return
			end
			return -- Just to be sure :P
		end
			Dig1.Value.Value = "Null"
			Dig2.Value.Value = tostring(Floor.Value):sub(1,1)
		return
	end 
	if string.len(Floor.Value) == 2 then
		if CustomLabels[tonumber(Floor.Value)] ~= nil then
			if string.len(CustomLabels[tonumber(Floor.Value)]) == 1 then
				Dig1.Value.Value = "Null"
				Dig2.Value.Value = CustomLabels[tonumber(Floor.Value)]:sub(1,1)
				return
			end
			if string.len(CustomLabels[tonumber(Floor.Value)]) == 2 then
				Dig1.Value.Value = CustomLabels[tonumber(Floor.Value)]:sub(1,1)	
				Dig2.Value.Value = CustomLabels[tonumber(Floor.Value)]:sub(2,2)	
				return
			end
			return -- Just to be sure :P
		end
			Dig1.Value.Value = tostring(Floor.Value):sub(1,1)
			Dig2.Value.Value = tostring(Floor.Value):sub(2,2)	
		return
	end 
end

Direction.Changed:connect(function()
	if Direction.Value == 1 then DigA.Value.Value = "1" return end
	if Direction.Value == 0 then DigA.Value.Value = "0" return end
	if Direction.Value == -1 then DigA.Value.Value = "-1" return end
end)


Floor.Changed:connect(FloorLift)
FloorLift()