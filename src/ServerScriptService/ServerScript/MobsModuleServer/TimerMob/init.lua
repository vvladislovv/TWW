local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Remotes = ReplicatedStorage:WaitForChild('Remotes')
local Data = require(ServerScriptService.ServerScript.Data)

local TimerMob = {}

function TimerMob:CreateTimerMobs(Player,Field)
    local PData = Data:Get(Player)
    for _, Zoneier in pairs(workspace.Map.GameSettings.FieldBarierMobs:GetChildren()) do
        print(PData.TimerTable.Field[Zoneier.Name])
        if PData.TimerTable.Field[Zoneier.Name] then
            PData.BaseFakeSettings.FieldMods = Zoneier.Name
            for _, Index in Zoneier:GetChildren() do
                if Index:IsA('BasePart') then
                    local FieldData = PData.TimerTable.Field[Zoneier.Name]
                    if FieldData[Index.Name] ~= nil then
                        if FieldData[Index.Name].Time >= 0 and PData.BaseFakeSettings.FieldMods == Zoneier.Name then -- Если таймер не ноль
                            Remotes.MobsTimer:FireClient(Player,PData,Field,Zoneier[Index.Name]) -- Если таймер ноль
                        end
                    end
                end 
            end
        end
    end
end

return TimerMob