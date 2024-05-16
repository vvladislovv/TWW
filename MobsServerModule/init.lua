local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Remotes = ReplicatedStorage:WaitForChild('Remotes')
local ModuleTable = require(ReplicatedStorage.Modules.ModuleTable)
local ZonePlus = require(ReplicatedStorage.Zone)
local Data = require(ServerScriptService.ServerScript.Data)
--local Utils = require(ReplicatedStorage.Libary.Utils)
local FieldGame = require(ServerScriptService.ServerScript.FieldModule)
local TokenSystems = require(ServerScriptService.ServerScript.TokenSystems)
local MobsBilldingGui = ReplicatedStorage:WaitForChild('Assert').MobsBilldingGui
local Config = ReplicatedStorage:WaitForChild('Assert').Configuration
local FolderMobs = workspace.Map.GameSettings.GameOnline.PlayeMobs
local ModuleMobs = {}

function ModuleMobs:TimerMobs(Player,ZoneBarier)
    local PData = Data:Get(Player)
    if PData.TimerTable[ZoneBarier.Name] then
        for i, v2 in next, ZoneBarier:GetChildren() do
            if PData.TimerTable[ZoneBarier.Name][v2.Name].Time >= 0 then
                if v2.Mobs.Value then
                    task.wait()
                    if v2.Name == "Timer1" and not v2.Timer.Value then
                        --TweenService:Create(v2.BillboardGui, TweenInfo.new(1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Size = UDim2.new(3, 0,2, 0)}):Play()
                        v2.Timer.Value = true
                        local timerData = tonumber(PData.TimerTable[ZoneBarier.Name][v2.name].Time)
                        PData.TimerTable[ZoneBarier.Name][v2.name] = {Time = timerData + os.time()}
                        Remotes.MobsTimer:FireClient(Player,PData,ZoneBarier,v2)
                    elseif v2.Name == "Timer2" and not v2.Timer.Value then
                        --TweenService:Create(v2.BillboardGui, TweenInfo.new(1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Size = UDim2.new(3, 0,2, 0)}):Play()
                        v2.Timer.Value = true
                        local timerData = tonumber(PData.TimerTable[ZoneBarier.Name][v2.name].Time)
                        PData.TimerTable[ZoneBarier.Name][v2.name] = {Time = timerData + os.time()}
                        Remotes.MobsTimer:FireClient(Player,PData,ZoneBarier,v2)
                    elseif v2.Name == "Timer3" and not v2.Timer.Value then
                        TweenService:Create(v2.BillboardGui, TweenInfo.new(1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Size = UDim2.new(3, 0,2, 0)}):Play()
                        v2.Timer.Value = true
                        local timerData = tonumber(PData.TimerTable[ZoneBarier.Name][v2.name].Time)
                        PData.TimerTable[ZoneBarier.Name][v2.name] = {Time = timerData + os.time()}
                        Remotes.MobsTimer:FireClient(Player,PData,ZoneBarier,v2)
                    elseif v2.Name == "Timer4" and not v2.Timer.Value then
                        TweenService:Create(v2.BillboardGui, TweenInfo.new(1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Size = UDim2.new(3, 0,2, 0)}):Play()
                        v2.Timer.Value = true
                        local timerData = tonumber(PData.TimerTable[ZoneBarier.Name][v2.name].Time)
                        PData.TimerTable[ZoneBarier.Name][v2.name] = {Time = timerData + os.time()}
                        Remotes.MobsTimer:FireClient(Player,PData,ZoneBarier,v2)
                    elseif v2.Name == "Timer5" and not v2.Timer.Value then
                        TweenService:Create(v2.BillboardGui, TweenInfo.new(1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Size = UDim2.new(3, 0,2, 0)}):Play()
                        v2.Timer.Value = true
                        local timerData = tonumber(PData.TimerTable[ZoneBarier.Name][v2.name].Time)
                        PData.TimerTable[ZoneBarier.Name][v2.name] = {Time = timerData + os.time()}
                        Remotes.MobsTimer:FireClient(Player,PData,ZoneBarier,v2)
                        
                    end
                else
                    Remotes.MobsNoTimer:FireClient(Player,v2)
                   -- PData.TimerTable[ZoneBarier.Name][v2.name] = {Time = 200 + os.time()}
                end
            else
                Remotes.MobsNoTimer:FireClient(Player,v2)
            end
        end
    end
