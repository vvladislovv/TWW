local Player = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local TweenModule = require(ReplicatedStorage.Libary.TweenModule)
local RunService = game:GetService("RunService")
local Remotes = ReplicatedStorage:WaitForChild('Remotes')
local TokenCoulduwn = false
local TokenModule = {}



function AnimToken(Token,Info)
    local v1 = false
    local v2 = false
    local v3 = 0
    
    if Token then -- Нужно придумать и решить проблему с позицией и FieldVars есть баг надо пофиксить
        v2 = false
        TweenService:Create(Token.PrimaryPart,TweenInfo.new(1.5,Enum.EasingStyle.Elastic,Enum.EasingDirection.Out), {Position = Token.PrimaryPart.Position + Vector3.new(0,2.75,0)}):Play()
        TweenService:Create(Token.Tokenimage,TweenInfo.new(1.5,Enum.EasingStyle.Elastic,Enum.EasingDirection.Out), {Position = Token.Tokenimage.Position + Vector3.new(0,2.75,0)}):Play()
        TweenService:Create(Token.DownColor,TweenInfo.new(1.5,Enum.EasingStyle.Elastic,Enum.EasingDirection.Out), {Position = Token.DownColor.Position + Vector3.new(0,2.75,0)}):Play()
        TokenCoulduwn = true
        
        task.spawn(function() -- Problems (Наверное надо поменять саму систему вращения)
            repeat
                task.wait()
                if Token == nil then return else Token.PrimaryPart.CFrame = Token.PrimaryPart.CFrame * CFrame.Angles(0, math.rad(1), 0) end
            until TokenCoulduwn == false
        end)

        Token.PrimaryPart.Touched:Connect(function(hit)
            if v1 == false and hit.Parent == Player.Character and v3 == 0 then
                v1 = true
                v3 = 1
               -- TokenCoulduwn = false
                Token.PrimaryPart.Position += Vector3.new(0,1,0)            
                TweenService:Create(Token.PrimaryPart,TweenInfo.new(1.5,Enum.EasingStyle.Elastic,Enum.EasingDirection.Out,1), {Orientation = Vector3.new(0,-90,0)}):Play()
                TweenService:Create(Token.Tokenimage,TweenInfo.new(1.5,Enum.EasingStyle.Elastic,Enum.EasingDirection.Out,1), {Orientation = Vector3.new(0,-90,0)}):Play()
                TweenService:Create(Token.DownColor,TweenInfo.new(1.5,Enum.EasingStyle.Elastic,Enum.EasingDirection.Out,1), {Orientation = Vector3.new(0,-90,0)}):Play()
                
                TweenService:Create(Token.Tokenimage,TweenInfo.new(8,Enum.EasingStyle.Elastic,Enum.EasingDirection.Out), {Transparency = 1}):Play()
                TweenService:Create(Token.DownColor,TweenInfo.new(8,Enum.EasingStyle.Elastic,Enum.EasingDirection.Out), {Transparency = 1}):Play()
                task.wait(2)
                TweenService:Create(Token.PrimaryPart,TweenInfo.new(1.5,Enum.EasingStyle.Elastic,Enum.EasingDirection.Out), {Position = Token.PrimaryPart.Position + Vector3.new(0,-15,0)}):Play()
                TweenService:Create(Token.Tokenimage,TweenInfo.new(1.5,Enum.EasingStyle.Elastic,Enum.EasingDirection.Out), {Position = Token.Tokenimage.Position + Vector3.new(0,-15,0)}):Play()
                TweenService:Create(Token.DownColor,TweenInfo.new(1.5,Enum.EasingStyle.Elastic,Enum.EasingDirection.Out), {Position = Token.DownColor.Position + Vector3.new(0,-15,0)}):Play()
                Token:Destroy()
                v1 = false
                v2 = true
                v3 = 0
            end
        end)
        
        task.spawn(function()
            task.wait(15)
            if not v2 then
                TweenService:Create(Token.Tokenimage,TweenInfo.new(8,Enum.EasingStyle.Elastic,Enum.EasingDirection.Out), {Transparency = 1}):Play()
                TweenService:Create(Token.DownColor,TweenInfo.new(8,Enum.EasingStyle.Elastic,Enum.EasingDirection.Out), {Transparency = 1}):Play()
                task.wait(2)
                TweenService:Create(Token.PrimaryPart,TweenInfo.new(1.5,Enum.EasingStyle.Elastic,Enum.EasingDirection.Out), {Position = Token.PrimaryPart.Position + Vector3.new(0,-15,0)}):Play()
                TweenService:Create(Token.Tokenimage,TweenInfo.new(1.5,Enum.EasingStyle.Elastic,Enum.EasingDirection.Out), {Position = Token.Tokenimage.Position + Vector3.new(0,-15,0)}):Play()
                TweenService:Create(Token.DownColor,TweenInfo.new(1.5,Enum.EasingStyle.Elastic,Enum.EasingDirection.Out), {Position = Token.DownColor.Position + Vector3.new(0,-15,0)}):Play()
                --TokenCoulduwn = false
                v1 = false
                v2 = false
                Token:Destroy()
            end
        end)
    end
end

Remotes.TokenClient.OnClientEvent:Connect(AnimToken)

return TokenModule