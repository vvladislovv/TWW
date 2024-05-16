local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Remotes = ReplicatedStorage:WaitForChild('Remotes')
local ModuleTable = require(ReplicatedStorage.Modules.ModuleTable)
local Data = require(ServerScriptService.ServerScript.Data)

local MobsBilldingGui = ReplicatedStorage:WaitForChild('Assert').MobsBilldingGui
local Config = ReplicatedStorage:WaitForChild('Assert').Configuration
local FolderMobs = workspace.Map.GameSettings.GameOnline.PlayeMobs

local CreateMob = {}

function CollisionMob(Mob)
    for _, v in next, Mob:GetDescendants() do
        if v:IsA('BasePart') then
            v.CollisionGroup = "Players"
        end
    end
end

function Configer(Player,Field,Mob)
    local Configuration = Config:Clone()
    Configuration.Parent = Mob
    Configuration.Player.Value = Player.Name
    Configuration.HP.Value = ModuleTable.MonstersTable[Field.Monster.Value].HP
    Configuration.MaxHP.Value = ModuleTable.MonstersTable[Field.Monster.Value].HP
    Configuration.Level.Value = ModuleTable.MonstersTable[Field.Monster.Value].Level
    return Configuration
end

function Billboard(Mob,Field,Configuration)
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

function MobsCreatServer(Player)
    local PData = Data:Get(Player)
    local CollectTimers = 0
    for _, Zoneier in pairs(workspace.Map.GameSettings.FieldBarierMobs:GetChildren()) do
        if PData.TimerTable.Field[Zoneier.Name] then
            PData.BaseFakeSettings.FieldMods = Zoneier.Name
            for _, Index in Zoneier:GetChildren() do
                if Index:IsA('BasePart') then
                    CollectTimers += 1 -- ! ТУТ 3  НАДО РЕШИТЬ
                    print(CollectTimers)
                    local FieldData = PData.TimerTable.Field[Zoneier.Name]
                    if FieldData[Index.Name] ~= nil then
                        CreateMob:CreatersMobsField(Player,Zoneier,CollectTimers)
                    end
                end 
            end
        end
    end
    CollectTimers = 0
end

function Test(Configuration)
    task.spawn(function()
        repeat task.wait(1)
            Configuration.HP.Value -= 5
        until Configuration.HP.Value == 0
    end)
end

function CreateMob:UpdateConfiger(Player,Mob,Configuration,Field)
    local PData = Data:Get(Player)
    local SpawnMobs = 0
    local SpawnMobsMax = 0
    for _, index in next, Field:GetChildren() do
        if index:IsA('BasePart') then
            SpawnMobsMax += 1
        end
    end

    Configuration.HP.Changed:Connect(function(Health)
        Mob.ModelBag.Head:FindFirstChild("BG").Bar.TextLabel.Text = "HP:"..Health
        TweenService:Create(Mob.ModelBag.Head.BG.Bar.FB, TweenInfo.new(1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out), {Size = UDim2.new(Configuration.HP.Value / Configuration.MaxHP.Value, 0, 1, 0)}):Play()            
        
        if Health <= 0 then
            if PData.BaseFakeSettings.Attack then
                PData.BaseFakeSettings.Attack = false
                if Mob.ModelBag.Head then

                    repeat task.wait()
                        for _, index in next, FolderMobs:GetChildren() do
                            SpawnMobs += 1
                            index[Field.Monster.Value..SpawnMobs].ModelBag.Head:FindFirstChild('BG').Enabled = false
                            for _, value in next, index[Field.Monster.Value..SpawnMobs].ModelBag:GetChildren() do
                                TweenService:Create(value, TweenInfo.new(1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out), {Transparency = 1}):Play()                                                                        
                            end 
                                Field['Pos'..SpawnMobs].Spawn.Value = false
                                --ModuleMobs.GetRewards(index[Field.Monster.Value..SpawnMobs], Player, Field,SpawnMobs) -- Написать
                                require(script.Parent.RewardsMob):GetReward(Player, index[Field.Monster.Value..SpawnMobs], Field, SpawnMobs)
                            task.wait(1)
                            index[Field.Monster.Value..SpawnMobs]:Destroy()
                        end
                    until SpawnMobsMax == SpawnMobs

                    if FolderMobs ~= nil then
                        for i, Index in next, FolderMobs:GetChildren() do
                            if Index:GetChildren() == nil then
                                Index:Destroy()
                            end
                        end
                    end

                end
            end
        end
    end)
end

function CreateMob:CreatersMobsField(Player,Field,CollectTimers)
    local PData = Data:Get(Player)
    if not Field['Timer'..CollectTimers].TimerStart.Value then
        if not FolderMobs:FindFirstChild(Player.Name) then -- Создаем папку для спавна монстра
            local Folder = Instance.new("Folder", FolderMobs)
            Folder.Name = Player.Name
        end

        if not Field['Pos'..CollectTimers].Spawn.Value then
            Field['Pos'..CollectTimers].Spawn.Value = true
    
            local Mob = ReplicatedStorage.Assert.Mobs:FindFirstChild(Field.Monster.Value):Clone()
            Mob.Name = Field.Monster.Value..CollectTimers
            Mob.Parent = FolderMobs:FindFirstChild(Player.Name)

            for _, index in next, FolderMobs:GetChildren() do
                for _, value in next, index[Field.Monster.Value..CollectTimers].ModelBag:GetChildren() do
                    TweenService:Create(value, TweenInfo.new(1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out), {Transparency = 0}):Play()                                                                        
                end
            end

            CollisionMob(Mob)
            local Configuration = Configer(Player,Field,Mob)
            Billboard(Mob,Field,Configuration)
            Test(Configuration)
            
            PData.BaseFakeSettings.Attack = true

            Mob:MoveTo(Field['Pos'..CollectTimers].WorldPosition)
            Mob.SpawnMobs.Value = Field['Pos'..CollectTimers].SpawnMobs

            CreateMob:UpdateConfiger(Player,Mob,Configuration,Field)
        end
       -- CollectTimers = 0
    end
end

Remotes.ServerMobsNoffical.OnServerEvent:Connect(MobsCreatServer)
return CreateMob