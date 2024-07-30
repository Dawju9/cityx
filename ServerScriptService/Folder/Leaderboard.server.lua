local DataService = game:GetService("DataStoreService")
local PointsService = game:GetService("PointsService")
--local DataF = DataService:GetDataStore("Floors")
local DataS = DataService:GetDataStore("PlayerStats2")

function Save(key, value, store)
	store:SetAsync(key, value)
end

function Load(key, store, player)
	if player.Name ~= "Player" then
		return store:GetAsync(key)
	else
		return {0,0}
	end
end

function Player(p)
	local key = "UserStat-" .. p.UserId
	wait(2.5)
	--local old = Load(key, DataF, p)
	local Loaded = Load(key, DataS, p)
	--[[local success = pcall(function() if old then
		Save(key, {old, old}, DataS)
		Loaded = {old, old}
		Save(key, nil, DataF)
	end end)
	if not success then
		Save(key, {0,0}, DataS)
		Loaded = {0,0}
		Save(key, nil, DataF)
	end]]
	if not Loaded then
		Loaded = {0,0}
	end
	
	local lead = Instance.new("IntValue", p)
	lead.Name = "leaderstats"
	local stat = Instance.new("IntValue")
	stat.Name = "Floors"
	stat.Parent = lead
	stat.Value = Loaded[1]
	local tokens = Instance.new("IntValue")
	tokens.Name = "Tokens"
	tokens.Parent = p
	tokens.Value = Loaded[2]
	local potato = Instance.new("IntValue")
	potato.Name = "PotatoCheck"
	potato.Parent = p
	wait(1)
	if p.userId > 0 then
		while p and p.Parent == game.Players do
			wait(60)
			Save(key, {stat.Value, tokens.Value}, DataS)
			local points = PointsService:GetGamePointBalance(p.userId)
			local val = stat.Value
			local sol = val - points
			if val and points and sol ~= 0 then
				PointsService:AwardPoints(p.userId, sol)
			end
		end
	end
end

game.Players.PlayerRemoving:connect(function(p)
	local key = "UserStat-" .. p.UserId
	Save(key, {p.leaderstats.Floors.Value, p.Tokens.Value}, DataS)
end)

game.Players.PlayerAdded:connect(Player)
