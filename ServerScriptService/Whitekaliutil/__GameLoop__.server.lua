-- This script was scripte'ed by --[White]-- it will [...] by script.
-- 
-- This response script has function:
--  1.
--  2.
-- ::::::::.__::::.__::__::::::::::
-- __::_::_|::|__:|__|/::|_::____::
-- \:\/:\/:/::|::\|::\:::__\/:__:\:
-- :\:::::/|:::Y::\::||::|:\::___/:
-- ::\/\_/:|___|::/__||__|::\___::>
-- :::::__::::::\/::.__::.__::::\/:
-- ::::|::|:______::|::|:|__|::::::
-- ::::|::|/:|__::\:|::|:|::|::::::
-- ::::|::::<:/:__:\|::|_|::|::::::
-- ::::|__|_:(____::/____/__|::::::
-- :::::::::\/::::\/:::::::::::::::
--[White's version] Shared variables and setup

-- GameLoop.lua

local working = true
local maxClones = 10
local cloneCount = 0

-- Tworzenie ValueBase "status"
local status = Instance.new("BoolValue", script)



--[[

## Analiza kodu:

Ten kod tworzy nową instancję obiektu `ValueBase` w Robloxie, nazywając ją "status" i nadając jej rodzica jako skryptu (``script``).

* **`Instance.new("ValueBase", script)`:** Tworzy nową instancję obiektu `ValueBase` z rodzicem jako skryptem.
* **`local status = ...`:** Deklaruje zmienną lokalną `status` i przypisuje do niej nowo utworzoną instancję.
sd
## Propozycje alternatywnych form wyjściowych:

**1. Użycie innych typów danych ValueBase:**

Zamiast `ValueBase`, można użyć innych typów danych, np. `BoolValue`, `StringValue`, `NumberValue` itp., które mogą przechowywać odpowiednie typy danych. Przykładowo:

```lua
local status = Instance.new("BoolValue", script) -- Przechowuje wartość logiczną (true/false)
local playerName = Instance.new("StringValue", script) -- Przechowuje tekst
local score = Instance.new("NumberValue", script) -- Przechowuje liczbę
```

**2. Użycie funkcji `Create`:**

Zamiast tworzenia instancji za pomocą `Instance.new`, można użyć funkcji `Create`:

```lua
local status = game.Create("ValueBase", script)
```

**3. Zdefiniowanie wartości początkowej:**

Można ustawić wartość początkową dla instancji `ValueBase` zaraz po jej utworzeniu:

```lua
local status = Instance.new("ValueBase", script)
status.Value = true -- Ustawia wartość na true
```

**4. Użycie zmiennych globalnych:**

Zamiast zmiennych lokalnych, można użyć zmiennych globalnych, jeśli to konieczne:

```lua
status = Instance.new("ValueBase", script)
```

**5. Użycie tablic:**

Można stworzyć tablicę, która będzie przechowywać różne instancje `ValueBase`:

```lua
local status = {}
status.player = Instance.new("BoolValue", script)
status.score = Instance.new("NumberValue", script)
```

Wybór najlepszej formy zależy od konkretnego przypadku użycia. Należy wziąć pod uwagę typ danych, zakres zmiennej, potrzeby logiki programu i łatwość odczytu kodu. 


]]--
status.Name = "status"
status.Parent = script
status.Value = "stopped"

-- Importowanie modułów
local PlatformCreation = require(game.ServerScriptService.Whitekaliutil.PlatformCreation)
local CentralPart = require(game.ServerScriptService.Whitekaliutil.CentralPart)
local MapGeneration = require(game.ServerScriptService.Whitekaliutil.MapGeneration)
local Player = require(game.ServerScriptService.Whitekaliutil.Player)
local Data = require(game.ServerScriptService.Whitekaliutil.Data)
local Admin = require(game.ServerScriptService.Whitekaliutil.Admin)
local Security = require(game.ServerScriptService.Whitekaliutil.Security)
local Utils = require(game.ServerScriptService.Whitekaliutil.Utils)

-- Ładowanie danych mapy
local mapData = Data.loadMapData()

-- Główna pętla
while working do
	PlatformCreation.generatePlatforms(mapData)

	-- Klonowanie CentralPart
	cloneCount = cloneCount + 1
	if cloneCount <= maxClones then
		CentralPart.generateClones()
	else
		working = false
		print("Reached maximum clone limit.")
	end

	wait(1)  -- Dostosuj czas oczekiwania
end

status.Value = "stopped"  -- Ustawienie statusu

local level = MapGeneration.generateMapLevel()
MapGeneration.generateMapFromSchemas(level)