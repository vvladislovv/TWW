local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local NofficalGame = require(ReplicatedStorage.Libary.NofficalGame)

local ClientAll = {}

function Noffical(color,Text,Ic,ItemsIcon)
    print(color,Text,Ic,ItemsIcon)
    NofficalGame:CreateNotify({
        TypeColor = color,
        Msg = Text,
        Icon = Ic,
        TypeCall = "Hive",
        Items = ItemsIcon
    }) 
end

Remotes.Notify.OnClientEvent:Connect(Noffical)

return ClientAll