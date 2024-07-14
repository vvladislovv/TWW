game:IsLoaded()
local player = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

game.StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All,false)
local ClientScript = game.ReplicatedStorage.Modules

local _, Err = pcall(function()
	for _, index in next, ClientScript:GetDescendants() do
		if index:IsA('ModuleScript') then
			require(index)
			--print(index)
		end
	end
end)

coroutine.wrap(function()
	if Err then
		warn(Err)
	end
end)


ReplicatedStorage.Remotes.ClientOpenServer:FireServer()
