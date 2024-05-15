local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Remotes = ReplicatedStorage:WaitForChild('Remotes')
local Utils = require(ReplicatedStorage.Libary.Utils)
local TweenModule = require(ReplicatedStorage.Libary.TweenModule)
local MobsModule = {}


function TimerClient(PData,ZoneBarier,v2)
    task.spawn(function()
        while PData.TimerTable[ZoneBarier.Name][v2.Name].Time - os.time() >= 0 do
            TweenService:Create(v2.BillboardGui, TweenInfo.new(1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Size = UDim2.new(3, 0,2, 0)}):Play()
            v2.BillboardGui.Enabled = true
            print(PData.TimerTable[ZoneBarier.Name][v2.Name].Time - os.time())
            print(v2.BillboardGui.Enabled)
            task.wait(1)
            v2.BillboardGui.TextLabel.Text = Utils:FormatTime(PData.TimerTable[ZoneBarier.Name][v2.Name].Time - os.time())
            if PData.TimerTable[ZoneBarier.Name][v2.Name].Time - os.time() == 0 then
                TweenModule:BillboardGuiOpen(v2)
                task.wait(0.3)
                v2.Timer.Value = false
                v2.BillboardGui.Enabled = false
                break
            end
        end
    end)
end

function TimerNot(v2)
    TweenModule:BillboardGuiClose(v2)
    task.wait(0.3)
    v2.BillboardGui.Enabled = false
end
Remotes.MobsNoTimer.OnClientEvent:Connect(TimerNot)
Remotes.MobsTimer.OnClientEvent:Connect(TimerClient)
return MobsModule