--[[ 
INSTRUCTIONS: Place both teleporter1a and teleporter1b in the same directory 
(e.g. both in workspace directly, or both directly in the same group or model) 
Otherwise it wont work. Once youve done that, jump on the teleporter to teleport to the other. 
If you want more than one set of teleporters I will be adding more types in the future. 

Send me requests and ideas - Demotico. 
--]] 


--Enter the name of the model you want to go to here. 
------------------------------------ 
modelname="teleportb" 
------------------------------------ 

local humanoid = Enum.HumanoidRigType
function onTouched(part) 
if part.Parent ~= nil then 
local h = part.Parent:findFirstChild("Humanoid") 
if h~=nil then 
local teleportfrom=script.Parent.Enabled.Value 
if teleportfrom~=0 then 
if h==humanoid then 
return 
end 
local teleportto=script.Parent.Parent:findFirstChild(modelname) 
if teleportto~=nil then 
local head = h.Parent.Head 
local location = {teleportto.Position} 
local i = 1 

local x = location[i].x 
local y = location[i].y 
local z = location[i].z 

x = x + math.random(-1, 1) 
z = z + math.random(-1, 1) 
y = y + math.random(2, 3) 

local cf = head.CFrame 
local lx = 0 
local ly = y 
local lz = 0 

script.Parent.Enabled.Value=0 
teleportto.Enabled.Value=0 
head.CFrame = CFrame.new(Vector3.new(x,y,z), Vector3.new(lx,ly,lz)) 
wait(3) 
script.Parent.Enabled.Value=1 
teleportto.Enabled.Value=1 
else 
print("Could not find teleporter!") 
end 
end 
end 
end 
end 

script.Parent.Touched:connect(onTouched)
