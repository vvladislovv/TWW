local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Remotes = ReplicatedStorage:WaitForChild('Remotes')
local ModuleTable = require(ReplicatedStorage.Modules.ModuleTable)
local ZonePlus = require(ReplicatedStorage.Zone)
local Data = require(ServerScriptService.ServerScript.Data)
local FieldGame = require(ServerScriptService.ServerScript.FieldModule)
local Utils = require(ReplicatedStorage.Libary.Utils)
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
                        TweenService:Create(v2.BillboardGui, TweenInfo.new(1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Size = UDim2.new(3, 0,2, 0)}):Play()
                        v2.Timer.Value = true
                        local timerData = tonumber(PData.TimerTable[ZoneBarier.Name][v2.name].Time)
                        PData.TimerTable[ZoneBarier.Name][v2.name] = {Time = timerData + os.time()}
                        Remotes.MobsTimer:FireClient(Player,PData,ZoneBarier,v2)
                    elseif v2.Name == "Timer2" and not v2.Timer.Value then
                        TweenService:Create(v2.BillboardGui, TweenInfo.new(1,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),{Size = UDim2.new(3, 0,2, 0)}):Play()
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

function ModuleMobs:GetRewards()
    
end

local function CollisionMob(Mob)
    for _, v in next, Mob:GetDescendants() do
        if v:IsA('BasePart') then
            v.CollisionGroup = "Players"
        end
    end

end

function ModuleMobs.MobsAttack(Mob, Player, Field)
    local Character = game.Workspace:FindFirstChild(Player.Name)
    local PData = Data:Get(Player)
    local Distance = (Mob.UpperTorso.Position - Character.PrimaryPart.Position).Magnitude

    task.spawn(function()
        while true do
            task.wait()
            if workspace:WaitForChild(Player.Name) then
                local Character = workspace:FindFirstChild(Player.Name)
                if Distance > 6 then
                    repeat game:GetService('RunService').Heartbeat:Wait()
                        Distance = (Mob:WaitForChild('HumanoidRootPart').Position - Character.PrimaryPart.Position).Magnitude
                        Mob.Humanoid:MoveTo(Character.PrimaryPart.Position)
                    until Distance <= 6 or PData.BaseFakeSettings.MonsterZone == false

                    Mob.Humanoid:MoveTo(Mob.HumanoidRootPart.Position)

                    if Mob.SpawnMobs.Value ~= nil then
                        Mob.Humanoid:MoveTo(Mob.SpawnMobs.Value.Position)
                    end
                    
                    Distance = (Mob.HumanoidRootPart.Position - Field.Pos1.SpawnMobs1.Position).Magnitude
                    if Distance <= 10 then
                        Mob:Destroy()
                        if FolderMobs ~= nil then
                            for i, Index in next, FolderMobs:GetChildren() do
                                Index:Destroy()
                                Field.Pos2.Spawn.Value = false
                                Field.Pos1.Spawn.Value = false
                            end
                        end
                    end
                end
            end

            if (Mob:WaitForChild('UpperTorso').Position - Player.Character.PrimaryPart.Position).Magnitude <= 5 then
                task.wait(0.3)
                Player.Character.Humanoid.Health -= ModuleTable.MonstersTable[Mob.Name].SettingsMobs.Damage
                Mob.Humanoid:MoveTo(Mob.SpawnMobs.Value.Position)
                Field.Pos2.Spawn.Value = false
                Field.Pos1.Spawn.Value = false
            end

        end
    end)


end

