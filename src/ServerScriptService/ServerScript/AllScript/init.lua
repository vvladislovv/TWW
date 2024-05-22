
local AllScript = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Remotes = ReplicatedStorage:WaitForChild('Remotes')

local Data = require(ServerScriptService.ServerScript.Data)
local ZonePlus = require(game.ReplicatedStorage:FindFirstChild('Zone'))
local EquipmentModule = require(ServerScriptService.ServerScript.Equipment)



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
            Remotes.UIShop:FireClient(Player)
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

function ShopCheckOpen(plr,Bool)
    local PData = Data:Get(plr)
    if Bool == true then
        PData.BaseFakeSettings.OpenCameraCustom = true
        PData:Update('BaseFakeSettings', PData.BaseFakeSettings)
    else
        PData.BaseFakeSettings.OpenCameraCustom = false
        PData:Update('BaseFakeSettings', PData.BaseFakeSettings)
    end
end

Remotes.RemoteShop.OnServerEvent:Connect(ShopCheckOpen)
Remotes.BuyShop.OnServerEvent:Connect(ShopBuyServer)
Remotes.BuyShop2.OnServerEvent:Connect(EquipmentServer)
Remotes.HiveConvert.OnServerEvent:Connect(ConvertServer)
task.spawn(Barier)

return AllScript