end

function MobsServer(Player)
    local PData = Data:Get(Player)
    local CollectTimer = 0

    for _, Zoneier in pairs(workspace.Map.GameSettings.FieldBarierMobs:GetChildren()) do
        for _, index in next, Zoneier:GetChildren() do
            if index:IsA('Attachment') then
                print(index.Name)
                if PData.BaseFakeSettings.FieldMods == Zoneier.Name then
                    CollectTimer += 1
                    local Timer2 = Zoneier["Pos"..CollectTimer].TimerName.Value
                    Timer2.Mobs.Value = false
                    Timer2.Timer.Value = false
                    print(CollectTimer)
                    ModuleMobs:CreateMobs(Player,Zoneier,CollectTimer)
                end
            end
        end
    end
end

local function CollisionMob(Mob)
    for _, v in next, Mob:GetDescendants() do
        if v:IsA('BasePart') then
            v.CollisionGroup = "Players"
        end
    end

end

function RToken(Field,Field)
    local Data = ModuleTable.MonstersTable[Field.Monster.Value].Reward
    local TotalWeight = 100
    
    local Chance = math.random(1, TotalWeight)
    local coun = 0

    for i,v in pairs(Data) do
        coun += v.Chance
        print(Chance)
        print(coun)
        if coun >= 100 then
            coun = 100
        end
        if coun >= Chance and i ~= "Battle Points" then
            print(v.Name)
            coun = 0
            return v.Name
        end
    end
end

