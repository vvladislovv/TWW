local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remote = ReplicatedStorage:WaitForChild("Remotes")

local FlowerModule = {}

local Zone = require(ReplicatedStorage.Zone)
local TweenModule = require(ReplicatedStorage.Libary.TweenModule)

_G.PData = Remote.GetDataSave:InvokeServer()
_G.Field = Remote.GetField:InvokeServer()

function GetRotation(Character)
    local Orientation
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

    return Orientation
end

function FlowerModule:CollectFlower(Player, Args)
    local Character = workspace:FindFirstChild(Player.Name)
    local ModelStamp = ReplicatedStorage.FolderStamps[Args.Stamp]:Clone()
    ModelStamp.Parent = workspace.StampsWorksSpawn

    local hit : BasePart
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
                        if part.name == "Flower" then
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
            if part.Name == "Flower" then
                if not table.find(Flowers, part) then
                    table.insert(Flowers, part)
                    if Args.StatsMOD then
                        Remote.CollectField:FireServer(part, Args.HRP, nil, ModelStamp.PrimaryPart)
                    else
                        Remote.CollectField:FireServer(part, Args.HRP, nil, ModelStamp.PrimaryPart)

                    end
                    task.wait(0.1)
                    ModelStamp:Destroy()
                end
            end
        end)
    end
end

function FlowerModule:CollectType(Player, Flower, Position, StatsModule, Stamp)
   local Tabs : table
   Tabs[Player.Name] = {White = 0, Blue = 0, Honey = 0, Red = 0}

    if Flower and PData and (Flower.Position.Y - _G.Field.Flowers[Flower.FlowerID.Value].MinP) > 0.2 then
        local CanScoop = true
        if PData.BaseSettings.Pollen <= PData.BaseSettings.Capacity and CanScoop == true then
            local FlowerMod = _G.Field.Flowers[Flower.FlowerID.Value]
            local FieldName = _G.PData.BaseFakeSettings.FieldVars
            local Conversion = math.round(PData.AllStats[FlowerMod.Color.." Instant"] + PData.AllStats["Instant"])
            local Collected = StatsModule.Collecting
            local DecreaseAmount = StatsModule.Power
            local FieldName = PData.BaseFakeSettings.FieldVars 
            local FieldNameold = PData.BaseFakeSettings.FieldVarsOld
            local BadgeType = PData.Vars.Field.." Field"
			local P_BadgeType = PData.Badges[BadgeType]
            local HoneyCollected = 0
			local PollenCollected = 0

            if FieldNameold ~= "" then
                --Remote in server
				Collected *= _G.PData.Boost.PlayerBoost["Pollen"]/100
				Collected *= _G.PData.Boost.PlayerBoost[FlowerMod.Color.." Pollen"]/100
				Collected *= _G.PData.Boost.PlayerBoost[FieldNameold]/100
				if StatsModule.boot then
					Collected *= _G.PData.Boost.PlayerBoos["Movement Collection"]
				end
			end
			if FlowerMod.Color == StatsModule.Color then
				Collected *=  StatsModule.ColorMutltiplier
			end

            if FlowerMod.Stat == "2" then
				PollenCollected *= 1.5
				HoneyCollected *= 1.5
				if DecreaseAmount > 0 then
					DecreaseAmount /= 1.5
				end
			elseif FlowerMod.Stat == "3" then
				PollenCollected *= 2
				HoneyCollected *= 2
				if DecreaseAmount > 0 then
					DecreaseAmount /= 2
				end
			elseif FlowerMod.Stat == "4" then
				PollenCollected *= 2.5
				HoneyCollected *= 2.5
				if DecreaseAmount > 0 then
					DecreaseAmount /= 2.5
				end
			end
			--// Debs
			if Conversion > 100 then
				Conversion = 100
			end
			local Convert = math.round(Collected * (Conversion / 100))
			if PollenCollected < 0 then
				PollenCollected = 0
			elseif Convert < 0 then
				Convert = 0
			end

            HoneyCollected += Convert
			PollenCollected += math.round(Collected - Convert)
			
            
            Remote.FlowerDown:FireAllClients(Flower,Flower.Pos.Value)
            local CoinAdd = 0

            task.spawn(function()
                --server
				wait(0.005)
				if Tabs[Player.Name] then
					if _G.PData.Settings["Pollen Text"] == true then
						for i,v in pairs(Tabs[Player.Name]) do
							if v > 0 then
								VisualEvent:FireClient(Player, {Pos = Flower.Position + Vector3.new(0,6,0), Amount = v, Color = i, Crit = false})
							end
						end
					end
					Tabs[Player.Name] = {White = 0, Blue = 0, Honey = 0, Red = 0}
				end
			end)

            if (PData.IStats.Pollen + math.round(PollenCollected)) > PData.IStats.Capacity then
				PollenCollected = PData.IStats.Capacity - PData.IStats.Pollen
			end
			PData.IStats.Pollen += math.round(PollenCollected)
			PData.IStats.Honey += math.round(HoneyCollected)
			if Tabs[Player.Name] then
				Tabs[Player.Name][FlowerMod.Color] += math.round(PollenCollected)
				Tabs[Player.Name].Honey += math.round(HoneyCollected)
			end

        else
            _G.PData.BaseSettings.Pollen = PData.BaseSettings.Capacity
            --PData:Update('BaseSettings', PData.BaseSettings)
        end
    end