function ModuleMobs:CreateMobs(Player,Field)
    task.spawn(function()
        local PData = Data:Get(Player)
        for i, index in next, Field:GetChildren() do
            print(index)
			if index.Name == "Pos1" or index.Name == "Pos2"  then -- *Просмотр сколько штук есть
                if not Field.Pos2.Spawn.Value and not Field.Pos1.Spawn.Value then -- Проблема, в том что нескольно 5 проверяет и из-за этого багуеться
                    local Mob = ReplicatedStorage.Assert.Mobs:FindFirstChild(Field.Monster.Value):Clone()
                    CollisionMob(Mob)
                    if not FolderMobs:FindFirstChild(Player.Name) then -- Создаем папку для спавна монстра
                        local Folder = Instance.new("Folder", FolderMobs)
                        Folder.Name = Player.Name
                    end
                
                PData.BaseFakeSettings.Attack = true
    
                local Configuration = Config:Clone()
                Configuration.Parent = Mob
                Configuration.Player.Value = Player.Name
                Configuration.HP.Value = ModuleTable.MonstersTable[Mob.Name].HP
                Configuration.MaxHP.Value = ModuleTable.MonstersTable[Mob.Name].HP
                Configuration.Level.Value = ModuleTable.MonstersTable[Mob.Name].Level
    
                Mob.Parent = FolderMobs:FindFirstChild(Player.Name)
                print(Field)
                if not Field.Pos1.Spawn.Value then -- ! Если false то ставим в первую
                    print('fff')
                    Mob:MoveTo(Field:FindFirstChild("Pos1").WorldPosition)
                    Mob.SpawnMobs.Value = Field.Pos1.SpawnMobs1 -- Mob.SpawnMobs.Value = Field.Pos2.SpawnMobs2
                    Field.Pos1.Spawn.Value = true
                elseif not Field.Pos2.Spawn.Value then
                    print('fff')
                    Mob:MoveTo(Field:FindFirstChild("Pos2").WorldPosition)
                    Mob.SpawnMobs.Value = Field.Pos2.SpawnMobs2 -- Mob.SpawnMobs.Value = Field.Pos1.SpawnMobs1
                    Field.Pos2.Spawn.Value = true
                end
    
                local BillboardGui = MobsBilldingGui:Clone() -- гугка по HP
                BillboardGui.Parent = Mob.PrimaryPart
                BillboardGui.MobName.Text = Mob.Name.." (Lvl "..Configuration.Level.Value..")"
                BillboardGui.Bar.TextLabel.Text = "HP:"..Configuration.MaxHP.Value
                BillboardGui.Bar.FB.Size = UDim2.new(1,0,1,0)
                BillboardGui.Name = "BG"
                BillboardGui.StudsOffsetWorldSpace = Vector3.new(0,Mob.PrimaryPart.Size.Y, 0)
                BillboardGui.AlwaysOnTop = true
                BillboardGui.MaxDistance = ModuleTable.MonstersTable[Mob.Name].SettingsMobs.Dist * 1.5
    
                ModuleMobs.MobsAttack(Mob, Player, Field) -- Аттака на игрока
    
                ModuleMobs.UpdateGui(Mob, Configuration, Player, Field) 
    
                end
            end
        end
    end)
end

function ModuleMobs.UpdateGui(Mob, Configuration, Player, Field)
    Configuration.HP.Changed:Connect(function(Health)
        if Mob and Mob.PrimaryPart then
            Mob.PrimaryPart:FindFirstChild("BG").Bar.TextLabel.Text = "HP:"..Health
            Mob.PrimaryPart:FindFirstChild("BG").Bar.FB.Size = UDim2.new(Configuration.HP.Value / Configuration.MaxHP.Value,0,1,0)
            
            if Health <= 0 then -- Если умер
                local PData = Data:Get(Player)
                if PData.BaseFakeSettings.Attack then
                    PData.BaseFakeSettings.Attack = false
                    ModuleMobs.GetRewards(Mob, Player, Field) -- Написать

                    --Mob:FindFirstChild('PositionObj'):Destroy()
                    if Mob.PimaryPart then
                        Mob.PimaryPart:FindFirstChild('BG').Enabled = false
                    end
                    task.wait(0.5)
                    Mob:Destroy()
                end
            end
        end
    end)
end

for _, Zoneier in next, workspace.Map.GameSettings.FieldBarierMobs:GetChildren() do
    local Zone = ZonePlus.new(Zoneier)
    Zone.playerEntered:Connect(function(Player)
        local PData = Data:Get(Player)
        for i,ZoneBarier in next, workspace.Map.GameSettings.TimerMobs:GetChildren() do
            if PData.TimerTable[ZoneBarier.Name] then
                for i,v2 in next, ZoneBarier:GetChildren() do
                    if PData.TimerTable[ZoneBarier.Name][v2.Name].Time <= 0 then
                        PData.BaseFakeSettings.MonsterZone = true
                        PData.BaseFakeSettings.FieldMods = FieldGame.Correspondant[ZoneBarier.Name]
                        if PData.TimerTable[ZoneBarier.Name][v2.Name].Time - os.time() <= 0 then
                            ModuleMobs:CreateMobs(Player,Zoneier)
                        end
                    elseif PData.TimerTable[ZoneBarier.Name][v2.Name].Time >= 0 then
                        PData.BaseFakeSettings.MonsterZone = true
                        ModuleMobs:TimerMobs(Player,ZoneBarier)
                        PData:Update('BaseFakeSettings', PData.BaseFakeSettings)
                    end
                end
            end
        end
    end)

    Zone.playerExited:Connect(function(Player)
        local PData = Data:Get(Player)
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
--ModuleMobs:TimerMobs()


return ModuleMobs