function ModuleMobs.TokenSpawn(Player, RewardMobs,Field,FieldName,Mob,StartVector3, amountofitems,Arclength)
    local AngleBetweenInDegrees = 360/amountofitems
	local AngleBetweenInRad = math.rad(AngleBetweenInDegrees)
	local Radius = Arclength/AngleBetweenInRad +2
	local tab = {}
	local currentangle = 0  
	for num = 1, amountofitems do
		currentangle +=  AngleBetweenInRad
		local z = math.cos(currentangle)*Radius
		local x = math.sin(currentangle)*Radius
		local vector3 = StartVector3 + Vector3.new(x,0,z) -- Указать парт которые остаеться и это будет точка радиуса
		table.insert(tab,vector3)
		
		--local PartClone = ReplicatedStorage.Assert.Token:Clone()
		
		--TweenService:Create(PartClone, TweenInfo.new(1,Enum.EasingStyle.Linear, Enum.EasingDirection.In), {Transparency = 0}):Play()
        if ModuleTable.MonstersTable[Field.Monster.Value] then
            local RandomToken = RToken(FieldName,Field)
            if RandomToken ~= 1 then
                print(RandomToken)
                TokenSystems:SpawnToken({
                    PlayerName = Player,
                    Position = vector3,
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
	return tab
end

function ModuleMobs.GetRewards(Mob, Player, Field,SpawnMobs)
    local PData = Data:Get(Player)
    local FieldFormat = FieldGame.Correspondant[Field.Name]
    local Timer = Field["Pos"..SpawnMobs].TimerName.Value
    local RewardMobs = nil
    if Field.Pos1 ~= nil then
        PData.TimerTable[FieldFormat][Timer.Name] = {Time = ModuleTable.MonstersTable[Field.Monster.Value].SettingsMobs.Cooldown} -- Ставим время
        Timer.Mobs.Value = true
        --Timer.Timer.Value = true
        for i,v in next, workspace.Map.GameSettings.TimerMobs:GetChildren() do
            ModuleMobs:TimerMobs(Player,v)
        end
        local RewardNumber = 0
        local TokenRadios = 0
        for _,v in pairs(ModuleTable.MonstersTable[Field.Monster.Value].Reward) do
            if v ~= "Battle Points" then
                RewardNumber += 1
            end
        end
        RewardMobs = table.clone(ModuleTable.MonstersTable[Field.Monster.Value].Reward)
        --print(Mob)
        task.spawn(function()
            if RewardMobs ~= nil then
                if RewardNumber == 3 then
                    TokenRadios = 3
                    ModuleMobs.TokenSpawn(Player,RewardMobs,Field,FieldFormat,Mob, Mob.LowerTorso.Position, RewardNumber, TokenRadios)
                elseif RewardNumber >= 3 then
                    TokenRadios = 4
                    ModuleMobs.TokenSpawn(Player,RewardMobs,Field,FieldFormat,Mob, Mob.LowerTorso.Position, RewardNumber, TokenRadios)
                elseif RewardNumber >= 8 then
                    TokenRadios = 6
                    ModuleMobs.TokenSpawn(Player,RewardMobs,Field,FieldFormat,Mob, Mob.LowerTorso.Position, RewardNumber, TokenRadios)
                elseif RewardNumber <= 15 then
                    TokenRadios = 8
                    ModuleMobs.TokenSpawn(Player,RewardMobs,Field,FieldFormat,Mob, Mob.LowerTorso.Position, RewardNumber, TokenRadios)
                end
            end
        end)

    elseif Field.Pos1 ~= nil and Field.Pos2 ~= nil then
        PData.TimerTable[Field][Field.Pos1.TimerName.Value] = {Time = ModuleTable.MonstersTable[Field.Monster.Value].Cooldown + os.time()} -- Ставим время
        PData.TimerTable[Field][Field.Pos2.TimerName.Value] = {Time = ModuleTable.MonstersTable[Field.Monster.Value].Cooldown + os.time()} -- Ставим время
        Timer.Mobs.Value = true
        Timer.Timer.Value = true
        for i,v in next, workspace.Map.GameSettings.TimerMobs:GetChildren() do
            ModuleMobs:TimerMobs(Player,v)
        end
        local RewardNumber = 0
        local TokenRadios = 0
        for _,v in pairs(ModuleTable.MonstersTable[Field.Monster.Value].Reward) do
            if v ~= "Battle Points" then
                RewardNumber += 1
            end
        end
        RewardMobs = table.clone(ModuleTable.MonstersTable[Field.Monster.Value].Reward)

        task.spawn(function()
            if RewardMobs ~= nil then
                if RewardNumber == 3 then
                    TokenRadios = 3
                    ModuleMobs.TokenSpawn(Player,RewardMobs,FieldFormat,Mob, Mob.LowerTorso.Position, RewardNumber, TokenRadios)
                elseif RewardNumber >= 3 then
                    TokenRadios = 4
                    ModuleMobs.TokenSpawn(Player,RewardMobs,FieldFormat,Mob, Mob.LowerTorso.Position, RewardNumber, TokenRadios)
                elseif RewardNumber >= 8 then
                    TokenRadios = 6
                    ModuleMobs.TokenSpawn(Player,RewardMobs,FieldFormat,Mob, Mob.LowerTorso.Position, RewardNumber, TokenRadios)
                elseif RewardNumber <= 15 then
                    TokenRadios = 8
                    ModuleMobs.TokenSpawn(Player,RewardMobs,FieldFormat,Mob, Mob.LowerTorso.Position, RewardNumber, TokenRadios)
                end
            end
        end)
    end
end

function ModuleMobs.MobsAttack(Mob, Player, Field,NumberField) --! error
    local Character = game.Workspace:FindFirstChild(Player.Name)
    local PData = Data:Get(Player)
    local Distance = (Mob.UpperTorso.Position - Character.PrimaryPart.Position).Magnitude
    task.spawn(function()
        while FolderMobs:FindFirstChild(Player.Name) ~= nil do
            task.wait()
            if workspace:WaitForChild(Player.Name) and FolderMobs:FindFirstChild(Player.Name) ~= nil then
                local Character = workspace:FindFirstChild(Player.Name)
                if Distance > 6 then
                    repeat game:GetService('RunService').Heartbeat:Wait()
                        if FolderMobs:FindFirstChild(Player.Name) ~= nil then
                            Distance = (Mob:WaitForChild('HumanoidRootPart').Position - Character.PrimaryPart.Position).Magnitude
                            Mob.Humanoid:MoveTo(Character.PrimaryPart.Position) 
                        end
                    until Distance <= 3 or PData.BaseFakeSettings.MonsterZone == false
                    if FolderMobs:FindFirstChild(Player.Name) ~= nil and Mob.SpawnMobs.Value ~= nil then
                        Mob.Humanoid:MoveTo(Mob.HumanoidRootPart.Position)
                    end
                    if FolderMobs:FindFirstChild(Player.Name) ~= nil and Mob.SpawnMobs.Value ~= nil and Distance >= 3 then
                        Mob.Humanoid:MoveTo(Mob.SpawnMobs.Value.Position)
                    end
                    if FolderMobs:FindFirstChild(Player.Name) ~= nil then
                        Distance = (Mob.HumanoidRootPart.Position - Field.Pos1.SpawnMobs.Position).Magnitude
                    end
                    if Distance <= 6 and FolderMobs:FindFirstChild(Player.Name) ~= nil then --! не забыть поменять 
                        Mob:Destroy()
                        if FolderMobs ~= nil then
                            for i, Index in next, FolderMobs:GetChildren() do
                                Index:Destroy()
                                if NumberField == 1 then
                                    Field.Pos1.Spawn.Value = false
                                elseif NumberField > 1 then
                                    Field.Pos2.Spawn.Value = false
                                    Field.Pos1.Spawn.Value = false
                                end
                            end
                        end
                    end
                end
            end
            if Player.Character ~= nil and FolderMobs:FindFirstChild(Player.Name) ~= nil then
                if (Mob:WaitForChild('UpperTorso').Position - Player.Character.PrimaryPart.Position).Magnitude <= 5 and Mob.SpawnMobs.Value ~= nil then -- Возможна ошибка Player.Character.PrimaryPart == nil
                    task.wait(0.3)
                    Player.Character.Humanoid.Health -= ModuleTable.MonstersTable[Field.Monster.Value].SettingsMobs.Damage
                    Mob.Humanoid:MoveTo(Mob.SpawnMobs.Value.Position)
                    if NumberField == 1 then
                        Field.Pos1.Spawn.Value = false
                    elseif NumberField > 1 then
                        Field.Pos2.Spawn.Value = false
                        Field.Pos1.Spawn.Value = false
                    end
                end 
            end
        end
    end)
end

local function Configer(Player,Field,Mob)
    local Configuration = Config:Clone()
    Configuration.Parent = Mob
    Configuration.Player.Value = Player.Name
    print(Field.Monster.Value)
    Configuration.HP.Value = ModuleTable.MonstersTable[Field.Monster.Value].HP
    Configuration.MaxHP.Value = ModuleTable.MonstersTable[Field.Monster.Value].HP
    Configuration.Level.Value = ModuleTable.MonstersTable[Field.Monster.Value].Level
    return Configuration
end

function Test(Configuration)
    task.spawn(function()
        repeat task.wait(1)
            Configuration.HP.Value -= 5
        until Configuration.HP.Value == 0
    end)
end

local function Billboard(Mob,Field,Configuration)
    local BillboardGui = MobsBilldingGui:Clone() -- гугка по HP
    BillboardGui.Parent = Mob.ModelBag.Head
    BillboardGui.MobName.Text = Field.Monster.Value.." (Lvl "..Configuration.Level.Value..")"
    BillboardGui.Bar.TextLabel.Text = "HP:"..Configuration.MaxHP.Value
    BillboardGui.Bar.FB.Size = UDim2.new(1,0,1,0)
    BillboardGui.Name = "BG"
    BillboardGui.StudsOffsetWorldSpace = Vector3.new(0,Mob.PrimaryPart.Size.Y, 0)
    BillboardGui.AlwaysOnTop = true
    BillboardGui.MaxDistance = ModuleTable.MonstersTable[Field.Monster.Value].SettingsMobs.Dist * 1.5
    return BillboardGui
end

function ModuleMobs:CreateMobs(Player,Field,score) -- Посмотреть и решить проблему с появлением
    task.spawn(function()
        local PData = Data:Get(Player)
            if PData.BaseFakeSettings.FieldMods == Field.Name then
                for _, index in next, Field:GetChildren() do
                    if index:IsA('Attachment') then
                        print(score)
                        if index.Name == Field['Pos'..score].Name then
                            if Field.PosCollect.Value == 1 then -- *Просмотр сколько штук есть
                                if not Field['Pos'..score].Spawn.Value then -- Проблема, в том что нескольно 5 проверяет и из-за этого багуеться
                                    local FieldSpawn = 1
                                    local Timer = Field["Pos"..FieldSpawn].TimerName.Value
                                    local Mob
                                    if not FolderMobs:FindFirstChild(Player.Name) then -- Создаем папку для спавна монстра
                                        local Folder = Instance.new("Folder", FolderMobs)
                                        Folder.Name = Player.Name
                                    end
                
                                    repeat task.wait()
                                        if not Field['Pos'..FieldSpawn].Spawn.Value and not Timer.Mobs.Value then -- ! Если false то ставим в первую
                                            Field['Pos'..FieldSpawn].Spawn.Value = true
                                            Mob = ReplicatedStorage.Assert.Mobs:FindFirstChild(Field.Monster.Value):Clone()
                                            Mob.Name = Field.Monster.Value..FieldSpawn
                                            Mob.Parent = FolderMobs:FindFirstChild(Player.Name)
                                            CollisionMob(Mob)
                
                                            PData.BaseFakeSettings.Attack = true
                                            print(Field.Monster.Value)
                                            local Configuration = Configer(Player,Field,Mob)
                                    
                                            Billboard(Mob,Field,Configuration)
                
                                            Test(Configuration)
                                            ModuleMobs.MobsAttack(Mob, Player, Field,Field.PosCollect.Value)
                                            print(Field.Monster.Value)
                                            ModuleMobs.UpdateGui(Mob, Configuration, Player, Field,FieldSpawn)
                                            Mob:MoveTo(Field['Pos'..FieldSpawn].WorldPosition)
                                            Mob.SpawnMobs.Value = Field['Pos'..FieldSpawn].SpawnMobs -- Mob.SpawnMobs.Value = Field.Pos2.SpawnMobs2
                                            --FieldSpawn = 2
                                        end
                                    until Field['Pos'..FieldSpawn].Spawn.Value == true
                                    
                                end
                            elseif Field.PosCollect.Value > 1 then
                                if not Field['Pos'..score].Spawn.Value then -- Может быть баг
                                    local FieldSpawn = 1
                                    local Timer = Field["Pos"..FieldSpawn].TimerName.Value

                                    local Mob
                                    if not FolderMobs:FindFirstChild(Player.Name) then -- Создаем папку для спавна монстра
                                        local Folder = Instance.new("Folder", FolderMobs)
                                        Folder.Name = Player.Name
                                    end
                                    
                                    repeat task.wait()
                                        if not Field['Pos'..FieldSpawn].Spawn.Value and not Timer.Mobs.Value then -- ! Если false то ставим в первую
                                            Field['Pos'..FieldSpawn].Spawn.Value = true
                                            Mob = ReplicatedStorage.Assert.Mobs:FindFirstChild(Field.Monster.Value):Clone()
                                            Mob.Name = Field.Monster.Value..FieldSpawn
                                            Mob.Parent = FolderMobs:FindFirstChild(Player.Name)
                                            CollisionMob(Mob)
                
                                            PData.BaseFakeSettings.Attack = true
                                            print(Field.Monster.Value)
                                            local Configuration = Configer(Player,Field,Mob)
                                    
                                            Billboard(Mob,Field,Configuration)
                
                                            Test(Configuration)
                                            ModuleMobs.MobsAttack(Mob, Player, Field,Field.PosCollect.Value)
                                            print(Field.Monster.Value)
                                            ModuleMobs.UpdateGui(Mob, Configuration, Player, Field,FieldSpawn)
                                            Mob:MoveTo(Field['Pos'..FieldSpawn].WorldPosition)
                                            Mob.SpawnMobs.Value = Field['Pos'..FieldSpawn].SpawnMobs -- Mob.SpawnMobs.Value = Field.Pos2.SpawnMobs2
                                            FieldSpawn = 2
                                        elseif not Field['Pos'..FieldSpawn].Spawn.Value and not Timer.Mobs.Value then
                                            Mob = ReplicatedStorage.Assert.Mobs:FindFirstChild(Field.Monster.Value):Clone()
                                            Mob.Name = Field.Monster.Value..FieldSpawn
                                            Mob.Parent = FolderMobs:FindFirstChild(Player.Name)
                                            CollisionMob(Mob)
                
                                            PData.BaseFakeSettings.Attack = true
                
                                            local Configuration = Configer(Player,Field,Mob)
                                    
                                            Billboard(Mob,Field,Configuration)
                
                                            Test(Configuration)
                                            ModuleMobs.MobsAttack(Mob, Player, Field,Field.PosCollect.Value)
                                            print(Field.Monster.Value)
                                            ModuleMobs.UpdateGui(Mob, Configuration, Player, Field,FieldSpawn)
                                            Mob:MoveTo(Field['Pos'..score].WorldPosition)
                                            Mob.SpawnMobs.Value = Field['Pos'..FieldSpawn].SpawnMobs-- Mob.SpawnMobs.Value = Field.Pos1.SpawnMobs1
                                            Field['Pos'..FieldSpawn].Spawn.Value = true
                                        end
                                    until Field['Pos'..FieldSpawn].Spawn.Value == true and Field['Pos'..FieldSpawn].Spawn.Value == true
                                end
                            end
                        end
                    end 
                end
            end
    end)
end

function ModuleMobs.UpdateGui(Mob, Configuration, Player, Field, FieldSpawn)
    local SpawnMobs = 0
    Configuration.HP.Changed:Connect(function(Health)
        if Mob and Mob.PrimaryPart then
            Mob.ModelBag.Head:FindFirstChild("BG").Bar.TextLabel.Text = "HP:"..Health
            TweenService:Create(Mob.ModelBag.Head.BG.Bar.FB, TweenInfo.new(1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out), {Size = UDim2.new(Configuration.HP.Value / Configuration.MaxHP.Value, 0, 1, 0)}):Play()            
            if Health <= 0 then -- Если умер
                local PData = Data:Get(Player)
                if PData.BaseFakeSettings.Attack then
                    PData.BaseFakeSettings.Attack = false
                    for i,v in next, workspace.Map.GameSettings.TimerMobs:GetChildren() do
                        ModuleMobs:TimerMobs(Player,v)
                    end
                    if Mob.ModelBag.Head then
                        repeat task.wait()
                            for _, index in next, FolderMobs:GetChildren() do
                                SpawnMobs += 1
                                index[Field.Monster.Value..SpawnMobs].ModelBag.Head:FindFirstChild('BG').Enabled = false
                                for _, value in next, index[Field.Monster.Value..SpawnMobs].ModelBag:GetChildren() do
                                    TweenService:Create(value, TweenInfo.new(1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out), {Transparency = 1}):Play()                                                                        
                                end
                                ModuleMobs.GetRewards(index[Field.Monster.Value..SpawnMobs], Player, Field,SpawnMobs) -- Написать
                                task.wait(1)
                                index[Field.Monster.Value..SpawnMobs]:Destroy()
                            end
                        until Field.PosCollect.Value == SpawnMobs
                        if FolderMobs ~= nil then
                            for i, Index in next, FolderMobs:GetChildren() do
                                --task.wait(1)
                                if Index:GetChildren() == nil then
                                    Index:Destroy()
                                end
                                if Field.PosCollect.Value == 1 then
                                    Field.Pos1.Spawn.Value = false
                                elseif Field.PosCollect.Value > 1 then
                                    Field.Pos2.Spawn.Value = false
                                    Field.Pos1.Spawn.Value = false
                                end
                            end
                        end
                    end
                end
            end
        end
    end)
end

for _, Zoneier in pairs(workspace.Map.GameSettings.FieldBarierMobs:GetChildren()) do
    local score = 0
    local scoree = 0
    local Zone = ZonePlus.new(Zoneier)
    Zone.playerEntered:Connect(function(Player)
        local PData = Data:Get(Player)
        for i,ZoneBarier in pairs(workspace.Map.GameSettings.TimerMobs:GetChildren()) do
            if PData.TimerTable[ZoneBarier.Name] then
                for _,v2 in pairs(ZoneBarier:GetChildren()) do
                    score += 1
                end
                if PData.TimerTable[ZoneBarier.Name]['Timer'..score].Time <= 0 then
                    PData.BaseFakeSettings.MonsterZone = true
                    PData.BaseFakeSettings.FieldMods = Zoneier.Name
                    if PData.BaseFakeSettings.FieldMods == Zoneier.Name then
                        for _, index in next, Zoneier:GetChildren() do
                            if index:IsA('Attachment') then
                                scoree += 1
                                ModuleMobs:CreateMobs(Player,Zoneier,scoree)
                            end
                        end
                    end
                elseif PData.TimerTable[ZoneBarier.Name]['Timer'..score].Time >= 0 then
                    if PData.BaseFakeSettings.FieldMods == Zoneier.Name then
                        for i, index in next, Zoneier:GetChildren() do
                            if index:IsA('Attachment') then
                                scoree += 1
                                ModuleMobs:CreateMobs(Player,Zoneier,scoree)
                            end
                        end
                    end

                    PData.BaseFakeSettings.MonsterZone = true
                    ModuleMobs:TimerMobs(Player,ZoneBarier)
                    PData:Update('BaseFakeSettings', PData.BaseFakeSettings)
                end
            end
        end
    end)

    Zone.playerExited:Connect(function(Player)
        local PData = Data:Get(Player)
        score = 0
        scoree = 0
        PData.BaseFakeSettings.MonsterZone = false
        PData:Update('BaseFakeSettings', PData.BaseFakeSettings)
    end)
end

game.Players.PlayerAdded:Connect(function(Player)
    task.wait()
    local PData = Data:Get(Player)
    if not PData.Loaded then
        repeat task.wait() PData = Data:Get(Player) until PData.Loaded
    end
    for i,v in next, workspace.Map.GameSettings.TimerMobs:GetChildren() do
        if PData.TimerTable[v.Name] then
            for i,v2 in next, v:GetChildren() do
                if PData.TimerTable[v.Name][v2.Name].Time <= 0 then
                    task.spawn(function()
                        while true do
                            task.wait()
                            if PData.TimerTable[v.Name][v2.Name].Time >= 0 then
                                ModuleMobs:TimerMobs(Player,v)
                                break
                            end
                        end
                    end)
                    Remotes.MobsNoTimer:FireClient(Player,v2)
                else
                    --v2.BillboardGui.TextLabel.Text = Utils:FormatTime(PData.TimerTable[v.Name][v2.Name].Time)
                   ModuleMobs:TimerMobs(Player,v)
                end
            end
        end       
    end
end)

Remotes.ServerMobsNoffical.OnServerEvent:Connect(MobsServer)
return ModuleMobs