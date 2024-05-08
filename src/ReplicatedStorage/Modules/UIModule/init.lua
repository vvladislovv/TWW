local Player = game.Players.LocalPlayer
local PlayserGui = Player:WaitForChild("PlayerGui")
local UIs = PlayserGui:WaitForChild('UIs')
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ModuleTable = require(ReplicatedStorage.Modules.ModuleTable)
local Remote = ReplicatedStorage:WaitForChild('Remotes')
_G.PData = Remote.GetDataSave:InvokeServer()
local UImodule = {}

function ItemsPlayer(TypeItems)

    if _G.PData.Equipment[TypeItems] then
        local IconGui = UIs:WaitForChild('BoostIcon')
        for Number, GetIcon in next, IconGui:GetChildren() do
            for Num, GetEquimp in next, _G.PData.Equipment do
                if GetIcon.Name == "Tool"and Num == "Tool" and _G.PData.Equipment[TypeItems] == GetEquimp then
                    GetIcon.Visible = true
                    GetIcon.ImageLabel.Image = ModuleTable.ItemsPlayer.Tools[_G.PData.Equipment[TypeItems]].GuiItems
                elseif GetIcon.Name == "Bag" and Num == "Bag" and _G.PData.Equipment[TypeItems] == GetEquimp then
                    GetIcon.Visible = true
                    GetIcon.ImageLabel.Image = ModuleTable.ItemsPlayer.Bags[_G.PData.Equipment[TypeItems]].GuiItems
                end  
            end
        end
    end
end



Remote.UItems.OnClientEvent:Connect(ItemsPlayer)
return UImodule