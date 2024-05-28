task.wait()
local Player = game.Players.LocalPlayer
local Characte = Player.Character or Player.CharacterAdded:Wait()
local HRP = Characte:WaitForChild("HumanoidRootPart")
local Him = Characte:WaitForChild("Humanoid")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UIS = game:GetService("UserInputService")
local CAS = game:GetService("ContextActionService")

local Tools = require(ReplicatedStorage.Modules.ModuleTable).ItemsPlayer.Tools
local CollectFlowerModule = require(ReplicatedStorage.Modules.FlowerModule)
_G.PData = ReplicatedStorage.Remotes.GetDataSave:InvokeServer()

local ToolInfo = Tools[_G.PData.Equipment.Tool]
local ModuleTool = Tools[_G.PData.Equipment.Tool]
if not ToolInfo then
	warn("Tool isn't in moduleScript. Please joiner ServerStrorage")
	return
end

local Collect = false
local Debonuce = false
local TableAnim = require(ReplicatedStorage.Modules.ModuleTable).ItemsPlayer.Tools[_G.PData.Equipment.Tool].AnimTools
local NofficalGame = require(ReplicatedStorage.Libary.NofficalGame)

UIS.InputBegan:Connect(function(v1,v2)
	if not v2 and v1.UserInputType == Enum.UserInputType.MouseButton1 then
		Collect = true
	end
end)

UIS.InputEnded:Connect(function(v1,v2)
	if not v2 and v1.UserInputType == Enum.UserInputType.MouseButton1 then
		Collect = false
	end
end)


CAS:BindAction("Scoop", function(_, State)
	if State == Enum.UserInputState.Begin then
		Collect = true
	else 
		Collect = false
	end
end, true, Enum.KeyCode.ButtonB)
CAS:SetPosition("Scoop", UDim2.new(1, -70, 0, 10))
CAS:SetTitle("Scoop", "Scoop")

local Coouldown = {}

function CollectFlowerClient(AnimTrack, HRP) -- фикс нужен(Если не 55 строчка, то есть ожидание, надо решить баг)
    if _G.PData.IStats.Pollen <= _G.PData.IStats.Capacity and not Coouldown[Player.Name] then
        Coouldown[Player.Name] = true
        task.wait(AnimTrack.Length-0.8)

        CollectFlowerModule:CollectFlower(Player, {
            HRP = HRP,
            Offset = Vector3.new(0,0,0),
            Stamp = ModuleTool.BlockFieldCoper,
			StatsMOD = ModuleTool,
        })
        task.wait(ModuleTool.SpeedCoper - 0.2)
		Coouldown[Player.Name] = false
    end
end

game:GetService("RunService").RenderStepped:Connect(function()
    if Collect and not Debonuce then
        Debonuce = true
		local Anim = Instance.new("Animation")
		Anim.AnimationId = TableAnim
		
		local AnimTrack = Him:LoadAnimation(Anim)
		local Cooldown = ToolInfo.SpeedCoper / (_G.PData.Boost.PlayerBoost["Collectors Speed"] / 100)
		AnimTrack.Priority = Enum.AnimationPriority.Action
		AnimTrack:Play()
		if _G.PData.IStats.Pollen >= _G.PData.IStats.Capacity then
			coroutine.wrap(function()
				NofficalGame:CreateNotify({
					TypeColor = 'Red',
					Msg = "You bag is full! Convert pollen in your hive!",
					Icon = false,
					TypeCall = "Hive",
					Items = nil
				})
			end)()
		else
			CollectFlowerClient(AnimTrack,HRP)
		end
		task.wait(Cooldown)
		Debonuce = false
		
		task.spawn(function()
			--task.wait(AnimTrack.Lenght)
			Anim:Destroy()
		end)
    end
end)
