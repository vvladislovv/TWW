
local AllScript = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Remotes = ReplicatedStorage:WaitForChild('Remotes')

local Data = require(ServerScriptService.ServerScript.Data)
local ZonePlus = require(game.ReplicatedStorage:FindFirstChild('Zone'))
local EquipmentModule = require(ServerScriptService.ServerScript.Equipment)

local TableSettingsGame = {
    BanPlayer = {
        [1] = 'dima0tu3',
        [2] = 'iQlemjo',
        [3] = 'CblH_Cengdopa',
        [4] = 'BroNlockLove',
        [5] = 'dima0tu17',
        [6] = 'KtotoVBSS',
        [7] = 'StepanVIP123',
        --[8] = 'vlad060108',
    },
    Testers = {
        [1] = "BreadDev",
    },
    Admins = {
        [1] = "vlad060108",
        [2] = "BreadDev"
    },
}

function Barier() -- ! Barier location 
    for _, index in next, workspace.Map.GameSettings.Barier:GetChildren() do
        local Zone = ZonePlus.new(index)

        Zone.playerEntered:Connect(function(player)
            local PData = Data:Get(player)
            local Character = game.Workspace:FindFirstChild(player.Name)

            if PData.Hive.SlotsAll < tonumber(index.Name) then
                if PData.BaseFakeSettings.HiveOwner ~= "" then
                    Character:SetPrimaryPartCFrame(workspace.Map.GameSettings.Hives[PData.BaseFakeSettings.HiveNumberOwner].HivePlatform.Up.Attachment.WorldCFrame)
                else
                    Character:SetPrimaryPartCFrame(workspace.SpawnLocation.Attachment.WorldCFrame)
                end
            end
        end)
    end
end

