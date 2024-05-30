local ReplicatedStorage = game:GetService("ReplicatedStorage")

local TweenModule = require(ReplicatedStorage.Libary.TweenModule)
local ModuleTable = require(ReplicatedStorage.Modules.ModuleTable)
local Nofical = false
local NofficalModule = {}

local TableToken = {}
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

function MakeNotifyWindow(color, msg, Icon,TypeCall,Items)
    local OldSizeFrame
    if not Icon then
        local FrameBox = ReplicatedStorage.Assert.FrameNotify:Clone()
        FrameBox.Parent = getFrame()()
        OldSizeFrame = FrameBox.Size
        FrameBox.Transparency = 1
        FrameBox.FrameImage.Visible = false
        FrameBox.Size = UDim2.fromScale(0,0)

        FrameBox.FrameMain.BackgroundColor3 = ModuleTable.ColorTable.Noffical[color][1]
        FrameBox.FrameMain.Frame2.BackgroundColor3 = ModuleTable.ColorTable.Noffical[color][2]
        FrameBox.FrameMain.Frame2.TextButton.Text = msg
        TweenModule:AnimationNotify(OldSizeFrame, FrameBox, 3,Icon)
    else  --Icon = true
        if not TableToken[Items] then

            TableToken[Items] = {}
            TableToken[Items].Value = 1

            local FrameBox = ReplicatedStorage.Assert.FrameNotify:Clone()
            FrameBox.Name = Items
            FrameBox.Parent = getFrame()()

            OldSizeFrame = FrameBox.Size
            FrameBox.Transparency = 1
            FrameBox.Size = UDim2.fromScale(0,0)
            FrameBox.FrameImage.Frame2.BackgroundColor3 = ModuleTable.ColorTable.Noffical[color][1]
            FrameBox.FrameImage.Frame2.ImageLabel.Image = ModuleTable.TokenTables.TokenDrop[Items].Image
            FrameBox.FrameMain.BackgroundColor3 = ModuleTable.ColorTable.Noffical[color][1] 
            FrameBox.FrameMain.Frame2.BackgroundColor3 = ModuleTable.ColorTable.Noffical[color][2]
            FrameBox.FrameMain.Frame2.TextButton.Text = msg
            TweenModule:AnimationNotify(OldSizeFrame, FrameBox, 3,Icon)
        else -- плюсует но нет эффекта удаления по этапно
            local Frame = getFrame()()
            for _, value in next, Frame:GetChildren() do
                if value.Name == Items then
                    Frame[Items].FrameMain.Frame2.TextButton.Text = msg
                    print(msg)
                    TableToken[Items].Value += 1

                    if Frame[Items] then
                        TweenModule:NoffiAnim(Frame[Items])
                    end
                end
            end

            task.delay(5,function()
                for _, value in next, Frame:GetChildren() do
                    if value.Name ~= "UIListLayout" then
                        if value.Name == Items then
                            TableToken[Items] = nil
                            TweenModule:TokenTableNotify(value)
                        else
                            TweenModule:TokenTableNotify(value)
                        end
                    end
                end
            end)
            --TweenModule:NoffiAnim(FrameBox,OldSizeFrame)
        end
    end
end

function NofficalModule:CreateNotify(Info)
    MakeNotifyWindow(Info.TypeColor,Info.Msg,Info.Icon,Info.TypeCall,Info.Items)
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