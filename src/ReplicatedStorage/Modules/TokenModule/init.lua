local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local TweenModule = require(ReplicatedStorage.Libary.TweenModule)
local RunService = game:GetService("RunService")
local Remotes = ReplicatedStorage:WaitForChild('Remotes')
local TokenCoulduwn = false
local TokenModule = {}
local TokenTable = {}



function AnimToken(Token,Info)
    TokenTable.CFrame = Token.PrimaryPart.CFrame * CFrame.Angles(0, math.rad(1), 0)
    if Token then -- Нужно придумать и решить проблему с позицией и FieldVars есть баг надо пофиксить
        TweenService:Create(Token.PrimaryPart,TweenInfo.new(1.5,Enum.EasingStyle.Elastic,Enum.EasingDirection.Out), {Position = Token.PrimaryPart.Position + Vector3.new(0,2.75,0)}):Play()
        TweenService:Create(Token.Tokenimage,TweenInfo.new(1.5,Enum.EasingStyle.Elastic,Enum.EasingDirection.Out), {Position = Token.Tokenimage.Position + Vector3.new(0,2.75,0)}):Play()
        TweenService:Create(Token.DownColor,TweenInfo.new(1.5,Enum.EasingStyle.Elastic,Enum.EasingDirection.Out), {Position = Token.DownColor.Position + Vector3.new(0,2.75,0)}):Play()
        TokenCoulduwn = true
        task.spawn(function()
            repeat
                task.wait()
                Token.PrimaryPart.CFrame = Token.PrimaryPart.CFrame * CFrame.Angles(0, math.rad(1), 0)
            until TokenCoulduwn == false
        end)
        Token.PrimaryPart.Touched:Connect(function(hit)
            
            TweenService:Create(Token.PrimaryPart,TweenInfo.new(1.5,Enum.EasingStyle.Elastic,Enum.EasingDirection.Out), {Position = Token.PrimaryPart.Position + Vector3.new(0,1,0), Orientation = Vector3.new(-90,0,0)}):Play()
            TweenService:Create(Token.Tokenimage,TweenInfo.new(1.5,Enum.EasingStyle.Elastic,Enum.EasingDirection.Out), {Position = Token.Tokenimage.Position + Vector3.new(0,1,0), Orientation = Vector3.new(-90,0,0)}):Play()
            TweenService:Create(Token.DownColor,TweenInfo.new(1.5,Enum.EasingStyle.Elastic,Enum.EasingDirection.Out), {Position = Token.DownColor.Position + Vector3.new(0,1,0), Orientation = Vector3.new(-90,0,0)}):Play()
        end)
        
        task.spawn(function()
            task.wait(15)
            TweenService:Create(Token.Tokenimage,TweenInfo.new(4,Enum.EasingStyle.Elastic,Enum.EasingDirection.Out), {Transparency = 1}):Play()
            TweenService:Create(Token.DownColor,TweenInfo.new(4,Enum.EasingStyle.Elastic,Enum.EasingDirection.Out), {Transparency = 1}):Play()

            TokenCoulduwn = false
            TweenService:Create(Token.PrimaryPart,TweenInfo.new(1.5,Enum.EasingStyle.Elastic,Enum.EasingDirection.Out), {Position = Token.PrimaryPart.Position + Vector3.new(0,-5,0)}):Play()
            TweenService:Create(Token.Tokenimage,TweenInfo.new(1.5,Enum.EasingStyle.Elastic,Enum.EasingDirection.Out), {Position = Token.Tokenimage.Position + Vector3.new(0,-5,0)}):Play()
            TweenService:Create(Token.DownColor,TweenInfo.new(1.5,Enum.EasingStyle.Elastic,Enum.EasingDirection.Out), {Position = Token.DownColor.Position + Vector3.new(0,-5,0)}):Play()
            task.wait(2)
            Token:Destroy()
        end)
    end
end

Remotes.TokenClient.OnClientEvent:Connect(AnimToken)

return TokenModule