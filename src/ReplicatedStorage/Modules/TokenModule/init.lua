local Player = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local PlayerGui = Player:WaitForChild('PlayerGui')
local TweenModule = require(ReplicatedStorage.Libary.TweenModule)
local RunService = game:GetService("RunService")
local NofficalGame = require(ReplicatedStorage.Libary.NofficalGame)

local Remotes = ReplicatedStorage:WaitForChild('Remotes')
local TokenCoulduwn = false
local TokenModule = {}



function AnimToken(Token,Info)
    local v1 = false
    local v2 = false
    local v3 = 0
    TweenModule:PositionToken(Token)
    repeat task.wait()
        if Token.PrimaryPart == nil then
            return nil
        end
    until Token.PrimaryPart ~= nil

    if Token and game.Players:FindFirstChild(Player.Name)  then -- Нужно придумать и решить проблему с позицией и FieldVars есть баг надо пофиксить
        TokenCoulduwn = true
        
        task.spawn(function()  -- Анимка крутилки
            repeat
                task.wait() --error
                if Token.PrimaryPart == nil then
                    return nil
                elseif Token.PrimaryPart ~= nil then
                    Token.PrimaryPart.CFrame = Token.PrimaryPart.CFrame * CFrame.Angles(0, math.rad(1), 0) 
               end
            until TokenCoulduwn == false
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

function AnimTokenServer(Token)
    local v1 = false
    local v2 = false
    local v3 = 0
    task.wait()
    if v1 == false and not v2 and v3 == 0 then
        v2 = true
        v1 = true
        v3 = 1
        TweenModule:OrientationToken(Token)
        TweenModule:TrasnparionToken(Token)
        task.wait(2)
        if Token.PrimaryPart ~= nil then
            TweenService:Create(Token.PrimaryPart,TweenInfo.new(2,Enum.EasingStyle.Elastic,Enum.EasingDirection.Out), {Position = Token.PrimaryPart.Position + Vector3.new(0,-15,0)}):Play()
            TweenService:Create(Token.Tokenimage,TweenInfo.new(2,Enum.EasingStyle.Elastic,Enum.EasingDirection.Out), {Position = Token.Tokenimage.Position + Vector3.new(0,-15,0)}):Play()
            TweenService:Create(Token.DownColor,TweenInfo.new(2,Enum.EasingStyle.Elastic,Enum.EasingDirection.Out), {Position = Token.DownColor.Position + Vector3.new(0,-15,0)}):Play()
            v1 = false
            v2 = false
            v3 = 0
            task.spawn(function()
                Token.DownColor.Transparency = 1
                Token.Tokenimage.Transparency = 1
                task.wait(2)
                Token:Destroy()
            end)
        end
        v2 = false
        v1 = false
        v3 = 0 
    end
end
Remotes.TokenClient2.OnClientEvent:Connect(AnimTokenServer)

Remotes.TokenClient.OnClientEvent:Connect(AnimToken)

return TokenModule