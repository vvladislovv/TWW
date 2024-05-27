local player = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local MobuleButton = require(ReplicatedStorage:WaitForChild('Modules').ButtonGame)

game:IsLoaded()
game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All,false)
local ClientScript = game.ReplicatedStorage.Modules
for _, index in next, ClientScript:GetDescendants() do
	if index:IsA('ModuleScript') then
		require(index)
		print(index)
	end
end

ReplicatedStorage.Remotes.ClientOpenServer:FireServer()
