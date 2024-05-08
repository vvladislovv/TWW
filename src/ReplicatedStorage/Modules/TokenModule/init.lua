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

    repeat task.wait()
        if Token.PrimaryPart == nil then
            return nil
        end
    until Token.PrimaryPart ~= nil
    if Token and game.Players:FindFirstChild(Player.Name)  then -- Нужно придумать и решить проблему с позицией и FieldVars есть баг надо пофиксить
        Token.PrimaryPart.Position = Info.Position
        Token.Tokenimage.Position = Info.Position
        Token.DownColor.Position = Info.Position
        TweenModule:PositionToken(Token)
        TokenCoulduwn = true
        
        task.spawn(function() -- Problems (Наверное надо поменять саму систему вращения)
            repeat
                task.wait() --error
                if Token.PrimaryPart == nil then
                    return nil
                elseif Token.PrimaryPart ~= nil then
                    Token.PrimaryPart.CFrame = Token.PrimaryPart.CFrame * CFrame.Angles(0, math.rad(1), 0) 
               end
            until TokenCoulduwn == false
        end)

        Token.PrimaryPart.Touched:Connect(function(hit)
            task.wait()
            repeat 
                if Token.PrimaryPart == nil and _G.PData.BaseFakeSettings.FieldVars ~= "" then return end
            until Token.PrimaryPart.Position ~= nil

            if v1 == false and not v2 and hit.Parent == Player.Character and v3 == 0 then
                v2 = true
                v1 = true
                v3 = 1

                TweenModule:OrientationToken(Token)
                TweenModule:TrasnparionToken(Token)

                task.wait(2)
                if Token.PrimaryPart ~= nil then
                    TweenService:Create(Token.PrimaryPart,TweenInfo.new(1.5,Enum.EasingStyle.Elastic,Enum.EasingDirection.Out), {Position = Token.PrimaryPart.Position + Vector3.new(0,-15,0)}):Play()
                    TweenService:Create(Token.Tokenimage,TweenInfo.new(1.5,Enum.EasingStyle.Elastic,Enum.EasingDirection.Out), {Position = Token.Tokenimage.Position + Vector3.new(0,-15,0)}):Play()
                    TweenService:Create(Token.DownColor,TweenInfo.new(1.5,Enum.EasingStyle.Elastic,Enum.EasingDirection.Out), {Position = Token.DownColor.Position + Vector3.new(0,-15,0)}):Play()
                    Token:Destroy()
                    v1 = false
                    v3 = 0 
                end
                v1 = false
                v3 = 0 
            end
        end)

        task.spawn(function()
            task.wait(15)
            v2 = false
            repeat
                task.wait() --error
                if Token.PrimaryPart == nil then
                    return nil
               end
            until Token.PrimaryPart ~= nil
            if not v2 and Token:FindFirstChild('Tokenimage') ~= nil then
                v2 = true
                TweenModule:TrasnparionToken(Token)
                task.wait(2)

                if Token.PrimaryPart ~= nil then
                    TweenModule:PositionToken(Token)
                    v1 = false
                    v2 = false
                    Token:Destroy() 
                end

                v1 = false
                v2 = false
            end
        end)
    end
end

Remotes.TokenClient.OnClientEvent:Connect(AnimToken)

return TokenModule