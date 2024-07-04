local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = ReplicatedStorage:WaitForChild("Remotes")
local NofficalGame = require(ReplicatedStorage.Libary.NofficalGame)

local ClientAll = {}

function Noffical(color,Text,Ic,ItemsIcon,Time)

    NofficalGame:CreateNotify({
        TypeColor = color,
        Msg = Text,
        Icon = Ic,
        TypeCall = "Hive",
        Items = ItemsIcon,
        Timer = Time
    }) 
end

function DestroyFrame2(Items)
    NofficalGame:DestroyFrame(Items)
end

Remotes.Notify.OnClientEvent:Connect(Noffical)
ReplicatedStorage.Remotes.DestroyFrameNoffical.OnClientEvent:Connect(DestroyFrame2)
return ClientAll