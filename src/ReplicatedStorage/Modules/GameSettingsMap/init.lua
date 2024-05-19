local Player = game.Players.LocalPlayer
local GrassFolder = workspace.Map.GameSettings.MapGrass.Bush

local GameSettingsMap = {} -- надо до делать кусты

for _, index in next, GrassFolder.BushModel:GetChildren()  do
    index.Touched:Connect(function(hit)
        if hit.Parent == Player.Character then
            index.ParticleEmitter.Enabled = true
        end
    end)

    index.TouchEnded:Connect(function(hit)
        if hit.Parent == Player.Character then
            task.wait(0.5)
            index.ParticleEmitter.Enabled = false
        end
    end) 
end


return GameSettingsMap