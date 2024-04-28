local Data = {}

local Players = game:GetService("Players")
local CopyTable = require(game.ReplicatedStorage.Libary.CopyTable)

local Remotes = game.ReplicatedStorage:WaitForChild("Remotes")
--local Modules = game.ReplicatedStorage:WaitForChild("Modules")
--local Items = require(Modules.Items)

Data.PlayerData = {}

function Data.new(Player)
	local PData = {}
	PData.Loaded = false

	PData.BaseFakeSettings = {
		Attack = false,
		objAttack = nil,
		HiveOwner = "",
		HiveNumberOwner = "",
		OpenCameraCustomHive = false,
		OpenCameraCustom = false,
		OpenShop = false,
		FieldVars = "Banana",
		GuiField = false,
		FieldVarsOld = ""
	}

	PData.GameSettings = {
		SnailTutorial = false,
		LocationOne = false
	}
	
	PData.IStats = {
		Coin = 5000,
		Pollen = 0,
		Capacity = 0,
		CapacityItems = 10000000000000000000000000,
		DailyHoney = 0,
        Tutorial = false
	}

    PData.TotalItems = {
        TotalQuestAll = 0,
        CoinTotal = 0,
        PollenTotal = 0,
        WaspTotal = 0,
		TotalWhite = 0,
		TotalPupler = 0,
		TotalBlue = 0,
    }

    PData.Hive = {
        SlotsAll = 5,
        WaspSettings = {
			[1] = {
				Name = "Wasp1",
				Level = 20,
				Rarity = "★",
				Color = "Red",
				Band = 0,
			},
			[2] = {
				Name = "Wasp2",
				Level = 20,
				Rarity = "★★",
				Color = "Red",
				Band = 0,
			},
			[3] = {
				Name = "Wasp3",
				Level = 20,
				Rarity = "★★★★",
				Color = "Red",
				Band = 0,
			},
			[4] = {
				Name = "Wasp4",
				Level = 20,
				Rarity = "★★★★",
				Color = "Red",
				Band = 0,
			},
			[5] = {
				Name = "Wasp5",
				Level = 20,
				Rarity = "★★★★★★★★",
				Color = "Red",
				Band = 0,
			},
		},
        RolingWasp = 0,
    }

    PData.Boost  = {
		PlayerBoost = {
			["Pollen"] = 100,
			["Pupler Pollen"] = 100,
			["White Pollen"] = 100,
			["Blue Pollen"] = 100,
			["Critical Chance"] = 100,
			["Movement Collection"] = 0,
			["Instant"] = 0,
			["Pupler Instant"] = 0,
			["White Instant"] = 0,
			["Blue Instant"] = 0,
			["Pollen From Collectors"] = 100,
			["Collectors Speed"] = 100,
			["Critical Power"] = 100,
			["Honey From Tokens"] = 100,
		}
    }

	PData.QuestTaskNPC = {}
	
    PData.QuestNPC = {
        ['Vladislov'] = {
		NowQuest = false, --* Новый квест
		Complish = false, --* Настоящий квест
		QuestEvent = false, --* Праздничный квест
		TotalQuest = 1 --* Всего
		},
        ['Bread'] = {NowQuest = false, Complish = false, QuestEvent = false, TotalQuest = 1, NoQuset = false},
		['Snail'] = {NowQuest = false,Complish = false, QuestEvent = false, TotalQuest = 1, NoQuset = false},
    }

	PData.Inventory = {
		['Waspik Egg'] = 1,
		['Strabbery'] = 15,
		['Send'] = 15,
		['Rock'] = 15,
		['Flower'] = 15,
		['Gold Egg'] = 1,
		['Serk'] = 1
	}

	PData.Equipment = {
        Tool = "Hammer",
        Bag = "Big Backpack",
		Boot = "Vio Boot",
        Belt = "",
        Hat = "Vio hat",
		Glove = "",
        RGuard = "",
		LGuard = "",
		Parachute = ""
	}

	PData.EquipmentShop = {
		Tools = {['Hammer'] = true},
        Bags ={['Big Backpack'] = true},
		Boots = {['Vio Boot'] = true},
        Belts = {},
        Hats = {['Vio hat'] = true},
		Gloves = {},
        RGuards = {},
		LGuards = {},
		Parachutes = {},
	}

	PData.TimerTable = {
		["BottalCoin"] = {
			Time = 0
		},
		["WatherEvent"] = {
			Time = 0
		},
		["clownEvent"] = {
			Time = 0
		}
	}
	PData.Bagers = {
		['Pollen'] = {
            Rank = 1,
            Amount = 0
        },

        ['Coin'] = {
            Rank = 1,
            Amount = 0
        }
	}

    PData.Settings = { 
        ['Sound'] = true,
        ['Pollen Text'] = true
    }
	
	function PData:Update(key, value)
		PData[key] = value
		Remotes.DataUpdate:FireClient(Player,key,value)
	end
	
	Data.PlayerData[Player.Name] = PData
	return PData
