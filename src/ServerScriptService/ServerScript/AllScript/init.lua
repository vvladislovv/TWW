local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Remotes = ReplicatedStorage:WaitForChild('Remotes')
local AllScript = {}

local Data = require(ServerScriptService.ServerScript.Data)
local ZonePlus = require(game.ReplicatedStorage.Zone)
local EquipmentModule = require(ServerScriptService.ServerScript.Equipment)
local Equipment = require(ServerScriptService.ServerScript.Equipment)
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

function BanSystems(Player)
    local TableBanPlayer = {
        [1] = 'dima0tu3',
        [2] = 'iQlemjo',
        [3] = 'CblH_Cengdopa',
        [4] = 'BroNlockLove',
        [5] = 'dima0tu17',
        [6] = 'KtotoVBSS'
    }

    for _, GetTable in next, TableBanPlayer do
        if GetTable == Player.Name then
            Player:Kick()
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
                print(PData.EquipmentShop[CameraType2.Type.Value.."s"])
                if i == CameraType2.ItemsName.Value then
                    print(CameraType2)
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

Remotes.BuyShop.OnServerEvent:Connect(ShopBuyServer)
Remotes.BuyShop2.OnServerEvent:Connect(EquipmentServer)
game.Players.PlayerAdded:Connect(BanSystems)
task.spawn(Barier)

return AllScript