--/ Cobalt /--
local config = {
	--/ Doors /--
	["reopenLimit"] = 5, -- How many times the door will reopen
	["doorMoveTime"] = 2, -- How many seconds to move the door
	["doorSensors"] = true, -- Reopen door if it bumps a player
	["openTime"] = 7.2, -- How many seconds the door stays open
	--/ Motor /--
	["levelTolerance"] = 0.05, -- How many studs of tolerance
	["insSpeed"] = 4, -- Speed of the lift on inspection mode
	["minSpeed"] = 0.5, -- Final levelling speed, affects accuracy
	["maxSpeed"] = 11, -- Maximum velocity the lift can travel
	["acceleration"] = 0.5, -- How quickly the lift speeds up
	["braking"] = 1, -- How quickly the lift slows down
	["cframe"] = true, -- Enable to use CFrame engine
	["maxForce"] = 9999999, -- Maximum physics force
	--/ Audio /--
	
	--/ Voice /--
	["narrator"] = false, -- Enable or disable pre-configured voice
	["CustomVoice"] = false,
	["VoiceMerged"] = false,
	["VoiceID"] = "rbxassetid://0",
	["VoiceVolume"] = .1,
	
	--/ Seperate Voice /-
	["DirSoundWhenMove"] = false,
	["UpVoice"] = "rbxassetid://532751155",
	["DownVoice"] = "rbxassetid://532750437",
	
	["StandClear"] = false,
	["StDoorVoice"] = "rbxassetid://532751254",
	["StDoorDelay"] = 5.3,
	
	["DoorClosingSound"] = false,
	["ClosingSoundID"] = "rbxassetid://532751211",
	["ClosingSoundDelay"] = 4.3,
	
	["F1"] = "rbxassetid://529580208",
	["F1Delay"] = 3.3,
	["F2"] = "rbxassetid://529580685",
	["F2Delay"] = 3.2,
	["F3"] = "rbxassetid://529580778",
	["F3Delay"] = 3.4,
	["F4"] = "rbxassetid://529580887",
	["F4Delay"] = 3.3,
	["F5"] = "rbxassetid://529580943",
	["F5Delay"] = 3.2,
	["F6"] = "rbxassetid://529581042",
	["F6Delay"] = 3.2,
	["F7"] = "rbxassetid://529582790",
	["F7Delay"] = 3.5,
	["F8"] = "rbxassetid://529582855",
	["F8Delay"] = 3.3,
	["F9"] = "rbxassetid://529582983",
	["F9Delay"] = 3.4,
	["F10"] = "rbxassetid://529583558",
	["F10Delay"] = 3.3,
	["F11"] = "rbxassetid://529583811",
	["F11Delay"] = 3.8,
	["F12"] = "rbxassetid://529583900",
	["F12Delay"] = 3.7,
	["F13"] = "rbxassetid://529583979",
	["F13Delay"] = 4.2,
	["F14"] = "rbxassetid://529584046",
	["F14Delay"] = 4.1,
	["F15"] = "rbxassetid://529584115",
	["F15Delay"] = 3.9,
	["F16"] = "rbxassetid://529584151",
	["F16Delay"] = 4.1,
	["F17"] = "rbxassetid://529584308",
	["F17Delay"] = 4.2,
	["F18"] = "rbxassetid://529584385",
	["F18Delay"] = 4.0,
	["F19"] = "rbxassetid://529584456",
	["F19Delay"] = 4.0,
	["F20"] = "rbxassetid://529584664",
	["F20Delay"] = 3.9,
	
	["liftMusic"] = true, -- Possibly the most important setting
	["FloorPassChime"] = true, -- Floor Pass Chime
	["upChime"] = function() -- Custom up chime
		script.Parent.Car.Platform.ChimeU.PlaybackSpeed = 1
		script.Parent.Car.Platform.ChimeU:Play()
	end,
	["downChime"] = function() -- Custom down chime
		script.Parent.Car.Platform.ChimeD.PlaybackSpeed = 1
		script.Parent.Car.Platform.ChimeD:Play()
	end,
	--/ Other /--
	["weldPlayers"] = true, -- Weld players on car movement
	["cwOffset"] = 2, -- Offset between roof and weight
}

--/ Initialization /--
require(script.MainModule).start(script,config)