local EquipmentModule = {} do

    local PhysicsService = game:GetService("PhysicsService")
    local Player = game:GetService("Players")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local NofficalModule = require(ReplicatedStorage.Libary.NofficalGame)
    local Remote = ReplicatedStorage:WaitForChild("Remotes")
    local Items = ReplicatedStorage:FindFirstChild("Assert").ItemsFolder
    local Data = require(script.Parent.Data)

    function NoCollide(Model) -- Отключение колизии
        Model:WaitForChild("Humanoid")
        Model:WaitForChild('UpperTorso')
        Model:WaitForChild("HumanoidRootPart")
        Model:WaitForChild("Head")
        for _, value in pairs(Model:GetChildren()) do
            if value:IsA("BasePart") then
                value.CollisionGroup = "Players"
            end
        end
    end

    function EquipmentModule:LoadItems(Player, PData, Character)
        NoCollide(Character)
        local Humanoid = Character:FindFirstChild("Humanoid")
        EquipmentModule:EquipItemsGame(Character, "Boot", PData,Player)
        EquipmentModule:EquipItemsGame(Character, "Parachute", PData,Player)
        EquipmentModule:EquipItemsGame(Character, "RGuard", PData,Player)
        EquipmentModule:EquipItemsGame(Character, "LGuard", PData,Player)
        EquipmentModule:EquipItemsGame(Character, "Glove", PData,Player)
        EquipmentModule:EquipItemsGame(Character, "Hat", PData,Player)
        EquipmentModule:EquipItemsGame(Character, "Tool", PData,Player)
        EquipmentModule:EquipItemsGame(Character, "Bag", PData,Player)
        EquipmentModule:EquipItemsGame(Character, "Belt", PData,Player)


        Humanoid.Died:Connect(function()
            local Character = Player.CharacterAdded:Wait()
            local PData = Data:Get(Player)
            
            --! Оповищение, что рюкзак пуст
            PData.BaseSettings.Pollen = 0
            EquipmentModule:LoadItems(Player, PData, Character)
        end)
    end

    function EquipmentModule:StartSysmes()

        local PhysicsService = game:GetService("PhysicsService")
        local NofficalGame = require(ReplicatedStorage.Libary.NofficalGame)
        PhysicsService:RegisterCollisionGroup("Players")
        PhysicsService:CollisionGroupSetCollidable("Players", "Players", false)
        
        local function Collision(Character)
            for _, obj in next, Character:GetChildren() do
                if obj:IsA("BasePart") then
                    obj.CollisionGroup = "Players"
                end
            end
        end

        game.Players.PlayerAdded:Connect(function(Player)
            if Player.Character then -- Если есть(доп проверка)
                Collision(Player.Character)
            end

            Player.CharacterAdded:Connect(Collision)

            local Character = workspace:WaitForChild(Player.Name)
            local PData = Data:Get(Player)
            EquipmentModule:LoadItems(Player, PData, Character)
        end)
    end

    function EquipmentModule:EquipItemsGame(Character, TypeItem, PData,Player)
        local Humanoid = Character:WaitForChild("Humanoid")
        if PData.Equipment[TypeItem] then
            local ItemPData = PData.Equipment[TypeItem]
            local ItemObj1
            local ItemObj2
            if ItemPData ~= "" then
                if TypeItem == "Boot" then
                        if ItemPData ~= "" then
                            Remote.UItems:FireClient(Player,TypeItem)
                            ItemObj1 = Items:WaitForChild(TypeItem)[ItemPData.."L"]:Clone() 
                            ItemObj2 = Items:WaitForChild(TypeItem)[ItemPData.."R"]:Clone()
                            Humanoid:AddAccessory(ItemObj1)
                            Humanoid:AddAccessory(ItemObj2)
                            ItemObj1.Name = "BootL"
                            ItemObj2.Name = "BootR"
                            end
                    elseif TypeItem == "Glove" then
                        if ItemPData ~= "" then
                            Remote.UItems:FireClient(Player,TypeItem)
                            ItemObj1 = Items:WaitForChild(TypeItem)[ItemPData.."L"]:Clone()
                            ItemObj2 = Items:WaitForChild(TypeItem)[ItemPData.."R"]:Clone()
                            Humanoid:AddAccessory(ItemObj1)
                            Humanoid:AddAccessory(ItemObj2)
                            ItemObj1.Name = "GloveL"
                            ItemObj2.Name = "GloveR"
                            end
                        else

                        ItemObj1 = Items:WaitForChild(TypeItem)[ItemPData]:Clone() -- папки в RS с буквой S без этого не видно
                        print(ItemObj1)
                        if ItemObj1:IsA("Accessory") then					
                                for _,v in pairs(ItemObj1:GetChildren()) do
                                    if v:IsA("Part") or v:IsA("MeshPart") or v:IsA("Union") or v:IsA("BasePart") then
                                        v.Anchored = false
                                        v.CanCollide = false
                                        v.Massless = true
                                    end
                                end

                            if TypeItem == "Bag" then
                                ItemObj1.Name = "Bag"
                                Remote.UItems:FireClient(Player,TypeItem)
                                Humanoid:AddAccessory(ItemObj1)

                            elseif TypeItem == "Parachute" then
                                ItemObj1.Name = "Parachute"
                                Remote.UItems:FireClient(Player,TypeItem)
                                Humanoid:AddAccessory(ItemObj1)

                            elseif TypeItem == "Hat" then
                                ItemObj1.Name = "Hat"
                                Remote.UItems:FireClient(Player,TypeItem)
                                Humanoid:AddAccessory(ItemObj1)
                                
                            elseif TypeItem == "LGuard" then
                                ItemObj1.Name = "LGuard"
                                Remote.UItems:FireClient(Player,TypeItem)
                                Humanoid:AddAccessory(ItemObj1)
                            elseif TypeItem == "RGuard" then
                                ItemObj1.Name = "RGuard"
                                Remote.UItems:FireClient(Player,TypeItem)
                                Humanoid:AddAccessory(ItemObj1)
                                
                            elseif TypeItem == "Belt" then
                                ItemObj1.Name = "Belt"
                                Remote.UItems:FireClient(Player,TypeItem)
                                Humanoid:AddAccessory(ItemObj1)
                            elseif TypeItem == "Tool" then
                                ItemObj1.Name = "Tool"--PData.Equipment[TypeItem]
                                Remote.UItems:FireClient(Player,TypeItem)
                                --local CollectScript = game.ServerStorage.Tools:Clone()
                                --CollectScript.Parent = ItemObj1
                                Humanoid:AddAccessory(ItemObj1)
                            end
                        end
                end
            end
        end
    end

end


return EquipmentModule