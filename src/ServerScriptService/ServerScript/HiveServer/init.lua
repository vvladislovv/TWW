local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Data = require(ServerScriptService.ServerScript.Data)
local TweenModule = require(ReplicatedStorage.Libary.TweenModule)
local ModuleTable = require(ReplicatedStorage.Modules.ModuleTable)

local Remotes = ReplicatedStorage:WaitForChild('Remotes')


local HiveServer = {}

function HiveOwner(Player,Hive)
    local PData = Data:Get(Player)
    if PData.BaseFakeSettings.HiveOwner == "" and Hive.Owner.Value == "" then
        PData.BaseFakeSettings.HiveNumberOwner = Hive.Name
        PData.BaseFakeSettings.HiveOwner = Player.Name

        Hive.NamePlayerHive.BillboardGui.TextLabel.Text = Player.Name
        Hive.HivePlatform.Up.SurfaceGui.TextLabel.Text = Player.Name
        Hive.Owner.Value = Player.Name
    end
end


function HiveSpawn(Player, HiveGet)
    local PData = Data:Get(Player)

    local function SpawnHiveEffect()
        HiveGet.HiveModel.Material = Enum.Material.Neon
        TweenModule:SpawnHive(HiveGet)
        HiveGet.HiveModel.Material = Enum.Material.SmoothPlastic
    end

    local function SpawnHiveSlot()
        if HiveGet.Owner.Value == PData.BaseFakeSettings.HiveOwner then

            local function CheckSlotWasp(CheckSlot)
                for NumberSlot, GetSlot in pairs(PData.Hive.WaspSettings) do
                    if NumberSlot == CheckSlot then
                        local RaritymMax = tostring(GetSlot.Rarity)
                        if ModuleTable.Rarity[RaritymMax] then
                            HiveGet.Slots[NumberSlot].Down.SurfaceGui.ImageLabel.Image = ModuleTable.Wasp[GetSlot.Name].Icon
                            HiveGet.Slots[NumberSlot].Down.Color = ModuleTable.Rarity[RaritymMax][2]
                        end


                        HiveGet.Slots[NumberSlot].NameWasp.Value = GetSlot.Name
                        HiveGet.Slots[NumberSlot].Level.LevelWasp.Value = GetSlot.Level
                        HiveGet.Slots[NumberSlot].Level.SurfaceGui.TextLabel.Text = GetSlot.Level
                    end
                end
            end

            local CheckSlotPlayer = PData.Hive.SlotsAll
            local CheckSlot = 0

            if CheckSlotPlayer ~= CheckSlot then
                repeat
                    --task.wait(0.25)
                    CheckSlot += 1
                    CheckSlotWasp(CheckSlot)
                    TweenModule:SpawnSlotHive(HiveGet,CheckSlot)
                until CheckSlotPlayer == CheckSlot
            end
        end
    end

    SpawnHiveEffect()
    SpawnHiveSlot()

end

function HiveLeave(Player)
    for _, index in next, workspace.Map.GameSettings.Hives:GetChildren() do
        if index.Owner.Value == Player.Name then
            local PData = Data:Get(Player)
            local function SpawnHiveEffect()
                index.HiveModel.Material = Enum.Material.Neon
                TweenModule:SpawnHive(index)
                index.HiveModel.Material = Enum.Material.SmoothPlastic
            end

            local function SpawnHiveSlot()
                if index.Owner.Value == PData.BaseFakeSettings.HiveOwner then
                    local CheckSlotPlayer = PData.Hive.SlotsAll
                    local CheckSlot = 0
        
                    if CheckSlotPlayer ~= CheckSlot then
                        repeat
                            --task.wait(0.25)
                            CheckSlot += 1
                            TweenModule:DestroySlotHive(index,CheckSlot)

                            if CheckSlot <= 0 then
                                CheckSlot = 0
                            end

                        until CheckSlotPlayer == CheckSlot
                    end
                end
            end

            SpawnHiveEffect()
            SpawnHiveSlot()
    
            index.NamePlayerHive.BillboardGui.TextLabel.Text = "Name Owner"
            index.HivePlatform.Up.SurfaceGui.TextLabel.Text = "Name"
            index.Owner.Value = ""
        end
    end
end

game.Players.PlayerRemoving:Connect(HiveLeave)

Remotes.HiveSpawnSlot.OnServerEvent:Connect(HiveSpawn)
Remotes.HiveOwner.OnServerEvent:Connect(HiveOwner)

return HiveServer