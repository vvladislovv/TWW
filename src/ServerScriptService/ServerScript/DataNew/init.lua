local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = ReplicatedStorage:FindFirstChild('Remotes')
local Webhook = "https://webhook.lewisakura.moe/api/webhooks/1261464441967612054/JtTohRe7cMbgyUZl7ZVE-ul6H0jraT8vvUimL4igl2PXGhNXBSVRq-pTrywQgztz4CYP"

local ModuleTable = require(ReplicatedStorage.Modules.ModuleTable)
local CopyTable = require(ReplicatedStorage.Libary.CopyTable)
local DataStore2 = require(ServerScriptService.DataStore2)

local DataModule = {}
DataModule.SaveTimer = 0 
DataModule.DataPlayer = {}
DataModule.AutoSaves = {}
DataModule.APIkey = {
    Main = "Data_Server_VersionTestData",
    Client = "Data_Client_VersionTestData"
}

function DataModule:New(player : Player) -- Внести все табличные структуры
    self = setmetatable({},DataModule)

    self.SettingsGame = {
        Loaded = false,
        Rank = "",
        PlayerName = player.Name,
        HP = 100,
        Premium = false,
		Banned = false,
        Tutorial = false,
        RobuxPurchases = {}
    }
    self.FakeSettings = {
        --Field Settings
        Field = nil,
        OldField = nil,
        GuiField = false,

        -- Mobs Settings
        MobsAttack = false,
        ModsField = nil,
        PlayerAttack = false,
        
        --Hive Settings
        HiveOwner = "",
    }
    
    self.IStats = {
        Honey = 0,
        Pollen = 0,
    }

    
    self.Equipment = {}
    DataModule.DataPlayer[player.Name] = self
    return self
end


function DataModule:StudioItems(Player)
    local IsStudio = {}
    if game:GetService("RunService"):IsStudio() then
        self = setmetatable(DataModule.DataPlayer[Player.Name], IsStudio)

        self.IStats = {
            Honey = 1000,
            Pollen = 1000,
        }
        return DataModule.DataPlayer[Player.Name]
    end
end


function DataModule:Get(Player) -- Сделать для студии
    if game:GetService("RunService"):IsServer() then
        DataModule:StudioItems(Player)
		return DataModule.DataPlayer[Player.Name]
    else
		return Remotes.GetDataSave:InvokeServer()
	end
end


function DataModule.CheckPlayer(Client,PData)
    coroutine.wrap(function()
        for _, GetTable in next, ModuleTable.PlayerGame.BanPlayer do
            if GetTable == Client.Name then
                Client:Kick('Banned #001')
            end
        end
    end)()

    HttpService:PostAsync(Webhook,
        HttpService:JSONEncode({
            content = `Зашел игрок {Client.Name} его ID {Client.UserId}, его DataStore {PData}` -- Сделать PData
        })
    )
end



function DataModule.DataStorage(Client, DataStorage) --! CHECK LOAD 
    local Data = DataModule:Get(Client)

    for index, value in next, DataStorage do
        Data[index][value] = DataStorage[index][value]
    end

    return Data
end

function SaveData(client, PData)
    print(DataModule.DataPlayer[client.Name])
	DataStore2(DataModule.APIkey.Client, client):Set(CopyTable:CopyWithoutFunctions(PData))
end

function DataModule:LoadData(Client)
    local _, Err = pcall(function()
        DataStore2.Combine(DataModule.APIkey.Main,DataModule.APIkey.Client)
        local PData = DataModule:New(Client)
        local DataStorage = DataStore2(DataModule.APIkey.Client, Client):GetTable(PData)
        PData = DataModule.DataStorage(Client, DataStorage)
        DataModule.CheckPlayer(Client)

        PData.SettingsGame.Loaded = true
        DataModule.AutoSaves[Client.Name] = Client
    end)

    if Err then
        warn(Err)
    end
end

do
    Players.PlayerAdded:Connect(function(player)
        DataModule:LoadData(player)
    end)

    Players.PlayerRemoving:Connect(function(player)
        SaveData(player, DataModule:Get(player))
		DataModule.AutoSaves[player.Name] = nil
    end)


    game.ReplicatedStorage.Remotes.GetDataSave.OnServerInvoke = function(client)
		local PData = DataModule:Get(client)
		return PData
	end


    coroutine.wrap(function()
        local _, Err = pcall(function()
            while true do task.wait(1)
                DataModule.SaveTimer += 1
                if DataModule.SaveTimer > 5 then
                    for _, Player in pairs(DataModule.AutoSaves) do
                        if Player ~= nil then
                            local PData = DataModule:Get(Player)
                            SaveData(Player,PData)
                        end
                    end
                    DataModule.SaveTimer = 0
                end
            end
        end)
    end)()

end

return DataModule

