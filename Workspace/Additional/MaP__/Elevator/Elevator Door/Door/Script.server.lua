--nowy skrypt kalimodel
-- W skrypcie0 drzwi
local elevator = game.Workspace:FindFirstChild("Elevator")
local doors = script.Parent

function onElevatorArrive()
	doors:Open() -- Funkcja otwierająca drzwi
	wait(3) -- Czas otwarcia
	doors:Close() -- Funkcja zamykająca drzwi
end

elevator.ElevatorArrived.Event:Connect(onElevatorArrive)



--[[

door = script.Parent 

while true do

door.Transparency = 0
door.CanCollide = true 
wait(28) -- You can edit the time, BUT FIRST you need to edit the Elevator Script time!
door.Transparency = 1
door.CanCollide = false
wait(50)
end 
]]--