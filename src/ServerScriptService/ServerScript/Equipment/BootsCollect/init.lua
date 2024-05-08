local BootsCollect = {}

local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Data = require(ServerScriptService.ServerScript.Data)

local Remote = ReplicatedStorage:WaitForChild('Remotes')

function BootsCollect:BootsCollectings(Player, Character)
    task.wait(1)
    task.spawn(function()
        local Flowers = {}
        local Touched = false
        local PData = Data:Get(Player)
        Character.RightUpperLeg.Touched:Connect(function(Flower)
            if Flower.Name == "Flower" and PData.BaseFakeSettings.FieldVars ~= "" then
                if Character.Humanoid.MoveDirection.Magnitude > 0 and PData.Boost.PlayerBoost["Movement Collection"] >= 0 then
                    if PData.IStats.Pollen < PData.IStats.Capacity then
                        if not table.find(Flowers, Flower) and Touched == false then
                            Touched = true
                            table.insert(Flowers, Flower)
                            Remote.FlowerClientBoots:FireClient(Player,{
                                HRP = Character.PrimaryPart,
                                Offset = Vector3.new(0,0,0),
                                StatsMOD = {
                                    Stamp = "BootsCollect"
                                }})
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