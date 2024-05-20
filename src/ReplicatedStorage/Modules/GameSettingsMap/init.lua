local Player = game.Players.LocalPlayer
local GrassFolder = workspace.Map.GameSettings.MapGrass.Bush

local GameSettingsMap = {} -- надо до делать кусты

for _, index in next, GrassFolder:GetChildren()  do
    for _, index2 in next, index:GetChildren() do
        if index2.Name == "PartEffect" then
            index2.Touched:Connect(function(hit)
                if hit.Parent == Player.Character then
                    index2.ParticleEmitter.Enabled = true
                end
            end)
        
            index2.TouchEnded:Connect(function(hit)
                if hit.Parent == Player.Character then
                    task.wait(1)
                    index2.ParticleEmitter.Enabled = false
                end
            end) 
        end
    end
end


return GameSettingsMap