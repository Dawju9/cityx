-- ListModule.lua
local ListModule = {}

-- Funkcja do sprawdzenia, czy użytkownik jest na liście
function ListModule.isUserInList(userName, userList)
	userName = userName:lower()
	for _, user in ipairs(userList) do
		if userName == user:lower() then
			return true
		end
	end
	return false
end

return ListModule