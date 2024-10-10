-- Moduł do tworzenia miejsca testowego i drukowania jego ID
    local TestPlaceManager = {}

    -- Funkcja do stworzenia testowego miejsca
    function TestPlaceManager:createTestPlace()
        -- Pobierz konfigurację z pliku TOML
        local config = {
            name = "CityX Test Place",
            max_players = 10,
            description = "This is the test place for CityX.",
            is_public = false
        }
    
        -- Tworzenie miejsca (place) w grze (mockup)
        -- Zakładam, że korzystasz z API Lua do zarządzania miejscami
        -- Tutaj będzie wywołanie tworzenia miejsca, w zależności od Twojego frameworka
        local place_id = self:createPlaceOnServer(config)  -- Symulacja funkcji tworzenia miejsca
    
        -- Wyprintowanie ID utworzonego miejsca
        print("Test place created with ID:", place_id)
    
        -- Aktualizacja pliku TOML (tu możesz dodać logikę zapisu ID do pliku TOML)
        config.place_id = place_id
    end
    
    -- Mockup funkcji tworzenia miejsca na serwerze
    function TestPlaceManager:createPlaceOnServer(config)
        -- Symulacja odpowiedzi z serwera
        local generated_place_id = math.random(1000, 9999)  -- Generuje losowe ID dla miejsca
        return generated_place_id
    end
    
    return TestPlaceManager
    