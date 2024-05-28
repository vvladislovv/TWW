local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local NofficalGame = require(ReplicatedStorage.Libary.NofficalGame)

local ClientAll = {}

function Noffical(color,Text,Ic)
    NofficalGame:CreateNotify({
        TypeColor = color,
        Msg = Text,
        Icon = Ic,
        TypeCall = "Hive",
        Items = nil
    }) 
end

Remotes.Notify.OnClientEvent:Connect(Noffical)

return ClientAll