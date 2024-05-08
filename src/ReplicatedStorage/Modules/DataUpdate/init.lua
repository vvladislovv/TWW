local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = ReplicatedStorage:WaitForChild('Remotes')
local DataUpdate = {}

function UpdateClient(Key, value)
    _G.PData[Key] = value
end

Remotes.DataUpdate.OnClientEvent:Connect(UpdateClient)


return DataUpdate