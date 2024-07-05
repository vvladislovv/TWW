local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local ZonePlus = require(ReplicatedStorage.Zone)
local MobsModuleServer = {}


for _, Zoneier in pairs(workspace.Map.GameSettings.FieldBarierMobs:GetChildren()) do
    local Zone = ZonePlus.new(Zoneier)
    local CollectTimers = 0


    Zone.playerEntered:Connect(function(Player)
        local PData = _G.PData
        if PData.TimerTable.Field[Zoneier.Name] then
            PData.BaseFakeSettings.FieldMods = Zoneier.Name
            for _, Index in Zoneier:GetChildren() do
                if Index:IsA('BasePart') then
                    CollectTimers += 1 
                    local FieldData = PData.TimerTable.Field[Zoneier.Name]
                    if FieldData[Index.Name] ~= nil then
                        if FieldData[Index.Name].Time <= 0 then -- Если таймер ноль
                            PData.BaseFakeSettings.MonsterZone = true
                            require(script.CreateMob):CreatersMobsField(Player,Zoneier,Index,CollectTimers)
                        elseif FieldData[Index.Name].Time >= 0 then -- Если таймер не ноль
                            PData.BaseFakeSettings.MonsterZone = false
                        end
                    end
                end 
            end
        end
    end)

    Zone.playerExited:Connect(function(Player)
        local PData = _G.PData
        PData.BaseFakeSettings.MonsterZone = false
        CollectTimers = 0
        PData.BaseFakeSettings.FieldMods = ""
        --PData:Update('BaseFakeSettings', PData.BaseFakeSettings)
    end)
end

return MobsModuleServer