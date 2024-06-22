local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Remotes = ReplicatedStorage:WaitForChild('Remotes')
local Utils = require(ReplicatedStorage.Libary.Utils)
local TweenModule = require(ReplicatedStorage.Libary.TweenModule)
local MobsModule = {}


function MobsModule:TimerClient(PData, TimerData, Field1, i, Mob)
    --print(Field1[i].NameMonster.Value == Mob.Name)

    if TimerData ~= nil and PData.BaseFakeSettings.FieldVarsOld == Field1.Name and Field1[i].NameMonster.Value == Mob.Name then
        Field1[i].BillboardGui.Enabled = true
        TweenModule:BillboardGuiOpen(Field1[i])

        for index, _ in pairs(PData.TimerTable.Field[Field1.Name]) do
            if index == i and not Field1[i].TimerStart.Value then

                Field1[i].TimerStart.Value = true

                while true do
                    task.wait(1)

                    Field1[i].BillboardGui.TextLabel.Text = Utils:FormatTime(math.max(0, TimerData.Time - os.time()))
                    
                    if TimerData.Time - os.time() <= 0  then
                        --print(i)
                        TimerData.Time = 0
                        TweenModule:BillboardGuiClose(Field1[i])
                        task.wait(0.3)
                        Field1[i].BillboardGui.Enabled = false
                        Field1[i].TimerStart.Value = false
                        require(script.Parent["MobsModuleС2"].CreateMob):MobsCreatServer(Field1.Name)

                        break
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
--Remotes.MobsTimer.OnClientEvent:Connect(TimerClient)

return MobsModule