game:IsLoaded()
task.wait(0.5)
local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local Mouse = Player:GetMouse()
local UIs = PlayerGui:FindFirstChild('UIs')
local IndexText = UIs.IndexText
local Pollen = UIs:WaitForChild('Pollen')
local Coin = UIs:WaitForChild('Coin')
local BoostIcon = UIs:WaitForChild('BoostIcon')
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local ModuleTable = require(ReplicatedStorage.Modules.ModuleTable)
local TweenModule = require(ReplicatedStorage.Libary.TweenModule)
local Utils = require(ReplicatedStorage.Libary.Utils)
local Remote = ReplicatedStorage:WaitForChild('Remotes')
_G.PData = Remote.GetDataSave:InvokeServer()

local StartSize = UDim2.new(0.173, 0,0.064, 0)
local EndSize = UDim2.new(0.162, 0,0.07, 0)

local Start2 = UDim2.new(0.148, 0,0.064, 0)
local End2 = UDim2.new(0.155, 0,0.067, 0)

local IsHovering = false
local UImodule = {}

function ItemsPlayer(TypeItems)
    if _G.PData.Equipment[TypeItems] then
        local IconGui = BoostIcon
        for Number, GetIcon in next, IconGui:GetChildren() do
            for Num, GetEquimp in next, _G.PData.Equipment do
                if GetIcon.Name == "Tool"and Num == "Tool" and _G.PData.Equipment[TypeItems] == GetEquimp then
                    GetIcon.Visible = true
                    TweenModule:OpenGuiEquments(GetIcon)
                    GetIcon.ImageLabel.Image = ModuleTable.ItemsPlayer.Tools[_G.PData.Equipment[TypeItems]].GuiItems
                elseif GetIcon.Name == "Bag" and Num == "Bag" and _G.PData.Equipment[TypeItems] == GetEquimp then
                    GetIcon.Visible = true
                    TweenModule:OpenGuiEquments(GetIcon)
                    GetIcon.ImageLabel.Image = ModuleTable.ItemsPlayer.Bags[_G.PData.Equipment[TypeItems]].GuiItems
                elseif GetIcon.Name == "Hat" and Num == "Hat" and _G.PData.Equipment[TypeItems] == GetEquimp then
                    GetIcon.Visible = true
                    TweenModule:OpenGuiEquments(GetIcon)
                    GetIcon.ImageLabel.Image = ModuleTable.ItemsPlayer.Hats[_G.PData.Equipment[TypeItems]].GuiItems
                elseif GetIcon.Name == "Boot" and Num == "Boot" and _G.PData.Equipment[TypeItems] == GetEquimp then
                    GetIcon.Visible = true
                    TweenModule:OpenGuiEquments(GetIcon)
                    GetIcon.ImageLabel.Image = ModuleTable.ItemsPlayer.Boots[_G.PData.Equipment[TypeItems]].GuiItems
                end  
            end
        end
    end
end

function PollenClick()
    if not _G.PData.Settings.PollenGuiAdd then
        Pollen.CanvasGroup.TextLabel.Text = Utils:Addprefixes(_G.PData.IStats.Pollen)..'/'..Utils:Addprefixes(_G.PData.IStats.Capacity)
        _G.PData.Settings.PollenGuiAdd = true
    else
        Pollen.CanvasGroup.TextLabel.Text = Utils:CommaNumber(_G.PData.IStats.Pollen)..'/'..Utils:CommaNumber(_G.PData.IStats.Capacity)
        _G.PData.Settings.PollenGuiAdd = false
    end
end

function CoinClick()
    if not _G.PData.Settings.CoinGuiAdd then
        Coin.Frame.Frame.TextLabel.Text = Utils:Addprefixes(_G.PData.IStats.Coin)
        _G.PData.Settings.CoinGuiAdd = true
    else
        Coin.Frame.Frame.TextLabel.Text = Utils:CommaNumber(_G.PData.IStats.Coin)
        _G.PData.Settings.CoinGuiAdd = false
    end
end

Coin.TextButton.MouseEnter:Connect(function()
    IsHovering = true
    IndexText.Text = "Your Coin"
    Coin:TweenSize(EndSize, Enum.EasingDirection.Out, Enum.EasingStyle.Sine,.25,true)
end)
Coin.TextButton.MouseLeave:Connect(function()
    IsHovering = false
    Coin:TweenSize(StartSize, Enum.EasingDirection.Out, Enum.EasingStyle.Sine,.25,true)
end)

Pollen.TextButton.MouseEnter:Connect(function()
    IsHovering = true
    IndexText.Text = "Your Pollen"
    Pollen:TweenSize(End2, Enum.EasingDirection.Out, Enum.EasingStyle.Sine,.25,true)
end)
Pollen.TextButton.MouseLeave:Connect(function()
    IsHovering = false
    IndexText.Text = ""
    Pollen:TweenSize(Start2, Enum.EasingDirection.Out, Enum.EasingStyle.Sine,.25,true)
end)


RunService.RenderStepped:Connect(function()
    IndexText.Position = UDim2.fromOffset(Mouse.X+55,Mouse.Y+30)
    IndexText.Visible = IsHovering
end)

Pollen.TextButton.MouseButton1Click:Connect(PollenClick)
Coin.TextButton.MouseButton1Click:Connect(CoinClick)
Remote.UItems.OnClientEvent:Connect(ItemsPlayer)
return UImodule