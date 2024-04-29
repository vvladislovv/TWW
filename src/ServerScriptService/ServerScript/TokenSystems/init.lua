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
    print(Info)
    local TokenModule = ModuleTable.TokenTables.TokenDrop[Info.Token.Item]
    local Token = ReplicatedStorage.Assert.Token:Clone()
    Token.Type.Value = Info.Token.Type
    Token.Tokenimage.Color = TokenModule.ColorToken
    Token.Amount.Value = Info.Token.Amount
    Token.Item.Value = Info.Token.Item
    Token.Resourse.Value = Info.Resourse
    Token.Parent = workspace.Map.GameSettings.GameOnline.TokenFolder

    if Info.Token.Item == "Coin" then
        Token.Tokenimage.Decal1.Texture = TokenModule.Image
        Token.Tokenimage.Decal2.Texture = TokenModule.Image
    end
    Remotes.TokenClient:FireAllClients(Token,Info)
    local function TouchedToken(hit)
        if game.Players:FindFirstChild(hit.Parent.Name) then
            local Player = game.Players:FindFirstChild(hit.Parent.Name)
            Token.DownColor.CanTouch = false
            if Player then
                task.spawn(function()
                    local PData = Data:Get(Player)
                    if Token:FindFirstChild('Type').Value == "Drop" then
                        if Token:FindFirstChild('Item') == "Coin" then
                            local AmountOfHoney = math.round(((Token.Amount.Value + math.random(100,500)) * PData.Boost.PlayerBoost["Honey From Tokens"] / 100))
                            PData.BaseSettings["Coin"] += AmountOfHoney
                            PData.TotalItems["CoinTotal"] += AmountOfHoney
                            PData.BaseSettings["DailyHoney"] += AmountOfHoney
                            -- NofficalGame:NofficalCreate()
                        else
                            PData.Inventory[Token.Item.Value] += Token.Amount.Value
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