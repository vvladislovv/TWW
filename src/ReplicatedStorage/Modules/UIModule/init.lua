game:IsLoaded()
task.wait(0.5)
local Player = game.Players.LocalPlayer

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local PlayerGui = Player:WaitForChild("PlayerGui")
local Mouse = Player:GetMouse()
local UIs = PlayerGui:FindFirstChild('UIs')
local IndexText = UIs:WaitForChild('IndexText')
local Pollen = UIs:WaitForChild('Pollen')
local Coin = UIs:WaitForChild('Coin')
local BoostIcon = UIs:WaitForChild('BoostIcon')
local Menu = UIs:WaitForChild('Menu')
local FrameBlock = UIs:WaitForChild('FrameBlock')
local HP = UIs:WaitForChild('HP')

local ModuleTable = require(ReplicatedStorage.Modules.ModuleTable)
local TweenModule = require(ReplicatedStorage.Libary.TweenModule)
local Utils = require(ReplicatedStorage.Libary.Utils)

local Remote = ReplicatedStorage:WaitForChild('Remotes')
_G.PData = Remote.GetDataSave:InvokeServer()

local TableSizeTween = {
    StartSize = UDim2.new(0.173, 0,0.064, 0),
    EndSize = UDim2.new(0.162, 0,0.07, 0),

    Start2 = UDim2.new(0.148, 0,0.064, 0),
    End2 = UDim2.new(0.155, 0,0.067, 0),

    Start3 = UDim2.new(0, 11,0, 492),
    End3 =  UDim2.new(0, 12,0, 536),

    Start4 = UDim2.new(0.145, 0,0.863, 0),
    End4 =  UDim2.new(0.162, 0,0.96, 0),

    Start5 = UDim2.new(0.077, 0,0.505, 0), -- Pos
    End5 =  UDim2.new(0.01, 0,0.505, 0), -- Pos

}


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

function MenuClick()
    -- {0.079, 0},{0.505, 0} open
    -- {0.01, 0},{0.505, 0} close
    if not _G.PData.Settings.MenuFixed then
        Menu:TweenPosition(TableSizeTween.End5, Enum.EasingDirection.Out, Enum.EasingStyle.Sine,0.5,true)
        _G.PData.Settings.MenuFixed = true
    else
        Menu:TweenPosition(TableSizeTween.Start5, Enum.EasingDirection.Out, Enum.EasingStyle.Sine,0.5,true)
        _G.PData.Settings.MenuFixed = false
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

function StartPlayerGui()
    _G.PData.Settings.PollenGuiAdd = false
    _G.PData.Settings.CoinGuiAdd = false
    Coin.Frame.Frame.TextLabel.Text = Utils:CommaNumber(_G.PData.IStats.Coin)
    Pollen.CanvasGroup.TextLabel.Text = Utils:CommaNumber(_G.PData.IStats.Pollen)..'/'..Utils:CommaNumber(_G.PData.IStats.Capacity)
end

for i, value in next, FrameBlock:GetChildren() do
    value.MouseEnter:Connect(function()
        IsHovering = true
        IndexText.Text = "Index "..value.Name
        value:TweenSize(TableSizeTween.End4, Enum.EasingDirection.Out, Enum.EasingStyle.Sine,.25,true)
    end)
    
    value.MouseLeave:Connect(function()
        IsHovering = false
        value:TweenSize(TableSizeTween.Start4, Enum.EasingDirection.Out, Enum.EasingStyle.Sine,.25,true)
    end)
end

HP.MouseEnter:Connect(function()
    IsHovering = true
    IndexText.Text = "Your HP "..Player.Character.Humanoid.Health
end)
HP.MouseLeave:Connect(function()
    IsHovering = false
end)

Menu.MenuCrol.MouseEnter:Connect(function()
    IsHovering = true
    IndexText.Text = "Game Menu"
   -- Menu:TweenPosition(TableSizeTween.Start5, Enum.EasingDirection.Out, Enum.EasingStyle.Sine,0.5,true)
    Menu.MenuCrol:TweenSize(TableSizeTween.End3, Enum.EasingDirection.Out, Enum.EasingStyle.Sine,.25,true)
end)

Menu.MenuCrol.MouseLeave:Connect(function()
    IsHovering = false
    --Menu:TweenPosition(TableSizeTween.Start5, Enum.EasingDirection.Out, Enum.EasingStyle.Sine,0.5,true)
    Menu.MenuCrol:TweenSize(TableSizeTween.Start3, Enum.EasingDirection.Out, Enum.EasingStyle.Sine,.25,true)
end)

Coin.TextButton.MouseEnter:Connect(function()
    IsHovering = true
    IndexText.Text = "Your Coin"
    Coin:TweenSize(TableSizeTween.EndSize, Enum.EasingDirection.Out, Enum.EasingStyle.Sine,.25,true)
end)
Coin.TextButton.MouseLeave:Connect(function()
    IsHovering = false
    Coin:TweenSize(TableSizeTween.StartSize, Enum.EasingDirection.Out, Enum.EasingStyle.Sine,.25,true)
end)

Pollen.TextButton.MouseEnter:Connect(function()
    IsHovering = true
    IndexText.Text = "Your Pollen"
    Pollen:TweenSize(TableSizeTween.End2, Enum.EasingDirection.Out, Enum.EasingStyle.Sine,.25,true)
end)
Pollen.TextButton.MouseLeave:Connect(function()
    IsHovering = false
    IndexText.Text = ""
    Pollen:TweenSize(TableSizeTween.Start2, Enum.EasingDirection.Out, Enum.EasingStyle.Sine,.25,true)
end)


RunService.RenderStepped:Connect(function()
    IndexText.Position = UDim2.fromOffset(Mouse.X+55,Mouse.Y+30)
    IndexText.Visible = IsHovering
end)

Remote.StartPlayerCoinPollen.OnClientEvent:Connect(StartPlayerGui)
Remote.UItems.OnClientEvent:Connect(ItemsPlayer)

Pollen.TextButton.MouseButton1Click:Connect(PollenClick)
Coin.TextButton.MouseButton1Click:Connect(CoinClick)
Menu.MenuCrol.TextButton.MouseButton1Click:Connect(MenuClick)

return UImodule