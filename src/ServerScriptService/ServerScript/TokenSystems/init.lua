local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local Remotes = ReplicatedStorage:WaitForChild('Remotes')

local Data = require(ServerScriptService.ServerScript.Data)
local ModuleTable = require(ReplicatedStorage.Modules.ModuleTable)
local Utils = require(ReplicatedStorage.Libary.Utils)
local NofficalGame = require(ReplicatedStorage.Libary.NofficalGame)
local TweenModule = require(ReplicatedStorage.Libary.TweenModule)

local TokenSystems = {}
local TableNofi = {}

function TokenSpawn(Info,TokenModule) -- решить тут проблему
    task.wait(0.3)
    local Token = ReplicatedStorage.Assert.Token:Clone()
    Token.Type.Value = Info.Token.Type
    Token.Tokenimage.Color = TokenModule.ColorToken
    Token.PrimaryPart.Position = Vector3.new(Info.Position.X,-100,Info.Position.Z) 
    Token.Amount.Value = Info.Token.Amount
    Token.Item.Value = Info.Token.Item
    Token.DownColor.Highlight.Enabled = true
    Token.Resourse.Value = Info.Resourse
    Token.Parent = workspace.Map.GameSettings.GameOnline.TokenFolder

    if Info.Token.Item == "Coin" then
        Token.Tokenimage.Decal1.Texture = TokenModule.Image
        Token.Tokenimage.Decal2.Texture = TokenModule.Image
    end

    Token.PrimaryPart.Position = Info.Position
    Token.Tokenimage.Position = Info.Position
    Token.DownColor.Position = Info.Position
    return Token
end

function TokenType(Token,Info,PData,Player)
    local v1Dop = true
    local v1 = true
    if Token:FindFirstChild('Type') ~= nil then
        if Token:FindFirstChild('Type').Value == "Drop" then
            if Token:FindFirstChild('Item').Value == "Coin" then
                if v1Dop then
                    v1Dop = false
                    local AmountOfHoney = math.round(((Token.Amount.Value + math.random(10,25)) * PData.Boost.PlayerBoost["Honey From Tokens"] / 100))

                    coroutine.wrap(function()
                        if TableNofi[Info.Token.Item] ~= nil then
                            TableNofi[Info.Token.Item].Amount += AmountOfHoney
                            TableNofi[Info.Token.Item].Time = os.time() + 10
                        else
                            TableNofi[Info.Token.Item] = {}
                            TableNofi[Info.Token.Item].Amount = AmountOfHoney
                            TableNofi[Info.Token.Item].Time = os.time() + 10
                        end
                        Remotes.Notify:FireClient(Player,"Orange","+"..TableNofi[Info.Token.Item].Amount.." "..Info.Token.Item,true,Info.Token.Item,TableNofi)
                    end)()

                    PData.IStats.Coin += AmountOfHoney
                    --print(AmountOfHoney)
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

                        if TableNofi[Info.Token.Item] ~= nil then
                            TableNofi[Info.Token.Item].Amount += Info.Token.Amount
                            TableNofi[Info.Token.Item].Time = os.time() + 10
                        else
                            TableNofi[Info.Token.Item] = {}
                            TableNofi[Info.Token.Item].Amount = Info.Token.Amount
                            TableNofi[Info.Token.Item].Time = os.time() + 10

                        end
                        Remotes.Notify:FireClient(Player,"Blue","+"..TableNofi[Info.Token.Item].Amount.." "..Info.Token.Item,true,Info.Token.Item, TableNofi)
                    end)()
                    if PData.Inventory[Token.Item.Value] == nil then
                        PData.Inventory[Token.Item.Value] = Token.Amount.Value
                    else
                        PData.Inventory[Token.Item.Value] += Token.Amount.Value
                    end
                    PData:Update('Inventory', PData.Inventory)
                end
            end
            task.spawn(function()
                while true do
                    task.wait()
                    if TableNofi[Info.Token.Item].Time == os.time() then
                        TableNofi[Info.Token.Item].Amount = 0
                        TableNofi[Info.Token.Item].Time = os.time()
                        Remotes.DestroyFrameNoffical:FireClient(Player,Info.Token.Item)
                        break
                    end
                end
            end)
        elseif Token.Type.Value == "Boost" then
            -- Fire in Boost
        end

    end
end

function TokenSystems:SpawnToken(Info) -- сделать булевую переменную и реагировать на не
    local TokenModule = ModuleTable.TokenTables.TokenDrop[Info.Token.Item]
    local Token = TokenSpawn(Info,TokenModule)
    Remotes.TokenClient:FireAllClients(Token,Info,TokenModule)

    Token.DownColor.Touched:Connect(function(hit)
        if game.Players:FindFirstChild(hit.Parent.Name) then
            local Player = game.Players:FindFirstChild(hit.Parent.Name)
            Token.DownColor.CanTouch = false
            if Player then
                local PData = Data:Get(Player)
                Remotes.TokenClient2:FireAllClients(Token)
                --task.wait(TokenModule.Coouldown-5)
                task.spawn(function() -- тут смотреть
                    TokenType(Token,Info,PData,Info.PlayerName)
                end)
            end
        end
    end)
end



return TokenSystems