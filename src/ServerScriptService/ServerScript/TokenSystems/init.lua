local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local Remotes = ReplicatedStorage:WaitForChild('Remotes')

local Data = require(ServerScriptService.ServerScript.Data)
local ModuleTable = require(ReplicatedStorage.Modules.ModuleTable)
local Utils = require(ReplicatedStorage.Libary.Utils)
local NofficalGame = require(ReplicatedStorage.Libary.NofficalGame)

local TokenSystems = {}

function TokenSystems:SpawnToken(Info)
        local v1 = true
        local v1Dop = true
        local TokenModule = ModuleTable.TokenTables.TokenDrop[Info.Token.Item]
        local Token = ReplicatedStorage.Assert.Token:Clone()
        Token.Type.Value = Info.Token.Type
        Token.Tokenimage.Color = TokenModule.ColorToken
        Token.PrimaryPart.Position = Vector3.new(Info.Position.X,-100,Info.Position.Z) 
        Token.Amount.Value = Info.Token.Amount
        Token.Item.Value = Info.Token.Item
        Token.Resourse.Value = Info.Resourse
        Token.Parent = workspace.Map.GameSettings.GameOnline.TokenFolder
        if Info.Token.Item == "Coin" then
            Token.Tokenimage.Decal1.Texture = TokenModule.Image
            Token.Tokenimage.Decal2.Texture = TokenModule.Image
        end
    
        Remotes.TokenClient:FireClient(Info.PlayerName,Token,Info)
    
        local function TouchedToken(hit)
            if game.Players:FindFirstChild(hit.Parent.Name) then
                local Player = game.Players:FindFirstChild(hit.Parent.Name)
                local TokenOld
                Token.DownColor.CanTouch = false
                if Player then
                    task.spawn(function()
                        task.wait(TokenModule.Coouldown-5)
                        v1 = true
                        v1Dop = true
                    end)
    
                    task.spawn(function() -- тут смотреть 
                        local PData = Data:Get(Player)
                        print('f')
                        if Token:FindFirstChild('Type').Value == "Drop" then
                            if Token:FindFirstChild('Item').Value == "Coin" then
                                if v1Dop then
                                    task.wait()
                                    v1Dop = false
                                    local AmountOfHoney = math.round(((Token.Amount.Value + math.random(10,25)) * PData.Boost.PlayerBoost["Honey From Tokens"] / 100))
                                    PData.IStats.Coin += AmountOfHoney
                                    coroutine.wrap(function()
                                        Remotes.Notify:FireClient(Player,"Blue","+"..AmountOfHoney.." "..Info.Token.Item)
                                    end)()
                                    PData.TotalItems.CoinTotal += AmountOfHoney
                                    PData.IStats.DailyHoney += AmountOfHoney
                                    PData:Update('IStats', PData.IStats)
                                    PData:Update('TotalItems', PData.TotalItems)
                                end
                                -- NofficalGame:NofficalCreate()
                            else
                                if v1 then
                                    v1 = false
                                    coroutine.wrap(function()
                                        Remotes.Notify:FireClient(Player,"Blue","+"..Info.Token.Amount.." "..Info.Token.Item)
                                    end)()
                                    if PData.Inventory[Token.Item.Value] == nil then
                                        PData.Inventory[Token.Item.Value] = Token.Amount.Value
                                    else
                                        PData.Inventory[Token.Item.Value] += Token.Amount.Value
                                    end
                                    PData:Update('Inventory', PData.Inventory)
                                end
                            end
    
                        elseif Token.Type.Value == "Boost" then
                            -- Fire in Boost
                        end
                    end)
    
                end
            end
        end
    
    
        Token.DownColor.Touched:Connect(TouchedToken)
    
end


return TokenSystems