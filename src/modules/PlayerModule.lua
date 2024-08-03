--[[
    Moduł PlayerModule
    
    Zarządza wszystkimi aspektami gracza, takimi jak ruch, animacje, stan gry itp.
--]]

local PlayerModule = {}

-- Stałe
local PLAYER_SPEED = 16
local JUMP_POWER = 50

-- Zewnętrzne moduły
local Logger = require(script.Parent.Parent.Logger)
-- Konstruktor
function PlayerModule.new(model)
    local self = setmetatable({}, {__index = PlayerModule})
    
    -- Odwołania do obiektów
    self.model = model
    self.humanoid = self:getHumanoid()
    
    -- Stan gracza
    self.state = "idle"
    
    -- Inicjalizacja
    self:initialize()
    
    return self
end

-- Inicjalizacja gracza
function PlayerModule:initialize()
    self:setupEventListeners()
    self:setDefaults()
end

-- Ustawienie domyślnych wartości
function PlayerModule:setDefaults()
    self.humanoid.WalkSpeed = PLAYER_SPEED
    self.humanoid.JumpPower = JUMP_POWER
end

-- Dodanie listenerów zdarzeń
function PlayerModule:setupEventListeners()
    self.humanoid.Died:Connect(function()
        self:handleDeath()
    end)
end

-- Obsługa śmierci gracza
function PlayerModule:handleDeath()
    self.state = "dead"
    Logger:log("Player died", "warning")
    -- Dodatkowa logika, np. wyświetlenie ekranu śmierci
end

-- Poruszanie graczem
function PlayerModule:move(direction)
    if self.state ~= "dead" then
        -- Implementacja logiki poruszania
    end
end

-- Skok gracza
function PlayerModule:jump()
    if self.state ~= "dead" then
        -- Implementacja logiki skoku
    end
end

-- Prywatna funkcja pobierająca Humanoid
function PlayerModule:getHumanoid()
    local humanoid = self.model:FindFirstChildOfClass("Humanoid")
    
    if not humanoid then
        Logger:log("Humanoid not found in player model", "error")
        error("Humanoid not found in player model")
    end
    
    return humanoid
end

-- Obsługa błędów
function PlayerModule:handleError(errorMessage, errorType)
    Logger:log(errorMessage, errorType)
    -- Zaawansowana obsługa błędów: logowanie, odzyskiwanie, powiadomienia
end

-- Zwolnienie zasobów
function PlayerModule:destroy()
    -- Zwolnienie listenerów, obiektów itp.
end

return PlayerModule




--[[
local PlayerModule = {}

-- Stałe
local PLAYER_SPEED = 16
local JUMP_POWER = 50

-- Konstruktor
function PlayerModule.new(model)
    local self = setmetatable({}, {__index = PlayerModule})
    self.model = model
    self.humanoid = self:getHumanoid()
    self.state = "idle"
    self:initialize()
    return self
end

-- Inicjalizacja gracza
function PlayerModule:initialize()
    self:setupEventListeners()
    self:setDefaults()
end

-- Ustawienie domyślnych wartości
function PlayerModule:setDefaults()
    self.humanoid.WalkSpeed = PLAYER_SPEED
    self.humanoid.JumpPower = JUMP_POWER
end

-- Dodanie listenerów zdarzeń
function PlayerModule:setupEventListeners()
    -- Przykład:
    self.humanoid.Died:Connect(function()
        self:handleDeath()
    end)
end

-- Obsługa śmierci gracza
function PlayerModule:handleDeath()
    self.state = "dead"
    -- Dodatkowa logika, np. wyświetlenie ekranu śmierci
end

-- Poruszanie graczem
function PlayerModule:move(direction)
    if self.state ~= "dead" then
        -- Implementacja logiki poruszania
    end
end

-- Skok gracza
function PlayerModule:jump()
    if self.state ~= "dead" then
        -- Implementacja logiki skoku
    end
end

-- Obsługa błędów
function PlayerModule:handleError(errorMsg)
    warn("Player Error: " .. errorMsg)
    -- Zaawansowana obsługa błędów: logowanie, odzyskiwanie, powiadomienia
end

-- Zwolnienie zasobów
function PlayerModule:destroy()
    -- Zwolnienie listenerów, obiektów itp.
end

return PlayerModule

]]--

