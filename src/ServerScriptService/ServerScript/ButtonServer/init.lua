local ButtonServer = {}


local Players = game:GetService("Players")
local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Data = require(ServerScriptService.ServerScript.Data)

local function CalculateDistance(Button, HumRootPart)
    return (Button.Position - HumRootPart.Position).Magnitude
end

function Start()
    game:GetService("RunService").Heartbeat:Connect(function()
        
        for _, player in ipairs(Players:GetPlayers()) do
            local Humanoid = player.Character and player.Character:FindFirstChild("Humanoid")
            local HumRootPart = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            local PData = Data:Get(player)
            if Humanoid and Humanoid.Health > 0 and HumRootPart then
                for _, Button in ipairs(game.Workspace.Map.GameSettings.Button:GetChildren()) do
                    if PData.Loaded then
                        local Distance = CalculateDistance(Button, HumRootPart)
                        if ReplicatedStorage.Remotes:WaitForChild('ButtonClient') ~= nil then
                            ReplicatedStorage.Remotes:WaitForChild('ButtonClient'):FireClient(player,Button,Distance)                             
                        end
                    end
                end
            end
        end
    end)
end


ReplicatedStorage.Remotes.ClientOpenServer.OnServerEvent:Connect(Start)

return ButtonServer