end

function FlowerModule:FlowerDown(Flower,DecAm)
    local FlowerPos = Flower.Position - Vector3.new(0,DecAm,0)
    TweenModule:FlowerDown(Flower,FlowerPos)
    Flower.ParticleEmitter.Enabled = true
    task.wait(0.4)
    Flower.ParticleEmitter.Enabled = false
end

function FlowerModule:RegenUp(Field : Instance)
    local InfoFieldGame = _G.Field[Field.Name]

    coroutine.wrap(function()
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
    end)()
end

task.spawn(function()
    task.wait()

    for _, Field in pairs(workspace.FieldsGame:GetChildren()) do
        FlowerModule:RegenUp(Field)
    end

end)

task.spawn(function()
    for _, v in next, workspace.FieldsGame:GetChildren() do
        local Zone = Zone.new(v)
        Zone.playerEntered:Connect(function(Player)
            _G.PData.BaseFakeSettings.FieldVars = v.Name
            _G.PData.BaseFakeSettings.FieldVarsOld = v.Name
            --[[PlayerGui:WaitForChild("UI").TextFieldLocation.Text = v.Name.." Field"
            if _G.PData.BaseFakeSettings.GuiField == false and _G.PData.BaseFakeSettings.FieldVarsOld ~= v.Name then
                _G.PData.BaseFakeSettings.GuiField = true
                _G.PData.BaseFakeSettings.FieldVarsOld = v.Name
                TweenService:Create(PlayerGui.UI.TextFieldLocation, TweenInfo.new(1, Enum.EasingStyle.Back,Enum.EasingDirection.Out), {Position = UDim2.new(0.33, 0,0.863, 0)}):Play()
                task.wait(3)
                TweenService:Create(PlayerGui.UI.TextFieldLocation, TweenInfo.new(2, Enum.EasingStyle.Back,Enum.EasingDirection.Out), {Position = UDim2.new(0.33, 0,2, 0)}):Play()
            end]]
        end)
    
        Zone.playerExited:Connect(function(Player)
            _G.PData.BaseFakeSettings.FieldVars = ""
            --TweenService:Create(PlayerGui.UI.TextFieldLocation, TweenInfo.new(2, Enum.EasingStyle.Back,Enum.EasingDirection.Out), {Position = UDim2.new(0.33, 0,2, 0)}):Play()
            task.wait(1.5)
            _G.PData.BaseFakeSettings.GuiField = false
        end)
    end
end)

return FlowerModule