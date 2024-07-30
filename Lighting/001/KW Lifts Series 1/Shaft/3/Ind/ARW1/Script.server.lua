SP = script.Parent


function SetDigit(Value)

	if Value == "1" then
		SP.U1.BrickColor = BrickColor.new("Dark green")
		SP.U2.BrickColor = BrickColor.new("Dark green")
		SP.D1.BrickColor = BrickColor.new("Really black")
		SP.D2.BrickColor = BrickColor.new("Really black")
		SP.M1.BrickColor = BrickColor.new("Dark green")
		SP.M2.BrickColor = BrickColor.new("Really black")
		return
	end
	if Value == "-1" then
		SP.U1.BrickColor = BrickColor.new("Really black")
		SP.U2.BrickColor = BrickColor.new("Really black")
		SP.D1.BrickColor = BrickColor.new("Dark green")
		SP.D2.BrickColor = BrickColor.new("Dark green")
		SP.M1.BrickColor = BrickColor.new("Really black")
		SP.M2.BrickColor = BrickColor.new("Dark green")
		return
	end
	if Value == "0" then
		SP.U1.BrickColor = BrickColor.new("Really black")
		SP.U2.BrickColor = BrickColor.new("Really black")
		SP.D1.BrickColor = BrickColor.new("Really black")
		SP.D2.BrickColor = BrickColor.new("Really black")
		SP.M1.BrickColor = BrickColor.new("Really black")
		SP.M2.BrickColor = BrickColor.new("Really black")
		return
	end
end




SP.Value.Changed:connect(function() SetDigit(SP.Value.Value) end)