local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local Remotes = ReplicatedStorage:WaitForChild('Remotes')
local Data = require(ServerScriptService.ServerScript.Data)

local TimerMob = {}

function TimerMob:CreateTimerMobs(Player,Field1,Mob)
    local PData = Data:Get(Player)
    --print(Field1:IsA('BasePart'))
    if Field1:IsA('BasePart') then
        local FieldData = PData.TimerTable.Field[Field1.Name]
        for i, TimerData in FieldData do
            if TimerData ~= nil then
                if TimerData.Time >= 0 and PData.BaseFakeSettings.FieldVarsOld == Field1.Name then -- Если таймер не ноль
                    Remotes.MobsTimer:FireClient(Player,PData, TimerData, Field1, i, Mob) -- Если таймер ноль
                end
            end
        end
    end
end

return TimerMob