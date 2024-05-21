local ServerScriptService = game:GetService("ServerScriptService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local Data = require(ServerScriptService.ServerScript.Data)
local ModuleTable = require(ReplicatedStorage.Modules.ModuleTable)
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


function DestroyMobs(Player,Mob,PData,Field)
    for _, index in next, FolderMobs:GetChildren() do
        index[Mob.Name].ModelBag.Head:FindFirstChild('BG').Enabled = false
        for _, value in next, index[Mob.Name].ModelBag:GetChildren() do
            TweenService:Create(value, TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out), {Transparency = 1}):Play()                                                                        
        end
        for _, value in next, workspace.Map.GameSettings.FieldBarierMobs[Field.Name]:GetChildren() do
            if value:IsA('Attachment') then
                value.Spawn.Value = false
            end
        end

        coroutine.wrap(function()
            while true do
                task.wait()
                for _, value in next, workspace.Map.GameSettings.FieldBarierMobs[Field.Name]:GetChildren() do
                    if value:IsA('Attachment') then
                        if value.Spawn.Value and index[Mob.Name] == nil then
                            value.Spawn.Value = false
                            index:Destroy()
                            break
                        end
                    end
                end
            end
        end)
        if index ~= nil and Mob.PrimaryPart ~= nil then
            print(Mob.Name)
            task.wait(0.3)
            PData.BaseFakeSettings.PlayerAttack = false
            index[Mob.Name]:Destroy()
        end
    end
end

function MobsAttaker(Player,Character,Mob,Field)

    local PData = Data:Get(Player)

        while task.wait() do
            task.wait()
            if Mob ~= nil and Mob:WaitForChild('Configuration',1) ~= nil then
                if workspace:WaitForChild(Player.Name) and Mob ~= nil and Mob.Configuration.HP.Value > 0 then

                    if PData.BaseFakeSettings.FieldMods == Field.Name then
                        coroutine.wrap(function()
                            if PData.BaseFakeSettings.PlayerAttack and PData.BaseFakeSettings.FieldMods ~= "" then
                                Mob.Humanoid:MoveTo(Character.PrimaryPart.Position)
                            end
                        end)()
                    end
                    coroutine.wrap(function()
                        if (Mob:WaitForChild('UpperTorso').Position - Player.Character.PrimaryPart.Position).Magnitude <= 5 then
                            task.wait(0.3)
                            Player.Character.Humanoid.Health -= ModuleTable.MonstersTable[Field.Monster.Value].SettingsMobs.Damage
                            Mob.Humanoid:MoveTo(Mob.SpawnMobs.Value.Position)
                        end
                    end)

                    if PData.BaseFakeSettings.FieldMods == "" and Mob.Configuration.HP.Value > 0 then
                        Mob.Humanoid:MoveTo(Mob.SpawnMobs.Value.Position)
                    end
                                    
                    if DistationSpawn(Mob,Character)() <= 6 and PData.BaseFakeSettings.FieldMods == "" then
                        DestroyMobs(Player,Mob,PData,Field)
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