end

function Data:Get(Player)
	if game:GetService("RunService"):IsServer() then
		return Data.PlayerData[Player.Name]
	else
		return Remotes.GetDataSave:InvokeServer()
	end
end

local AutoSaves = {}

local MainKey = 'Data_Server_Test1'
local ClientKey = 'Data_Client_Test1'

local DataStore2 = require(game.ServerScriptService.DataStore2)

function LoadData(Client)
	DataStore2.Combine(MainKey, ClientKey)
	local PData = Data.new(Client)
	local DataStorage = DataStore2(ClientKey, Client):GetTable(PData)
	PData = GetDataFromDataStorage(Client, DataStorage)
	PData.Loaded = true
	print(PData)
	AutoSaves[Client.Name] = Client
end

function SaveData(client, PData)
	DataStore2(ClientKey, client):Set(CopyTable:CopyWithoutFunctions(PData))
	print(PData)
end 

function GetDataFromDataStorage(Client, DataStorage)
	local PData = Data:Get(Client)

	for i,v in pairs(DataStorage.IStats) do
		PData.IStats[i] = DataStorage.IStats[i]
	end
	for i,v in pairs(DataStorage.Hive) do
		PData.Hive[i] = DataStorage.Hive[i]
	end

	for i,v in pairs(DataStorage.TotalItems) do
		PData.TotalItems[i] = DataStorage.TotalItems[i]
	end

	for i,v in pairs(DataStorage.TimerTable) do
		PData.TimerTable[i] = DataStorage.TimerTable[i]
	end

	for i,v in pairs(DataStorage.GameSettings) do
		PData.GameSettings[i] = DataStorage.GameSettings[i]
	end

	for i,v in pairs(DataStorage.EquipmentShop) do
		PData.EquipmentShop[i] = DataStorage.EquipmentShop[i]
	end

	for i,v in pairs(DataStorage.Boost) do
		PData.Boost[i] = DataStorage.Boost[i]
	end

	for i,v in pairs(DataStorage.Settings) do
		PData.Settings[i] = DataStorage.Settings[i]
	end

	for i,v in pairs(DataStorage.Inventory) do
		PData.Inventory[i] = DataStorage.Inventory[i]
	end

	for i,v in pairs(DataStorage.Equipment) do
		PData.Equipment[i] = DataStorage.Equipment[i]
	end

    for i,v in pairs(DataStorage.QuestNPC) do
		PData.QuestNPC[i] = DataStorage.QuestNPC[i]
	end

    for i,v in pairs(DataStorage.Bagers) do
		PData.Bagers[i] = DataStorage.Bagers[i]
	end
	return PData
end
do
	Players.PlayerAdded:Connect(LoadData)
	Players.PlayerRemoving:Connect(function(Client)
		SaveData(Client, Data:Get(Client))
		AutoSaves[Client.Name] = nil
	end)
	--Players.PlayerRemoving:Connect(function(Client) SaveData(Client, Data:Get(Client)) AutoSaves[Client.Name] = nil end)

	game.ReplicatedStorage.Remotes.GetDataSave.OnServerInvoke = function(client)
		local PData = Data:Get(client)
		return PData
	end
end

local TotalDelta = 0
task.spawn(function()
	while task.wait(1) do
		TotalDelta += 1
		if TotalDelta > 3 then
			TotalDelta = 0
			for _, Player in pairs(AutoSaves) do
				local PData = Data:Get(Player)
				SaveData(Player, PData)
			end
		end
	end
end)

return Data
