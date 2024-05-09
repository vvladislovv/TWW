-- надо дописать хрень которая отвечает за вывод цифр на экран
local TablePlayerFlower = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")
local TokensModule = require(game.ServerScriptService.ServerScript.TokenSystems)
local FieldGame = require(ServerScriptService.ServerScript.FieldModule)
local DataSave = require(ServerScriptService.ServerScript.Data)
local ZonePlus = require(game.ReplicatedStorage:WaitForChild('Zone'))
local Item = require(ReplicatedStorage.Modules.ModuleTable)
local Remote = ReplicatedStorage:WaitForChild('Remotes')
--print(TablePlayerFlower)
--PData = game.ReplicatedStorage.Remotes.GetDataSave:InvokeServer()

local FlowerCollect = {}

function RToken(Field)
    local Data = Item.FieldsDrop[Field]
    local TotalWeight = 0

    for i,v in pairs(Data) do
        TotalWeight += v.Rarity
    end
    
    local Chance = math.random(1, TotalWeight)
    local coun = 0

    for i,v in pairs(Data) do
        coun += v.Rarity
        if coun >= Chance then
            return v.Name
        end
    end
end

game.Players.PlayerRemoving:Connect(function(plr)
    TablePlayerFlower[plr.Name] = nil
end)

game.Players.PlayerAdded:Connect(function(plr)
    TablePlayerFlower[plr.Name] = {White = 0, Blue = 0, Coin = 0,  Pupler = 0}
end)