function AdminSystems(Player)

    for _, GetTable in next, TableSettingsGame.Admins do
        if GetTable == Player.Name then
            local PData = Data:Get(Player)
            print(PData)
            PData.IStats = {
                Coin = 99999999999,
                Pollen = 0,
                Capacity = 99999999999,
                DailyHoney = 99999999999,
                Tutorial = false
            }
            Remotes.StartPlayerCoinPollen:FireClient(Player)
            PData.Equipment = {
                Tool = "Hammer",
                Bag = "Big Backpack",
                Boot = "Vio Boot",
                Belt = "",
                Hat = "Vio hat",
                Glove = "",
                RGuard = "",
                LGuard = "",
                Parachute = "",
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
        end
    end    
end

function BanSystems(Player)
    task.wait()
    AdminSystems(Player)

    for _, GetTable in next, TableSettingsGame.BanPlayer do
        if GetTable == Player.Name then
            local PData = Data:Get(Player)
            if not PData.Loaded then
                repeat task.wait() PData = Data:Get(Player) until PData.Loaded
            end
            
            PData.IStats = {
                Coin = 0,
                Pollen = 0,
                Capacity = 300,
                DailyHoney = 0,
                Tutorial = false
            }

            Remotes.StartPlayerCoinPollen:FireClient(Player)
            
            PData.IStats.Capacity = 0
            PData.Equipment = {
                Tool = "Shovel",
                Bag = "Backpack",
                Boot = "",
                Belt = "",
                Hat = "",
                Glove = "",
                RGuard = "",
                LGuard = "",
                Parachute = "",
            }

            PData.Inventory = {
                ['Waspik Egg'] = 1,
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
                SlotsAll = 1,
                WaspSettings = {
                    [1] = {
                        Name = "Wasp1",
                        Level = 1,
                        Rarity = "★",
                        Color = "Red",
                        Band = 0,
                    },
                },
            }

            PData.EquipmentShop = {
                Tools = {['Shovel'] = true},
                Bags ={['Backpack'] = true},
                Boots = {},
                Belts = {},
                Hats = {},
                Gloves = {},
                RGuards = {},
                LGuards = {},
                Parachutes = {},
            }

            PData.TimerTable = { -- таймеры сделать
                ['Banana'] ={
                    Timer1 = {
                        Time = 100000000000
                    },
                    Timer2 = {
                        Time = 100000000000
                    },
                    Timer3 = {
                        Time = 100000000000
                    },
                    Timer4 = {
                        Time = 100000000000
                    },
                    Timer5 = {
                        Time = 100000000000
                    },
                }
            }
            --Player:Kick()
        end
    end
end

function DeleteItems(HRP, ItemType, ItemName, PData)
    local Player = game.Players:FindFirstChild(HRP.Name)
    if HRP:FindFirstChild(ItemType) then
        HRP:FindFirstChild(ItemType):Destroy()
    end
end

function EquipmentServer(Player,TextButton,TableSettings,CameraType2, CameraNow1,ModuleTable)
    local PData = Data:Get(Player)
    local PlayerGui = Player:WaitForChild('PlayerGui')
    local UIs = PlayerGui:WaitForChild('UIs')
    local ShopFrame = UIs:WaitForChild('ShopFrame')

    DeleteItems(Player.Character, CameraType2.Type.Value, TableSettings.Name, PData)
        if CameraNow1 == CameraType2.Order.Value and TextButton == "Equip" then
            PData.Equipment[CameraType2.Type.Value] = CameraType2.ItemsName.Value
            PData.EquipmentShop[CameraType2.Type.Value.."s"][TableSettings.Name] = true
            Remotes.UIShop:FireClient(Player)
            for i, value in PData.EquipmentShop[CameraType2.Type.Value.."s"] do
                if i == CameraType2.ItemsName.Value then
                    PData.EquipmentShop[CameraType2.Type.Value.."s"][i] = true
                    PData:Update('EquipmentShop', PData.EquipmentShop)
                else
                    --print(i)
                    PData.EquipmentShop[CameraType2.Type.Value.."s"][i] = false
                    PData:Update('EquipmentShop', PData.EquipmentShop)
                end
            end
            EquipmentModule:EquipItemsGame(Player.Character, CameraType2.Type.Value, PData,Player)
            CameraType2 = nil
        end
end

function ShopBuyServer(Player,TextButton,TableSettings,CameraType, CameraNow) -- надо посмотреть и попробовать дать персонажу рюкзак и тп и сделать чтобы все вещи одевались
    local PData = Data:Get(Player)
    local PlayerGui = Player:WaitForChild('PlayerGui')
    local UIs = PlayerGui:WaitForChild('UIs')
    local ShopFrame = UIs:WaitForChild('ShopFrame')

    if TextButton == "Purchase" then
        DeleteItems(Player.Character, CameraType.Type.Value, TableSettings.Name, PData)
        PData.IStats.Coin -= TableSettings.Cost
        PData:Update('IStats', PData.IStats)
        ShopFrame.BuyButton.Frame.Frame.TextButton.Text = "Equipped"
        if CameraNow == CameraType.Order.Value then
            PData.Equipment[CameraType.Type.Value] = TableSettings.Name
            PData.EquipmentShop[CameraType.Type.Value.."s"][TableSettings.Name] = true
            for i, value in PData.EquipmentShop[CameraType.Type.Value.."s"] do
                if i == TableSettings.Name then
                    PData.EquipmentShop[CameraType.Type.Value.."s"][i] = true
                    PData:Update('EquipmentShop', PData.EquipmentShop)
                else
                    PData.EquipmentShop[CameraType.Type.Value.."s"][i] = false
                    PData:Update('EquipmentShop', PData.EquipmentShop)
                end
            end
            EquipmentModule:EquipItemsGame(Player.Character, CameraType.Type.Value, PData,Player)
            CameraType = nil
        end
        --print(PData.Equipment[CameraType.Type.Value])
        

        PData:Update('EquipmentShop', PData.EquipmentShop)
        PData:Update('Equipment', PData.Equipment)
    end
end

function ConvertServer(plr)
    local PData = Data:Get(plr)
    PData.IStats.Coin += PData.IStats.Pollen
    PData.IStats.Pollen = 0
    PData:Update('IStats', PData.IStats)
end

Remotes.BuyShop.OnServerEvent:Connect(ShopBuyServer)
Remotes.BuyShop2.OnServerEvent:Connect(EquipmentServer)
Remotes.HiveConvert.OnServerEvent:Connect(ConvertServer)
game.Players.PlayerAdded:Connect(BanSystems)
task.spawn(Barier)

return AllScript