local ReplicatedStorage = game:GetService("ReplicatedStorage")

local TweenModule = require(ReplicatedStorage.Libary.TweenModule)
local ModuleTable = require(ReplicatedStorage.Modules.ModuleTable)
local Nofical = false
local NofficalModule = {}

local SettingsNotify = {

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

function MakeNotifyWindow(color, msg, Icon,TypeCall)
    if not Icon then
        local FrameBox = ReplicatedStorage.Assert.FrameNotify:Clone()
        FrameBox.Parent = getFrame()()
        local OldSizeFrame = FrameBox.Size
        FrameBox.Transparency = 1
        FrameBox.FrameImage.Visible = false
        FrameBox.Size = UDim2.fromScale(0,0)

        FrameBox.FrameMain.BackgroundColor3 = ModuleTable.ColorTable.Noffical[color][1] 
        FrameBox.FrameMain.Frame2.BackgroundColor3 = ModuleTable.ColorTable.Noffical[color][2]
        FrameBox.FrameMain.Frame2.TextButton.Text = msg
        TweenModule:AnimationNotify(OldSizeFrame, FrameBox, 3)
    end
end

function NofficalModule:CreateNotify(Info)
    MakeNotifyWindow(Info.TypeColor,Info.Msg,Info.Icon,Info.TypeCall)
end 

--[[function NofficalModule:NofficalCreate(Info) --OBJ,Text,ColorIndex,icon,items
    if not Nofical then -- переписать полностью
        Nofical = true
        if Info.icon and Info.items ~= nil then
            OBJ.FrameImage.Frame2.ImageLabel.Image = ModuleTable.TokenTables.TokenDrop[items].Image
            OBJ.FrameImage.Frame2.BackgroundColor3 = ModuleTable.ColorTable.Noffical["Color"..ColorIndex][1]
            OBJ.FrameMain.BackgroundColor3 = ModuleTable.ColorTable.Noffical["Color"..ColorIndex][1] 
            OBJ.FrameMain.Frame2.BackgroundColor3 = ModuleTable.ColorTable.Noffical["Color"..ColorIndex][2]
            OBJ.FrameMain.Frame2.TextButton.Text = Text
            TweenModule:NofficalUp(OBJ,icon)
            task.wait(1)
            TweenModule:NofficalDown(OBJ)
            Nofical = false
        else
            OBJ.FrameMain.BackgroundColor3 = ModuleTable.ColorTable.Noffical["Color"..ColorIndex][1] 
            OBJ.FrameMain.Frame2.BackgroundColor3 = ModuleTable.ColorTable.Noffical["Color"..ColorIndex][2]
            OBJ.FrameMain.Frame2.TextButton.Text = Text
            TweenModule:NofficalUp(OBJ,icon)
            task.wait(1)
            TweenModule:NofficalDown(OBJ)
            Nofical = false
        end
    end
end]]

return NofficalModule