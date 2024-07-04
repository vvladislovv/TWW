local ReplicatedStorage = game:GetService("ReplicatedStorage")

local TweenModule = require(ReplicatedStorage.Libary.TweenModule)
local ModuleTable = require(ReplicatedStorage.Modules.ModuleTable)
local Nofical = false
local NofficalModule = {}

local TableToken = {
    oldItems = {},
    NewItems = {}
}
local function getFrame()
    return function ()
        local players = game:GetService("Players")
        local player = players.LocalPlayer
        local playerGui = player.PlayerGui
        local screenGui = playerGui:WaitForChild("UIs")
        local frame = screenGui:WaitForChild("NotifyList")
        return frame
    end
end

local function NoficalCreate(OldSizeFrame,msg,Icon,color,Items)
    local FrameBox = ReplicatedStorage.Assert.FrameNotify:Clone()
    FrameBox.Parent = getFrame()()
    FrameBox.Name = Items
    OldSizeFrame = FrameBox.Size
    FrameBox.Transparency = 1
    FrameBox.FrameImage.Visible = false
    FrameBox.Size = UDim2.fromScale(0,0)

    FrameBox.FrameMain.BackgroundColor3 = ModuleTable.ColorTable.Noffical[color][1]
    FrameBox.FrameMain.Frame2.BackgroundColor3 = ModuleTable.ColorTable.Noffical[color][2]
    FrameBox.FrameMain.Frame2.TextButton.Text = msg
    TweenModule:AnimationNotify(OldSizeFrame, FrameBox, 3,Icon)
end

function MakeNotifyWindow(color, msg, Icon,TypeCall,Items, Timer) -- pcall наверное надо добавить 
    local OldSizeFrame

    if not Icon then
        NoficalCreate(OldSizeFrame,msg,Icon,color,TypeCall)
    else  
        local Frame = getFrame()()
        if  not TableToken.NewItems[Items] then
            TableToken.NewItems[Items] = {b = 1}
            NoficalCreate(OldSizeFrame,msg,Icon,color,Items)
        else
            for _, value in next, Frame:GetChildren() do
                if not value:IsA('UIListLayout')  then
                    if value.name == Items then
                        value.FrameMain.Frame2.TextButton.Text = msg
                    end
                end
            end
        end
    end
end

function GetTableNumber(Items)
    local number = 0

    for index, value in pairs(TableToken.NewItems) do
        if Items ~= index then
            number += 1
        else
            return number
        end
    end
end

function NofficalModule:DestroyFrame(Items)
    local Frame = getFrame()()
    local GetNumber = GetTableNumber(Items)
    for _, value in next, Frame:GetChildren() do
        if not value:IsA('UIListLayout')  then
            if value.name == Items then
                TweenModule:NofficalDown(value)
                table.remove(TableToken.NewItems,GetNumber)
                TableToken.NewItems[Items] = nil
            end
        end
    end
end

function NofficalModule:CreateNotify(Info)
    MakeNotifyWindow(Info.TypeColor,Info.Msg,Info.Icon,Info.TypeCall,Info.Items, Info.Timer)
end

return NofficalModule