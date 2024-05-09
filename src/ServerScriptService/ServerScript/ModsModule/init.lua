local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = ReplicatedStorage:WaitForChild('Remotes')
local ModuleTable = require(ReplicatedStorage.Modules.ModuleTable)
local ZonePlus = require(ReplicatedStorage.Zone)
local Data = require(ServerScriptService.ServerScript.Data)


local ModuleMobs = {}

function ModuleMobs:TimerMobs()
    
end

-- Возможно не рабоатет в один барьерах (workspace.Map.GameSettings.FieldBarier)-- 2 раза используеться
for _, ZoneBarier in next, workspace.Map.GameSettings.FieldBarier:GetChildren() do
    local Zone = ZonePlus.new(ZoneBarier)
    Zone.playerEntered:Connect(function(Player)
        local PData = Data:Get(Player)
        print(ZoneBarier.Name)
        if not PData.TimerTable[ZoneBarier.Name].Time then
            PData.BaseFakeSettings.FieldMods = ZoneBarier.Name
            PData.BaseFakeSettings.MonsterZone = true
            PData:Update('BaseFakeSettings', PData.BaseFakeSettings)
            --CreatMobs
        elseif PData.TimerTable[ZoneBarier.Name].Time then
            if PData.TimerTable[ZoneBarier.Name].Time - os.time() <= 0 then
                PData.BaseFakeSettings.MonsterZone = true
                --CreatMobs
            end
        end
    end)

    Zone.playerExited:Connect(function(Player)
        local PData = Data:Get(Player)
        PData.BaseFakeSettings.MonsterZone = false
        PData:Update('BaseFakeSettings', PData.BaseFakeSettings)
    end)
end
--ModuleMobs:TimerMobs()


return ModuleMobs