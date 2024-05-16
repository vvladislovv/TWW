local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Remotes = ReplicatedStorage:WaitForChild('Remotes')
local Utils = require(ReplicatedStorage.Libary.Utils)
local TweenModule = require(ReplicatedStorage.Libary.TweenModule)
local MobsModule = {}


function TimerClient(PData,ZoneBarier,v2)
    while PData.TimerTable.Field[ZoneBarier.Name][v2.Name].Time - os.time() >= 0 do
        local FieldData = PData.TimerTable.Field[ZoneBarier.Name]
        TweenModule:BillboardGuiOpen(v2)            
        v2.BillboardGui.Enabled = true
        task.wait(1)
        v2.BillboardGui.TextLabel.Text = Utils:FormatTime(FieldData[v2.Name].Time - os.time())
        if FieldData[v2.Name].Time - os.time() <= 0 then
            TweenModule:BillboardGuiClose(v2)
            task.wait(0.3)
            v2.TimerStart.Value = false
            v2.BillboardGui.Enabled = false
            Remotes.ServerMobsNoffical:FireServer()
            break
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