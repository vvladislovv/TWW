local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local TweenModule = require(ReplicatedStorage.Libary.TweenModule)

local Remotes = ReplicatedStorage:WaitForChild('Remotes')
local TokenModule = {}

function AnimToken(Token,Info)
    if Token then -- Нужно придумать и решить проблему с позицией и FieldVars есть баг надо пофиксить
        TweenService:Create(Token.PrimaryPart,TweenInfo.new(1.5,Enum.EasingStyle.Quad,Enum.EasingDirection.Out), {Position = Info.Position + Vector3.new(0,2.75,0)}):Play()
        TweenService:Create(Token.PrimaryPart,TweenInfo.new(5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1, false), {CFrame = Token.PrimaryPart.CFrame * CFrame.fromEulerAnglesXYZ(0, math.rad(180), 0)}):Play()    end
end

Remotes.TokenClient.OnClientEvent:Connect(AnimToken)

return TokenModule