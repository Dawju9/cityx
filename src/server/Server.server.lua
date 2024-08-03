

    --[[ 
            #####| Cityx by "White"  |#####
            ##|
            ##|  Game Design Document   
            ##|  :List active module's: 
            ##|   -Main Module ['ModuleLoader'] [Nie wprowadzono]
            ##|   -Game Module [Nie wprowadzono]
            ##|   -Module Loader [Nie wprowadzono]
            ##|   -Tile Module ['TileModule'] [Nie wprowadzono]
            ##|   -Tile Menaager ['TileManager'] [Nie wprowadzono]
            ##|   -Tile Loader [Nie wprowadzono]
            ##|   -
            ##|  :END  of  'List': 
            ##|   -
            ##|  :List deactive module's:
            ##|   -Main Module [Nie wprowadzono]
            ##|   -Game Module [Nie wprowadzono]
            ##|   -Module Loader [Nie wprowadzono]
            ##|   :END  of  'List':
            ##|  :Game functions:
            ##|   - initGame() [Nie wprowadzono]
            ##|   - startGame() [Nie wprowadzono]
            ##|   - updateGame() [Nie wprowadzono]
            ##|   - stopGame() [Nie wprowadzono] 
            ##|   - pauseGame() [Nie wprowadzono]
            ##|   - resumeGame() [Nie wprowadzono]
            ##|   - saveGame() [Nie wprowadzono]
            ##|   - loadGame() [Nie wprowadzono]
            ##|   - exitGame() [Nie wprowadzono]
            ##|   - restartGame() [Nie wprowadzono]
            ##|   - endGame() [Nie wprowadzono]
            ##|   - winGame() [Nie wprowadzono]
            ##|   - loseGame() [Nie wprowadzono]
            ##|   - restartGame() [Nie wprowadzono]
        
            ##|   - 

            #####| Cityx by "White"  |#####
        Main logic
        Game logic
        Ether logic  
          ]]-- 
local dewelopment = true
local _przejebane = true
    local function debugPrint(string)
        local debug = true
                if debug == true then
                    print(string)
                end
            end 
    -- Game logic
    
  -- Moduł ładowania modułów
  local ModuleLoader = script:FindFirstChildOfClass("ModuleScript")
  if ModuleLoader then
      ModuleLoader = require(ModuleLoader)
  end

  local ServerScriptService = game:GetService("ServerScriptService")

if dewelopment == true then
        debugPrint("Hello gamelogic Cityx, the server)!") 
    end
-- Inicjalizacja gry
-- Główna pętla gry
-- Funkcje gracza
-- Funkcje środowiska
-- Funkcje czasu
-- Funkcje anomalii i zdarzeń
-- Zapytania dla graczy
-- Poruszanie się po świecie gry
-- Logika SI Miastox/Cityx
-- Funkcje gry
-- Funkcje menu
-- Funkcje menu głównego
-- Funkcje menu gry
-- Funkcje menu opcji
-- Funkcje menu pomocy
-- Funkcje menu zakończenia gry
-- Funkcje menu reportu
local function gameLoop()
    while true do
        if dewelopment == true then
            debugPrint("Hello Aktualizacja gry server)!")
            wait(2)
            debugPrint("Hello zaladuj gre server)!")
            wait(2)
            debugPrint("Hello zaladuj gracza srodowisko czas server)!")
        elseif dewelopment == false then
            
            while true do   
                local update = 0

                debugPrint("! "+update)
        
                -- Aktualizacja gry
                -- Obsługa graczy
                -- Obsługa środowiska
                -- Obsługa czasu
            end
            while _przejebane == true do
                
             debugPrint("!")
        
                -- Wywoływanie anomalii i zdarzeń
                -- Modruj graczy
                -- Załamanie w świecie gry
                -- Logika SI zabójców i rabusiów Miastox/Cityx
            end
            -- Aktualizacja gry
            -- Obsługa graczy
            -- Obsługa środowiska
            -- Obsługa czasu
            -- Wywoływanie anomalii i zdarzeń
            -- Zapytania dla graczy
            -- Poruszanie się po świecie gry
            -- Logika SI Miastox/Cityx
                wait(1/30) -- Aktualizacja 30 razy na sekundę
        end
        wait(1/30) -- Aktualizacja 30 razy na sekundę
    end
-- Inicjalizacja gry
gameLoop()
end

-- Inicjalizacja gry
local function initGame()
  -- Ładowanie modułów
  ModuleLoader.loadModules()
  -- Inicjalizacja graczy
  -- Inicjalizacja środowiska
  -- Inicjalizacja SI Miastox/Cityx
end

-- Start gry
initGame()