local ButtonServer = {}


local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local function CalculateDistance(Button, HumRootPart)
    return (Button.Position - HumRootPart.Position).Magnitude
end

game:GetService("RunService").Heartbeat:Connect(function()
    for _, player in ipairs(Players:GetPlayers()) do
        local Humanoid = player.Character and player.Character:FindFirstChild("Humanoid")
        local HumRootPart = player.Character and player.Character:FindFirstChild("HumanoidRootPart")

        if Humanoid and Humanoid.Health > 0 and HumRootPart then
            for _, Button in ipairs(game.Workspace.Map.GameSettings.Button:GetChildren()) do
                local Distance = CalculateDistance(Button, HumRootPart)
                ReplicatedStorage.Remotes.ButtonCleint:FireClient(player,Button,Distance)
            end
        end
    end
end)

return ButtonServer