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
        if Mob ~= nil then
            if Mob.Configuration.HP.Value > 0  then
                return (Mob.SpawnMobs.Value.Position - Mob.HumanoidRootPart.Position).Magnitude
            end 
        end
    end
end


function DestroyMobs(Player,Mob,PData,SpawnMobs,SpawnMobsMax,Field)
    for _, index in next, FolderMobs:GetChildren() do
        SpawnMobs += 1
        index[Mob.Name].ModelBag.Head:FindFirstChild('BG').Enabled = false
        for _, value in next, index[Mob.Name].ModelBag:GetChildren() do
            TweenService:Create(value, TweenInfo.new(0.5,Enum.EasingStyle.Quad,Enum.EasingDirection.Out), {Transparency = 1}):Play()                                                                        
        end

        Field['Pos'..SpawnMobs].Spawn.Value = false
        task.wait(1)

        if index ~= nil then
            index[Mob.Name]:Destroy()
            PData.BaseFakeSettings.PlayerAttack = false
        end
        
    end
end

function MobsAttaker(Player,Character,Mob,Field)
    local SpawnMobs = 0
    local SpawnMobsMax = 0

    local PData = Data:Get(Player)

        while task.wait() do
            task.wait()
            if Mob ~= nil and Mob:WaitForChild('Configuration') ~= nil then
                if workspace:WaitForChild(Player.Name) and Mob ~= nil and Mob.Configuration.HP.Value > 0 then

                    if PData.BaseFakeSettings.FieldMods == Field.Name then
                        coroutine.wrap(function()
                            if PData.BaseFakeSettings.PlayerAttack and PData.BaseFakeSettings.FieldMods ~= "" then
                                Mob.Humanoid:MoveTo(Character.PrimaryPart.Position)
                            end
                        end)()
                    end

                    if PData.BaseFakeSettings.FieldMods == "" then
                        Mob.Humanoid:MoveTo(Mob.SpawnMobs.Value.Position)
                    end
        
                    task.spawn(function()
                        for _, index in next, Field:GetChildren() do
                            if index:IsA('BasePart') then
                                SpawnMobsMax += 1
                            end
                        end
                    end)
                                    
                    if DistationSpawn(Mob,Character)() <= 6 and PData.BaseFakeSettings.FieldMods == "" then
                        print(Mob.Name)
                        DestroyMobs(Player,Mob,PData,SpawnMobs,SpawnMobsMax,Field)
                    end

                end
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