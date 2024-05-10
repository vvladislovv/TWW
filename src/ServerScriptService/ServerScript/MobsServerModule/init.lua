
local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = ReplicatedStorage:WaitForChild('Remotes')
local ZonePlus = require(ReplicatedStorage.Zone)
local Data = require(ServerScriptService.ServerScript.Data)
local FieldGame = require(ServerScriptService.ServerScript.FieldModule)
local MobsServerModule = {}

for _, Zoneier in next, workspace.Map.GameSettings.FieldBarierMobs:GetChildren() do
    local Zone = ZonePlus.new(Zoneier)
    Zone.playerEntered:Connect(function(Player)
        local PData = Data:Get(Player)
        for i,ZoneBarier in next, workspace.Map.GameSettings.TimerMobs:GetChildren() do
            if PData.TimerTable[ZoneBarier.Name] then
                for i,v2 in next, ZoneBarier:GetChildren() do
                    if PData.TimerTable[ZoneBarier.Name][v2.Name].Time <= 0 then
                        PData.BaseFakeSettings.MonsterZone = true
                        PData:Update('BaseFakeSettings', PData.BaseFakeSettings)
                    elseif PData.TimerTable[ZoneBarier.Name][v2.Name].Time >= 0 then
                        PData.BaseFakeSettings.FieldMods = FieldGame.Correspondant[ZoneBarier.Name]
                        PData.BaseFakeSettings.MonsterZone = true
                        PData:Update('BaseFakeSettings', PData.BaseFakeSettings)
                        Remotes.MobsTimer:FireClient(Player,Player,ZoneBarier)
                    end
                end
            end
        end
    end)

    Zone.playerExited:Connect(function(Player)
        local PData = Data:Get(Player)
        PData.BaseFakeSettings.MonsterZone = false
        PData:Update('BaseFakeSettings', PData.BaseFakeSettings)
    end)
end

game.Players.PlayerAdded:Connect(function(Player)
    task.wait()
    local PData = Data:Get(Player)
    if not PData.Loaded then
        repeat task.wait() PData = Data:Get(Player) until PData.Loaded
    end
    for i,v in next, workspace.Map.GameSettings.TimerMobs:GetChildren() do
        if PData.TimerTable[v.Name] then
            for i,v2 in next, v:GetChildren() do
                if PData.TimerTable[v.Name][v2.Name].Time <= 0 then
                    Remotes.MobsNoTimer:FireClient(Player,v)
                else
                    Remotes.MobsTimer:FireClient(Player,v)
                end
            end
        end       
    end
end)

return MobsServerModule