local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Remotes = ReplicatedStorage:WaitForChild('Remotes')
local ModuleTable = require(ReplicatedStorage.Modules.ModuleTable)
local ZonePlus = require(ReplicatedStorage.Zone)
local Utils = require(ReplicatedStorage.Libary.Utils)
_G.PData = Remotes.GetDataSave:InvokeServer()
local ModuleMobs = {}

function TimerMobs(ZoneBarier) -- Проблема в том что таймер и время должно обновляться и проверяться на сервере
    if _G.PData.TimerTable[ZoneBarier.Name] then
        for i, v2 in next, ZoneBarier:GetChildren() do
            if _G.PData.TimerTable[ZoneBarier.Name][v2.Name].Time >= 0 then
                if v2.Mobs.Value then
                    task.wait()
                    if v2.Name == "Timer1" and not v2.Timer.Value then
                        TweenService:Create(v2.BillboardGui, TweenInfo.new(1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Size = UDim2.new(3, 0,2, 0)}):Play()
                        v2.Timer.Value = true
                        local timerData = tonumber(_G.PData.TimerTable[ZoneBarier.Name][v2.name].Time)
                        _G.PData.TimerTable[ZoneBarier.Name][v2.name] = {Time = timerData + os.time()}
                        task.spawn(function()
                            while true do
                                task.wait()
                                print('ff')
                                --print(Utils:FormatTime(_G.PData.TimerTable[ZoneBarier.Name][v2.Name].Time))
                                v2.BillboardGui.TextLabel.Text = Utils:FormatTime(_G.PData.TimerTable[ZoneBarier.Name][v2.Name].Time - os.time())
                                if _G.PData.TimerTable[ZoneBarier.Name][v2.Name].Time - os.time() == 0 then
                                    TweenService:Create(v2.BillboardGui, TweenInfo.new(1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Size = UDim2.new(0,0,0,0)}):Play()--{3, 0},{2, 0}
                                    task.wait(0.3)
                                    v2.Timer.Value = false
                                    v2.BillboardGui.Enabled = false
                                    break
                                end
                            end
                        end)
                    elseif v2.Name == "Timer2" and not v2.Timer.Value then
                        TweenService:Create(v2.BillboardGui, TweenInfo.new(1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Size = UDim2.new(3, 0,2, 0)}):Play()
                        v2.Timer.Value = true
                        local timerData = tonumber(_G.PData.TimerTable[ZoneBarier.Name][v2.name].Time)
                        _G.PData.TimerTable[ZoneBarier.Name][v2.name] = {Time = timerData + os.time()}
                        task.spawn(function()
                            while _G.PData.TimerTable[ZoneBarier.Name][v2.Name].Time - os.time() >= 0 do
                                task.wait()
                                --print(Utils:FormatTime(_G.PData.TimerTable[ZoneBarier.Name][v2.Name].Time))
                                v2.BillboardGui.TextLabel.Text = Utils:FormatTime(_G.PData.TimerTable[ZoneBarier.Name][v2.Name].Time - os.time())
                                if _G.PData.TimerTable[ZoneBarier.Name][v2.Name].Time - os.time() == 0 then
                                    TweenService:Create(v2.BillboardGui, TweenInfo.new(1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Size = UDim2.new(0,0,0,0)}):Play()--{3, 0},{2, 0}
                                    task.wait(0.3)
                                    v2.BillboardGui.Enabled = false
                                    v2.Timer.Value = false
                                    break
                                end
                            end
                        end)
                    elseif v2.Name == "Timer3" and not v2.Timer.Value then
                        TweenService:Create(v2.BillboardGui, TweenInfo.new(1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Size = UDim2.new(3, 0,2, 0)}):Play()
                        v2.Timer.Value = true
                        local timerData = tonumber(_G.PData.TimerTable[ZoneBarier.Name][v2.name].Time)
                        _G.PData.TimerTable[ZoneBarier.Name][v2.name] = {Time = timerData + os.time()}
                        task.spawn(function()
                            while _G.PData.TimerTable[ZoneBarier.Name][v2.Name].Time - os.time() >= 0 do
                                task.wait()
                                --print(Utils:FormatTime(_G.PData.TimerTable[ZoneBarier.Name][v2.Name].Time))
                                v2.BillboardGui.TextLabel.Text = Utils:FormatTime(_G.PData.TimerTable[ZoneBarier.Name][v2.Name].Time - os.time())
                                if _G.PData.TimerTable[ZoneBarier.Name][v2.Name].Time - os.time() == 0 then
                                    TweenService:Create(v2.BillboardGui, TweenInfo.new(1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Size = UDim2.new(0,0,0,0)}):Play()--{3, 0},{2, 0}
                                    task.wait(0.3)
                                    v2.BillboardGui.Enabled = false
                                    v2.Timer.Value = false
                                    break
                                end
                            end
                        end)
                    elseif v2.Name == "Timer4" and not v2.Timer.Value then
                        TweenService:Create(v2.BillboardGui, TweenInfo.new(1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Size = UDim2.new(3, 0,2, 0)}):Play()
                        v2.Timer.Value = true
                        local timerData = tonumber(_G.PData.TimerTable[ZoneBarier.Name][v2.name].Time)
                        _G.PData.TimerTable[ZoneBarier.Name][v2.name] = {Time = timerData + os.time()}
                        task.spawn(function()
                            while _G.PData.TimerTable[ZoneBarier.Name][v2.Name].Time - os.time() >= 0 do
                                task.wait()
                                --print(Utils:FormatTime(_G.PData.TimerTable[ZoneBarier.Name][v2.Name].Time))
                                v2.BillboardGui.TextLabel.Text = Utils:FormatTime(_G.PData.TimerTable[ZoneBarier.Name][v2.Name].Time - os.time())
                                if _G.PData.TimerTable[ZoneBarier.Name][v2.Name].Time - os.time() == 0 then
                                    TweenService:Create(v2.BillboardGui, TweenInfo.new(1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Size = UDim2.new(0,0,0,0)}):Play()--{3, 0},{2, 0}
                                    task.wait(0.3)
                                    v2.BillboardGui.Enabled = false
                                    v2.Timer.Value = false
                                    break
                                end
                            end
                        end)
                    elseif v2.Name == "Timer5" and not v2.Timer.Value then
                        TweenService:Create(v2.BillboardGui, TweenInfo.new(1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Size = UDim2.new(3, 0,2, 0)}):Play()
                        v2.Timer.Value = true
                        local timerData = tonumber(_G.PData.TimerTable[ZoneBarier.Name][v2.name].Time)
                        _G.PData.TimerTable[ZoneBarier.Name][v2.name] = {Time = timerData + os.time()}
                        task.spawn(function()
                            while _G.PData.TimerTable[ZoneBarier.Name][v2.Name].Time - os.time() >= 0 do
                                task.wait()
                                --print(Utils:FormatTime(_G.PData.TimerTable[ZoneBarier.Name][v2.Name].Time))
                                v2.BillboardGui.TextLabel.Text = Utils:FormatTime(_G.PData.TimerTable[ZoneBarier.Name][v2.Name].Time - os.time())
                                if _G.PData.TimerTable[ZoneBarier.Name][v2.Name].Time - os.time() == 0 then
                                    TweenService:Create(v2.BillboardGui, TweenInfo.new(1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Size = UDim2.new(0,0,0,0)}):Play()--{3, 0},{2, 0}
                                    task.wait(0.3)
                                    v2.BillboardGui.Enabled = false
                                    v2.Timer.Value = false
                                    break
                                end
                            end
                        end)
                    end
                    
                else
                    TweenService:Create(v2.BillboardGui, TweenInfo.new(1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Size = UDim2.new(0,0,0,0)}):Play()--{3, 0},{2, 0}
                    task.wait(0.3)
                    v2.BillboardGui.Enabled = false
                   -- _G.PData.TimerTable[ZoneBarier.Name][v2.name] = {Time = 200 + os.time()}
                end
            else
                TweenService:Create(v2.BillboardGui, TweenInfo.new(1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Size = UDim2.new(0,0,0,0)}):Play()--{3, 0},{2, 0}
                task.wait(0.3)
                v2.BillboardGui.Enabled = false
            end
        end
    end
end

function NotTimer(v2)
    TweenService:Create(v2.BillboardGui, TweenInfo.new(1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Size = UDim2.new(0,0,0,0)}):Play()--{3, 0},{2, 0}
    task.wait(0.3)
    v2.BillboardGui.Enabled = false
end
Remotes.MobsNoTimer.OnClientEvent:Connect(NotTimer)
Remotes.MobsTimer.OnClientEvent:Connect(TimerMobs)

return ModuleMobs