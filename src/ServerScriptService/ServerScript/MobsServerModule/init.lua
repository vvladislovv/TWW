local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Remotes = ReplicatedStorage:WaitForChild('Remotes')
local ModuleTable = require(ReplicatedStorage.Modules.ModuleTable)
local ZonePlus = require(ReplicatedStorage.Zone)
local Data = require(ServerScriptService.ServerScript.Data)
local FieldGame = require(ServerScriptService.ServerScript.FieldModule)
local Utils = require(ReplicatedStorage.Libary.Utils)
local ModuleMobs = {}

function ModuleMobs:TimerMobs(Player,ZoneBarier)
    local PData = Data:Get(Player)

    if PData.TimerTable[ZoneBarier.Name] then
        for i, v2 in next, ZoneBarier:GetChildren() do
            if PData.TimerTable[ZoneBarier.Name][v2.Name].Time >= 0 then
                if v2.Mobs.Value then
                    task.wait()
                    if v2.Name == "Timer1" and not v2.Timer.Value then
                        TweenService:Create(v2.BillboardGui, TweenInfo.new(1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Size = UDim2.new(3, 0,2, 0)}):Play()
                        v2.Timer.Value = true
                        local timerData = tonumber(PData.TimerTable[ZoneBarier.Name][v2.name].Time)
                        PData.TimerTable[ZoneBarier.Name][v2.name] = {Time = timerData + os.time()}
                        Remotes.MobsTimer:FireClient(Player,PData,ZoneBarier,v2)
                    elseif v2.Name == "Timer2" and not v2.Timer.Value then
                        TweenService:Create(v2.BillboardGui, TweenInfo.new(1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Size = UDim2.new(3, 0,2, 0)}):Play()
                        v2.Timer.Value = true
                        local timerData = tonumber(PData.TimerTable[ZoneBarier.Name][v2.name].Time)
                        PData.TimerTable[ZoneBarier.Name][v2.name] = {Time = timerData + os.time()}
                        Remotes.MobsTimer:FireClient(Player,PData,ZoneBarier,v2)
                    elseif v2.Name == "Timer3" and not v2.Timer.Value then
                        TweenService:Create(v2.BillboardGui, TweenInfo.new(1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Size = UDim2.new(3, 0,2, 0)}):Play()
                        v2.Timer.Value = true
                        local timerData = tonumber(PData.TimerTable[ZoneBarier.Name][v2.name].Time)
                        PData.TimerTable[ZoneBarier.Name][v2.name] = {Time = timerData + os.time()}
                        Remotes.MobsTimer:FireClient(Player,PData,ZoneBarier,v2)
                    elseif v2.Name == "Timer4" and not v2.Timer.Value then
                        TweenService:Create(v2.BillboardGui, TweenInfo.new(1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Size = UDim2.new(3, 0,2, 0)}):Play()
                        v2.Timer.Value = true
                        local timerData = tonumber(PData.TimerTable[ZoneBarier.Name][v2.name].Time)
                        PData.TimerTable[ZoneBarier.Name][v2.name] = {Time = timerData + os.time()}
                        Remotes.MobsTimer:FireClient(Player,PData,ZoneBarier,v2)
                    elseif v2.Name == "Timer5" and not v2.Timer.Value then
                        TweenService:Create(v2.BillboardGui, TweenInfo.new(1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Size = UDim2.new(3, 0,2, 0)}):Play()
                        v2.Timer.Value = true
                        local timerData = tonumber(PData.TimerTable[ZoneBarier.Name][v2.name].Time)
                        PData.TimerTable[ZoneBarier.Name][v2.name] = {Time = timerData + os.time()}
                        Remotes.MobsTimer:FireClient(Player,PData,ZoneBarier,v2)
                        
                    end
                    
                else
                    Remotes.MobsNoTimer:FireClient(Player,v2)
                   -- PData.TimerTable[ZoneBarier.Name][v2.name] = {Time = 200 + os.time()}
                end
            else
                Remotes.MobsNoTimer:FireClient(Player,v2)
            end
        end
    end
end

-- Возможно не рабоатет в один барьерах (workspace.Map.GameSettings.FieldBarier)-- 2 раза используеться
for _, Zoneier in next, workspace.Map.GameSettings.FieldBarierMobs:GetChildren() do
    local Zone = ZonePlus.new(Zoneier)
    Zone.playerEntered:Connect(function(Player)
        local PData = Data:Get(Player)
        for i,ZoneBarier in next, workspace.Map.GameSettings.TimerMobs:GetChildren() do
            if PData.TimerTable[ZoneBarier.Name] then
                for i,v2 in next, ZoneBarier:GetChildren() do
                    if PData.TimerTable[ZoneBarier.Name][v2.Name].Time <= 0 then
                        PData.BaseFakeSettings.MonsterZone = true
                    elseif PData.TimerTable[ZoneBarier.Name][v2.Name].Time >= 0 then
                        PData.BaseFakeSettings.FieldMods = FieldGame.Correspondant[ZoneBarier.Name]
                        PData.BaseFakeSettings.MonsterZone = true
                        ModuleMobs:TimerMobs(Player,ZoneBarier)
                        PData:Update('BaseFakeSettings', PData.BaseFakeSettings)
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
                    task.spawn(function()
                        while true do
                            task.wait()
                            if PData.TimerTable[v.Name][v2.Name].Time >= 0 then
                                ModuleMobs:TimerMobs(Player,v)
                                print('ff')
                                break
                            end
                        end
                    end)
                    Remotes.MobsNoTimer:FireClient(Player,v2)
                else
                    --v2.BillboardGui.TextLabel.Text = Utils:FormatTime(PData.TimerTable[v.Name][v2.Name].Time)
                   ModuleMobs:TimerMobs(Player,v)
                end
            end
        end       
    end
end)
--ModuleMobs:TimerMobs()


return ModuleMobs