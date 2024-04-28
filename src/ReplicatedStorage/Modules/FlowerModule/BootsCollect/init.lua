local BootsCollect = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remote = ReplicatedStorage:WaitForChild('Remotes')
_G.PData = Remote.GetDataSave:InvokeServer()


function BootsCollect:BootsCollectings(Player, Character,FlowerModule)
    task.wait(1)
    task.spawn(function()
        local Flowers = {}
        local Touched = false
        Character.RightUpperLeg.Touched:Connect(function(Flower)
            if Flower.Name == "Flower" and _G.PData.BaseFakeSettings.FieldVars ~= "" then
                if Character.Humanoid.MoveDirection.Magnitude > 0 and _G.PData.Boost.PlayerBoost["Movement Collection"] >= 0 then
                    if _G.PData.IStats.Pollen < _G.PData.IStats.CapacityItems then
                        if not table.find(Flowers, Flower) and Touched == false then
                            Touched = true
                            table.insert(Flowers, Flower)
                            FlowerModule:CollectFlower(Player, {
                                HRP = Character.PrimaryPart,
                                Offset = Vector3.new(0,0,0),
                                StatsMOD = {
                                    Stamp = "BootsCollect"
                                }
                            })
                            task.wait(0.025)
                            table.clear(Flowers)
                            Touched = false
                        end
                    end
                end
            end
        end)
    end)
end

return BootsCollect