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
        
    else  --Icon = true -- ! придумать и переписать
        local Frame = getFrame()()
        if not Frame:IsA('UIListLayout') then
            if Frame.Name ~= Items then
                print(Items)
                print(Frame.Name)
                TableToken[Items] = {}
                TableToken[Items].Time = os.time() + 5
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
    
            else -- Тут надо дописать
                local Frame = getFrame()()
                print('fff')
                for _, value in next, Frame:GetChildren() do
                    if value.Name == Items and Items ~= nil then
                        Frame[Items].FrameMain.Frame2.TextButton.Text = msg
                        -- print(msg)
                        
                        if TableToken[Items] ~= nil then
                            if TableToken[Items] ~= nil then
                                TableToken[Items].Time = os.time() + 5
                            end
                        end
                    end
                end
    
                task.delay(8,function()
                    print(Items)
                    if TableToken[Items].Time == os.time() then
                        TweenModule:NofficalDown(Frame[Items])
                        TableToken[Items].Time = 0
                        TableToken[Items] = {}
                    end 
                end)
    
                coroutine.wrap(function()
                    if TableToken[Items] == nil then
                        for _, value in next, Frame:GetChildren() do
                            if value.Name ~= "UIListLayout" then
                                TweenModule:TokenTableNotify(value)
                                TableToken[Items].Time = 0
                                TableToken[Items] = {}
                            end
                        end
                    end   
                end)()
                --TweenModule:NoffiAnim(FrameBox,OldSizeFrame)
            end
        end
    end
end

function NofficalModule:CreateNotify(Info)
    MakeNotifyWindow(Info.TypeColor,Info.Msg,Info.Icon,Info.TypeCall,Info.Items)
end

return NofficalModule