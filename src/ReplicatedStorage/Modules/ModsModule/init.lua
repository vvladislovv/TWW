local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Remotes = ReplicatedStorage:WaitForChild('Remotes')
local Utils = require(ReplicatedStorage.Libary.Utils)
local TweenModule = require(ReplicatedStorage.Libary.TweenModule)
local MobsModule = {}
_G.PData = Remotes.GetDataSave:InvokeServer()

function TimerClient(PData,ZoneBarier,v2) --! ошибка тут с таймером и в спавне на сервер
    local CollectTimers = 0
    for _, Zoneier in pairs(workspace.Map.GameSettings.FieldBarierMobs:GetChildren()) do
        if Zoneier.name == ZoneBarier.Name then
            for _, Index in Zoneier:GetChildren() do
                if Index:IsA('BasePart') then
                    CollectTimers += 1
                    if PData.TimerTable.Field[ZoneBarier.Name][v2.Name] ~= nil and PData.BaseFakeSettings.FieldMods == ZoneBarier.Name then
                        while true do
                            local FieldData = PData.TimerTable.Field[ZoneBarier.Name]
                            task.wait(0.3)
                            v2.BillboardGui.Enabled = true
                            TweenModule:BillboardGuiOpen(v2)
                            task.wait(1)
                            v2.BillboardGui.TextLabel.Text = Utils:FormatTime(FieldData[v2.Name].Time - os.time())
                            if FieldData[v2.Name].Time - os.time() <= 0 then
                                FieldData[v2.Name].Time = 0
                                task.wait(0.3)
                                TweenModule:BillboardGuiClose(v2)
                                v2.BillboardGui.Enabled = false
                                v2.TimerStart.Value = false
                                Remotes.ServerMobsNoffical:FireServer(ZoneBarier.Name)
                                break
                            end
                        end
                    end
                end 
            end
        end
    end
end

function TimerNot(v2)
    TweenModule:BillboardGuiClose(v2)
    task.wait(0.3)
    v2.BillboardGui.Enabled = false
end
Remotes.MobsNoTimer.OnClientEvent:Connect(TimerNot)
Remotes.MobsTimer.OnClientEvent:Connect(TimerClient)
return MobsModule