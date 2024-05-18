local ServerScriptService = game:GetService("ServerScriptService")
local TweenService = game:GetService("TweenService")

local Data = require(ServerScriptService.ServerScript.Data)
local FolderMobs = workspace.Map.GameSettings.GameOnline.PlayeMobs

local AttackMob = {}


function Distation(Mob,Character)
    return function ()
        if Mob.Configuration.HP.Value > 0 and Mob ~= nil then
            return (Mob.UpperTorso.Position - Character.PrimaryPart.Position).Magnitude
        end
    end
end

function DistationSpawn(Mob,Character)
    return function ()
        if Mob.Configuration.HP.Value > 0 and Mob ~= nil then
            return (Mob.SpawnMobs.Value.Position - Mob.HumanoidRootPart.Position).Magnitude
        end
    end
end


function DestroyMobs(Player,PData,SpawnMobs,SpawnMobsMax,Field)
    return function ()
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
                PData.BaseFakeSettings.PlayerAttack = false
                index[Field.Monster.Value..SpawnMobs]:Destroy()
            end
        until SpawnMobsMax == SpawnMobs
    end
end

function MobsAttaker(Player,Character,Mob,Field)

    local SpawnMobs = 0
    local SpawnMobsMax = 0

    local PData = Data:Get(Player)
    while Mob.Configuration.HP.Value > 0 do
        task.wait()
        if workspace:WaitForChild(Player.Name) and PData.BaseFakeSettings.FieldMods == Field.Name and Mob ~= nil and Mob.Configuration.HP.Value > 0 then
            if Distation(Mob,Character)() <= 40 then
                coroutine.wrap(function() 
                    repeat task.wait()
                        if PData.BaseFakeSettings.PlayerAttack then
                            Mob.Humanoid:MoveTo(Character.PrimaryPart.Position)
                        end
                    until Distation(Mob,Character)() > 10 or Mob.Configuration.HP.Value > 0 or PData.BaseFakeSettings.FieldMods == "" or not PData.BaseFakeSettings.PlayerAttack 
                end)()
            end
            if DistationSpawn(Mob,Character)() > 50 or PData.BaseFakeSettings.FieldMods == "" then
                Mob.Humanoid:MoveTo(Mob.SpawnMobs.Value.Position)
            end

            task.spawn(function()
                for _, index in next, Field:GetChildren() do
                    if index:IsA('BasePart') then
                        SpawnMobsMax += 1
                    end
                end
            end)

            coroutine.wrap(function()
                print(DistationSpawn(Mob,Character)())
                if DistationSpawn(Mob,Character)() < 15 or PData.BaseFakeSettings.FieldMods == "" or not PData.BaseFakeSettings.PlayerAttack then
                    DestroyMobs(Player,PData,SpawnMobs,SpawnMobsMax,Field)
                end
            end)()
        end
    end
end

function AttackMob:MobsGo(Player, Mob, Field)
    local Character = game.Workspace:FindFirstChild(Player.Name)
    
    coroutine.resume(coroutine.create(function()
        MobsAttaker(Player,Character,Mob,Field)
    end))
end

return AttackMob