Remote.CollectField.OnServerEvent:Connect(function(Player, Flower, Position, StatsMOD, Stamp)
    local PData = DataSave:Get(Player)
    if Flower and PData and (Flower.Position.Y - FieldGame.Flowers[Flower.FlowerID.Value].MinP) > 0.2 then
        local CanScoop = true
        if PData.IStats.Pollen <= PData.IStats.Capacity and CanScoop == true then
            local Type = PData.Equipment.Tool
            local Crit = false
            local FieldName = PData.BaseFakeSettings.FieldVars
            local FColor = FieldGame.Flowers[Flower.FlowerID.Value].Color
            local FSize = FieldGame.Flowers[Flower.FlowerID.Value].Stat.Value
            local SS
            local DecAm
            local FoodAm


            local Percent = math.round(PData.Boost.PlayerBoost[FColor.." Instant"] + PData.Boost.PlayerBoost["Instant"])
            --print(Percent)
            if Percent > 100 then
                Percent = 100
            end

            if not StatsMOD then
                DecAm = Item.ItemsPlayer.Tools[Type].PowerTools
                SS = Item.ItemsPlayer.Tools[Type].Collecting
                DecAm /= tonumber(FSize)
                SS = math.round(SS * tonumber(FSize))
                if Item.ItemsPlayer.Tools[Type].ColorTools == FColor then -- Color * in Tools Сбор умножение 
                    DecAm *= Item.ItemsPlayer.Tools[Type].Stamp
                    SS *= Item.ItemsPlayer.Tools[Type].Stamp
                end

                if PData.BaseFakeSettings.FieldVars ~= "" then
                    FoodAm = math.round(SS * ((PData.Boost.PlayerBoost["Pollen"] / 100) * (PData.Boost.PlayerBoost[FColor.." Pollen"] / 100) * (PData.Boost.PlayerBoost["Pollen From Collectors"] / 100)))
                end
            else
                if StatsMOD["Color"] == "Pupler" then

                    if FColor == "Pupler" then
                        DecAm *= 1.5
                        SS *= 1.5
                    elseif FColor == "Blue" then
                        DecAm /= 1.5
                        SS /= 1.5
                    elseif FColor == "White" then
                        DecAm /= 1.5
                        SS /= 1.5
                    end
                    
                elseif StatsMOD["Color"] == "Blue" then

                    if FColor == "Blue" then
                        DecAm *= 1.5
                        SS *= 1.5
                    elseif FColor == "Pupler" then
                        DecAm /= 1.5
                        SS /= 1.5
                    elseif FColor == "White" then
                        DecAm /= 1.5
                        SS /= 1.5
                    end
                
                elseif StatsMOD["Color"] == "White" then

                    if FColor == "White" then
                        DecAm *= 1.5
                        SS *= 1.5
                    elseif FColor == "Pupler" then
                        DecAm /= 1.5
                        SS /= 1.5
                    elseif FColor == "Blue" then
                        DecAm /= 1.5
                        SS /= 1.5
                    end
                end
            end
            Remote.FlowerDown:FireAllClients(Flower,DecAm)
            local CoinAdd = 0

            if FoodAm ~= nil and Percent ~= nil then 
                local Convert = math.round(FoodAm * (Percent / 100))
                local PollenAdd = math.round(FoodAm - Convert)
                local CritRandom = math.random(1,100)
					if CritRandom <= PData.Boost.PlayerBoost["Critical Chance"] then
						Crit = true
						PollenAdd = math.round(PollenAdd * (PData.Boost.PlayerBoost["Critical Power"] / 100))
					end

                if PollenAdd < 0 then
                    PollenAdd = 0
                elseif Convert < 0 then
                    Convert = 0
                end

                CoinAdd += Convert
                
                local FieldGrant = math.random(1,500)
                if FieldGrant <= math.random(1,15) then
                    if Item.FieldsDrop[FieldName] then
                        local RandomToken = RToken(FieldName)
                        if RandomToken ~= nil then
                            TokensModule:SpawnToken({
                                PlayerName = Player,
                                Position = Flower.Position,
                                Cooldown = 15,
                                Token = {
                                    Item = RandomToken,
                                    Amount = 1,
                                    Type = "Drop",
                                },
                                Resourse = FieldName.." Field",
                            })
                        end
                    end
                end


                if TablePlayerFlower[Player.Name] ~= nil then
                    TablePlayerFlower[Player.Name][FColor] += PollenAdd
                    TablePlayerFlower[Player.Name].Coin += CoinAdd
                end

                task.spawn(function()
                    task.wait(0.001)
                    if TablePlayerFlower[Player.Name] ~= nil then
                        for i,v in pairs(TablePlayerFlower[Player.Name]) do
                                if v > 0 then
                                   Remote.VisualNumber:FireClient(Player, {Pos = Stamp, Amt = v, Color = i, Crit = Crit})
                                end
                            end

                            TablePlayerFlower[Player.Name].Coin = 0
                            TablePlayerFlower[Player.Name].Blue = 0
                            TablePlayerFlower[Player.Name].Pupler = 0
                            TablePlayerFlower[Player.Name].White = 0
                    end
                end)
                PData.IStats.Coin += math.round(CoinAdd)
                --PData:Update('IStats', PData.IStats)
                --print(PData)
                PData.TotalItems.CoinTotal += math.round(CoinAdd)
                PData.TotalItems.PollenTotal += math.round(PollenAdd)
               -- print(FColor)
                PData.TotalItems["Total"..FColor] += math.round(PollenAdd)
                PData.IStats.Pollen += math.round(PollenAdd)
                PData:Update('IStats', PData.IStats)
                PData:Update('TotalItems', PData.TotalItems)
            end
        else
            PData.IStats.Pollen = PData.IStats.Capacity
            PData:Update('IStats', PData.IStats)
        end
    end
end)

for _, FieldBarier in next, workspace.Map.GameSettings.FieldBarier:GetChildren() do
    local Zone = ZonePlus.new(FieldBarier)
    Zone.playerEntered:Connect(function(Player)
        local PData = DataSave:Get(Player)
        PData.BaseFakeSettings.FieldVars = FieldGame.Correspondant[FieldBarier.Name]
        PData.BaseFakeSettings.FieldVarsOld = FieldBarier.Name
        PData:Update('BaseFakeSettings', PData.BaseFakeSettings)
    end)

    Zone.playerExited:Connect(function(Player)
        local PData = DataSave:Get(Player)
        PData.BaseFakeSettings.FieldVars = ""
        PData:Update('BaseFakeSettings', PData.BaseFakeSettings)
    end)

end

return FlowerCollect