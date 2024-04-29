local FlowerModule = {} do
    local Player = game.Players.LocalPlayer
    local character = Player.Character or Player.CharacterAdded:Wait()
    local PlayerGui = Player:WaitForChild("PlayerGui")
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Remote = ReplicatedStorage:WaitForChild('Remotes')
    local TweenService = game:GetService("TweenService")
    local ZonePlus = require(game.ReplicatedStorage:WaitForChild('Zone'))
    local FieldExit = false
    local TweenModule = require(ReplicatedStorage.Libary.TweenModule)
    _G.PData = Remote.GetDataSave:InvokeServer()
    _G.Field = Remote.GetField:InvokeServer()
    
    require(script.BootsCollect):BootsCollectings(Player,character,FlowerModule)

    local TablePlayerFlower = {}
    local Item = require(ReplicatedStorage.Modules.ModuleTable)
    
    
    function GetRotation(Character)
        local Orientation 
            if Character then
                local HOrient = Character.PrimaryPart.Orientation
    
                if HOrient.Magnitude >= 50 and HOrient.Magnitude < 110 then
                    Orientation = CFrame.Angles(0, math.rad(90), 0)
                end
        
                if HOrient.Magnitude > -90 and HOrient.Magnitude < 90 then
                    Orientation = CFrame.Angles(0, math.rad(-90), 0)
                end
        
                if HOrient.Magnitude > 0 and HOrient.Magnitude < 50 then
                    Orientation = CFrame.Angles(0, math.rad(-180), 0)
                end
        
                if HOrient.Magnitude <= 110 and HOrient.Magnitude >= 180 then
                    Orientation = CFrame.Angles(0, math.rad(0), 0)
                end
        
                if HOrient.Magnitude > 110 and HOrient.Magnitude < 180 then
                    Orientation = CFrame.Angles(0, math.rad(0), 0)
                end
        
            end
        return Orientation
    end

    function FlowerModule:CollectFlower(Player, Args)
        local Character = workspace:FindFirstChild(Player.Name)
        local ModelStamp = ReplicatedStorage.Assert.FolderStamps[Args.StatsMOD.Stamp]:Clone()
        local CheckStamp = 0
        ModelStamp.Parent = workspace.Map.GameSettings.GameOnline.Stamps
    

        local hit = Instance.new("Part")
        hit.Name = "Hit"
        hit.CanCollide = false
        hit.Size = Vector3.new(0.1,0.1,0.1)
        hit.Parent = Args.HRP
        hit.Orientation = Args.HRP.Orientation
        hit.Transparency = 1
        hit.Anchored = false
        hit.Massless = true
        hit.Position = Args.HRP.Position + Args.Offset
    
        hit.Touched:Connect(function(Part)
            if Part.Name == "Flower" then
                
                task.spawn(function()
                    --local toolsSop = coroutine.create
                    if ModelStamp:IsA("Model") then
    
                        for _, Object in pairs(ModelStamp:GetChildren()) do
                            Object.Anchored = false
                        end
    
                        ModelStamp:SetPrimaryPartCFrame(CFrame.new(Part.Position) * GetRotation(Character))
                        task.wait(0.2)
                        
                        for _, Object in pairs(ModelStamp:GetChildren()) do
                            Object.Anchored = true
                        end
    
                        task.wait(0.1)
    
                        pcall(function()
                            ModelStamp:SetPrimaryPartCFrame(CFrame.new(Args.HRP.Position))
                        end)
                    else
                        ModelStamp.CFrame = CFrame.new(Part.Position) * GetRotation(Character)
                    end
                end)
            end
        end)
    
        hit.Position = hit.Position + Vector3.new(0, -2.48, 0)
        task.wait()
        hit:Destroy()
        
        local WoldHit = Instance.new("WeldConstraint", hit)
        WoldHit.Part0 = Args.HRP
        WoldHit.Part1 = hit
    
        local Flowers = {}
            if ModelStamp:IsA("Model") then
                for i, v in pairs(ModelStamp:GetChildren()) do
                    if v.Name ~= "Root" then
                        v.Touched:Connect(function(part)
                            if part.name == "Flower" and _G.PData.BaseFakeSettings.FieldVars ~= "" then
                                if not table.find(Flowers, part) then
                                    table.insert(Flowers, part)
                                    Remote.CollectField:FireServer(part, Args.HRP, nil, ModelStamp.PrimaryPart)
                                    task.wait(0.1)
                                    ModelStamp:Destroy()
                                end
                            end
                        end)
                    end
                end
            else
    
            ModelStamp.Touched:Connect(function(part)
                if part.Name == "Flower" and _G.PData.BaseFakeSettings.FieldVars ~= "" then
                    if not table.find(Flowers, part) then
                        table.insert(Flowers, part)
                        if Args.StatsMOD then
                            Remote.CollectField:FireServer(part, Args.HRP, nil, ModelStamp.Position)
                        else
                            Remote.CollectField:FireServer(part, Args.HRP, nil, ModelStamp.Position)
                        end
                        task.wait(0.1)
                        ModelStamp:Destroy()
                    end
                end
            end)
        end
    end

    function FlowerModule:RegenUp(Field : Instance)
        local InfoFieldGame = _G.Field[Field.Name]
        task.spawn(function()
            while Field do task.wait(5)
                for i, Pollen in pairs(Field:GetChildren()) do
                    if Pollen:IsA("BasePart") then
                    InfoFieldGame = _G.Field.Flowers[Pollen.FlowerID.Value]
                        if Pollen.Position.Y < InfoFieldGame.MaxP then
                            local ToMaxFlower = tonumber(InfoFieldGame.MaxP - Pollen.Position.Y)
                            local FlowerPos = Pollen.Position + Vector3.new(0, ToMaxFlower, 0)
                            local FlowerPosTime = Pollen.Position + Vector3.new(0,InfoFieldGame.RegenFlower,0)
                            TweenModule:RegenUp(Pollen,ToMaxFlower,InfoFieldGame,FlowerPos,FlowerPosTime)
                        end
                    end 
                end
            end
        end)
    end
    
    Remote.FlowerDown.OnClientEvent:Connect(function(Flower,DecAm)
        local FlowerPos = Flower.Position - Vector3.new(0,DecAm,0)
        TweenModule:FlowerDown(Flower,FlowerPos)
        Flower.ParticleEmitter.Enabled = true
        task.wait(0.25)
        Flower.ParticleEmitter.Enabled = false
    end)

    for _, Field in next, workspace.Map.GameSettings.Fields:GetChildren() do
        FlowerModule:RegenUp(Field)
    end

end

return FlowerModule