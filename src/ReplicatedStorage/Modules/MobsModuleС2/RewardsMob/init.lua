local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerScriptService = game:GetService("ServerScriptService")

local Remotes = ReplicatedStorage:WaitForChild('Remotes')
local ModuleTable = require(ReplicatedStorage.Modules.ModuleTable)
local NofficalGame = require(ReplicatedStorage.Libary.NofficalGame)
local RewardsMob = {}

function RToken(Field,Player) 
    local Data = ModuleTable.MonstersTable[Field.Monster.Value].Reward
    local TotalWeight = 0
    
    for i,v in pairs(Data) do
        TotalWeight += v.Chance
    end
    
    local Chance = math.random(1, TotalWeight)
    local coun = 0
    for i,v in pairs(Data) do
        coun += v.Chance
        if coun >= Chance and i ~= "Battle Points" then
            return v.Name
        end
    end
end


function RewardsMob:BattlePoints(Player,Data2)
    local PData = _G.PData
    PData.TotalItems['Battle Points'] += Data2['Battle Points'].Amt
    NofficalGame:CreateNotify({
        TypeColor = "Blue",
        Msg = "+"..Data2['Battle Points'].Amt.." Battle Points",
        Icon = false,
        TypeCall = "Hive"
    })
end

function RewardsMob:TokenSpawn(Player,Field,StartVector3, amountofitems,Arclength)
    local AngleBetweenInDegrees = 360/amountofitems
	local AngleBetweenInRad = math.rad(AngleBetweenInDegrees)
	local Radius = Arclength/AngleBetweenInRad + 1
	local tab = {}
	local currentangle = 0
	for num = 1, amountofitems do
		currentangle +=  AngleBetweenInRad
		local z = math.cos(currentangle)*Radius
		local x = math.sin(currentangle)*Radius
		local vector3 = StartVector3 + Vector3.new(x,-1.5,z) -- Указать парт которые остаеться и это будет точка радиуса
		table.insert(tab,vector3)
		
        if ModuleTable.MonstersTable[Field.Monster.Value] then
            local RandomToken = RToken(Field,Player)
            if RandomToken ~= 1 then

                Remotes.SpawnTokenClient:FireServer({
                    PlayerName = Player,
                    Position = vector3,
                    Cooldown = 15,
                    Token = {
                        Item = RandomToken,
                        Amount = 1,
                        Type = "Drop",
                    },
                    Resourse = Field.Name.." Field",
                })
            end
        end
    end
	return tab
end


function RewardsMob:GetReward(Player,Mob,Field,SpawnMobs)
    local PData = _G.PData
    local RewardNumber = 0
    local RewardMobs = nil
    if not Field['Timer'..SpawnMobs].TimerStart.Value then
        PData.TimerTable.Field[Field.Name]['Timer'..SpawnMobs] = {Time = ModuleTable.MonstersTable[Field.Monster.Value].SettingsMobs.Cooldown + os.time()} -- Ставим время
        for _,v in pairs(ModuleTable.MonstersTable[Field.Monster.Value].Reward) do
            if v ~= "Battle Points" then
                RewardNumber += 1
            end
        end

        RewardMobs = table.clone(ModuleTable.MonstersTable[Field.Monster.Value].Reward)
        RewardsMob:BattlePoints(Player,RewardMobs)
        require(script.Parent.TimerMob):CreateTimerMobs(Player,Field,Mob)
        task.spawn(function()
            if RewardMobs ~= nil then
                if RewardNumber == 3 then
                    RewardsMob:TokenSpawn(Player, Field, Mob.LowerTorso.Position, RewardNumber, 3)
                elseif RewardNumber >= 3 then
                    RewardsMob:TokenSpawn(Player, Field, Mob.LowerTorso.Position, RewardNumber, 4)
                elseif RewardNumber >= 8 then
                    RewardsMob:TokenSpawn(Player, Field, Mob.LowerTorso.Position, RewardNumber, 6)
                elseif RewardNumber <= 15 then
                    RewardsMob:TokenSpawn(Player, Field, Mob.LowerTorso.Position, RewardNumber, 8)
                end
            end
        end)
    end
end

return RewardsMob