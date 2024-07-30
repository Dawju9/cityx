local players = game:GetService("Players")

if game.CreatorType == Enum.CreatorType.User then --Check if they are a user
	script.Parent.Text = "By: " .. players:GetNameFromUserIdAsync(game.CreatorId)
elseif game.CreatorType == Enum.CreatorType.Group then
	script.Parent.Text = "By: " .. game:GetService("GroupService"):GetGroupInfoAsync(game.CreatorId).Owner
end
-- 