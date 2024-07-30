--print("Hello world!")
--script = script.Workspace:FindFirstChild("DestroyMe")
--b-- Drukowanie "Hello World!"
print("Hello World!")

-- Znajdowanie i niszczenie folderu o nazwie "DestroyMe" w Workspace
local scriptFolder = game.Workspace:FindFirstChild("DestroyMe")
if scriptFolder then
	scriptFolder:Destroy()
else
	print("Folder 'DestroyMe' nie został znaleziony.")
end
