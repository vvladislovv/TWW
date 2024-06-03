local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild('PlayerGui')
local UIs = PlayerGui:WaitForChild('UIs')
local UIQuset = {}

function UIQuset:TweenGuiModule()
    TweenService:Create(UIs.FrameBlackScreen, TweenInfo.new(1,Enum.EasingStyle.Quad,Enum.EasingDirection.In),{BackgroundTransparency = 0}):Play()
    task.wait(9)
    TweenService:Create(UIs.FrameBlackScreen, TweenInfo.new(1,Enum.EasingStyle.Quad,Enum.EasingDirection.In),{BackgroundTransparency = 1}):Play()
end

function UIQuset:BlackSreenOff() -- поменять
    TweenService:Create(UIs.FrameBlackScreen, TweenInfo.new(1,Enum.EasingStyle.Quad,Enum.EasingDirection.In),{BackgroundTransparency = 1}):Play()
end

function UIQuset:EnabledUIModuleGui()
    local BlockFrame = UIs.FrameBlock
    TweenService:Create(BlockFrame,TweenInfo.new(0.8,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut), {Position = UDim2.new(0.359, 0,0.899, 0)}):Play() 
    local function GuiQusetFrame()
        local QusetFrame = UIs.QuestFrame
        TweenService:Create(QusetFrame.FrameCancel,TweenInfo.new(0.8,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut), {Position = UDim2.new(0.322, 0,1.5, 0)}):Play() -- {0.287, 0},{0.374, 0}
        TweenService:Create(QusetFrame.FrameName1,TweenInfo.new(0.8,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut), {Position = UDim2.new(-0.1, 0, 0.338, 0)}):Play() -- {0.077, 0},{0.338, 0}
        TweenService:Create(QusetFrame.FrameName2,TweenInfo.new(0.8,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut), {Position = UDim2.new(0.364, 0,1, 0)}):Play() -- {0.364, 0},{0.34, 0}
        TweenService:Create(QusetFrame.FrameQuest,TweenInfo.new(0.8,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut), {Position = UDim2.new(0.254, 0,1.5, 0)}):Play() -- {0.221, 0},{0.374, 0}
        TweenService:Create(QusetFrame.FrameTallk,TweenInfo.new(0.8,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut), {Position = UDim2.new(0.185, 0,1.5, 0)}):Play() -- {0.156, 0},{0.374, 0}
        TweenService:Create(QusetFrame.MSGFRAME,TweenInfo.new(0.8,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut), {Position = UDim2.new(0.154, 0,-1, 0)}):Play() -- {0.154, 0},{0.132, 0}
        TweenService:Create(QusetFrame.NPCFrame,TweenInfo.new(0.8,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut), {Position = UDim2.new(1.5, 0,0.175, 0)}):Play() -- {0.355, 0},{0.175, 0}
        TweenService:Create(QusetFrame.PlayerFrame,TweenInfo.new(0.8,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut), {Position = UDim2.new(-1, 0,0.175, 0)}):Play() -- {0.067, 0},{0.175, 0}
        task.wait(0.5)
        QusetFrame.Visible = false
    end

    GuiQusetFrame()
end

function UIQuset:UIModuleGui(QuestNPC)
    local BlockFrame = UIs.FrameBlock
    local QusetFrame = UIs.QuestFrame
    local Diologs = require(script.Parent.Diologs)
    TweenService:Create(BlockFrame,TweenInfo.new(0.8,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut), {Position = UDim2.new(0.359, 0,1, 0)}):Play() -- уезжает вниз ({0.359, 0},{0.899, 0})

    local TableSizeQuestFrame = {
        StartCancel = UDim2.new(0.061, 0,0.036, 0),
        EndCancel = UDim2.new(0.067, 0,0.04, 0)
    }   
    local function SettingsStart()
        QusetFrame.FrameQuest.NumberQuest.Frame.Frame.TextButton.Text ="#".._G.PData.QuestNPC[QuestNPC].TotalQuest
        if Diologs.QuesetDialog[QuestNPC].SettingsQuset.Talk ~= nil then -- Сделать чтобы кнопки были в нармально растояние, если нет этой штуки 
            TweenService:Create(QusetFrame.FrameQuest,TweenInfo.new(0.8,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut), {Position = UDim2.new(0.207, 0,0.395, 0)}):Play() -- {0.221, 0},{0.374, 0}
            TweenService:Create(QusetFrame.FrameCancel,TweenInfo.new(0.8,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut), {Position = UDim2.new(0.275, 0,0.395, 0)}):Play() -- {0.287, 0},{0.374, 0}
-- На данной момент тут не как бы, а пофакту есть
            QusetFrame.FrameTallk.Visible = false
        else
            TweenService:Create(QusetFrame.FrameQuest,TweenInfo.new(0.8,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut), {Position = UDim2.new(0.254, 0,0.392, 0)}):Play() -- {0.221, 0},{0.374, 0}
            TweenService:Create(QusetFrame.FrameCancel,TweenInfo.new(0.8,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut), {Position = UDim2.new(0.322, 0,0.392, 0)}):Play()
            TweenService:Create(QusetFrame.FrameTallk,TweenInfo.new(0.8,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut), {Position = UDim2.new(0.185, 0,0.392, 0)}):Play()
        end
    end

    local function GuiQusetFrame()
        QusetFrame.Visible = true
        --[[TweenService:Create(QusetFrame.FrameCancel,TweenInfo.new(0.8,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut), {Position = UDim2.new(0.287, 0,1.5, 0)}):Play() -- {0.287, 0},{0.374, 0}
        TweenService:Create(QusetFrame.FrameName1,TweenInfo.new(0.8,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut), {Position = UDim2.new(0.077, 0,-0.1, 0)}):Play() -- {0.077, 0},{0.338, 0}
        TweenService:Create(QusetFrame.FrameName2,TweenInfo.new(0.8,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut), {Position = UDim2.new(0.364, 0,1, 0)}):Play() -- {0.364, 0},{0.34, 0}
        TweenService:Create(QusetFrame.FrameQuest,TweenInfo.new(0.8,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut), {Position = UDim2.new(0.221, 0,1.5, 0)}):Play() -- {0.221, 0},{0.374, 0}
        TweenService:Create(QusetFrame.FrameTallk,TweenInfo.new(0.8,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut), {Position = UDim2.new(0.156, 0,1.5, 0)}):Play() -- {0.156, 0},{0.374, 0}
        TweenService:Create(QusetFrame.MSGFRAME,TweenInfo.new(0.8,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut), {Position = UDim2.new(0.154, 0,-1, 0)}):Play() -- {0.154, 0},{0.132, 0}
        TweenService:Create(QusetFrame.NPCFrame,TweenInfo.new(0.8,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut), {Position = UDim2.new(1.5, 0,0.175, 0)}):Play() -- {0.355, 0},{0.175, 0}
        TweenService:Create(QusetFrame.PlayerFrame,TweenInfo.new(0.8,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut), {Position = UDim2.new(-1, 0,0.175, 0)}):Play() -- {0.067, 0},{0.175, 0}
        ]]
        TweenService:Create(QusetFrame.FrameName1,TweenInfo.new(0.8,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut), {Position = UDim2.new(0.077, 0,0.338, 0)}):Play() -- {0.077, 0},{0.338, 0}
        TweenService:Create(QusetFrame.FrameName2,TweenInfo.new(0.8,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut), {Position = UDim2.new(0.364, 0,0.34, 0)}):Play() -- {0.364, 0},{0.34, 0}
        TweenService:Create(QusetFrame.MSGFRAME,TweenInfo.new(0.8,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut), {Position = UDim2.new(0.154, 0,0.132, 0)}):Play() -- {0.154, 0},{0.132, 0}
        TweenService:Create(QusetFrame.NPCFrame,TweenInfo.new(0.8,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut), {Position = UDim2.new(0.355, 0,0.175, 0)}):Play() -- {0.355, 0},{0.175, 0}
        TweenService:Create(QusetFrame.PlayerFrame,TweenInfo.new(0.8,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut), {Position = UDim2.new(0.067, 0,0.175, 0)}):Play() -- {0.067, 0},{0.175, 0}
    end

    local function GuiMouseHover()
        local QusetFrame = UIs.QuestFrame
        QusetFrame.FrameCancel.Frame.Frame.TextButton.MouseEnter:Connect(function()
            QusetFrame.FrameCancel:TweenSize(TableSizeQuestFrame.EndCancel, Enum.EasingDirection.Out, Enum.EasingStyle.Sine,.25,true)
        end)
        QusetFrame.FrameCancel.Frame.Frame.TextButton.MouseLeave:Connect(function()
            QusetFrame.FrameCancel:TweenSize(TableSizeQuestFrame.StartCancel, Enum.EasingDirection.Out, Enum.EasingStyle.Sine,.25,true)
        end)

        QusetFrame.FrameQuest.Frame.Frame.TextButton.MouseEnter:Connect(function()
            QusetFrame.FrameQuest:TweenSize(TableSizeQuestFrame.EndCancel, Enum.EasingDirection.Out, Enum.EasingStyle.Sine,.25,true)
        end)
        QusetFrame.FrameQuest.Frame.Frame.TextButton.MouseLeave:Connect(function()
            QusetFrame.FrameQuest:TweenSize(TableSizeQuestFrame.StartCancel, Enum.EasingDirection.Out, Enum.EasingStyle.Sine,.25,true)
        end)

        QusetFrame.FrameTallk.Frame.Frame.TextButton.MouseEnter:Connect(function()
            QusetFrame.FrameTallk:TweenSize(TableSizeQuestFrame.EndCancel, Enum.EasingDirection.Out, Enum.EasingStyle.Sine,.25,true)
        end)
        QusetFrame.FrameTallk.Frame.Frame.TextButton.MouseLeave:Connect(function()
            QusetFrame.FrameTallk:TweenSize(TableSizeQuestFrame.StartCancel, Enum.EasingDirection.Out, Enum.EasingStyle.Sine,.25,true)
        end)

        QusetFrame.FrameCancel.Frame.Frame.TextButton.MouseButton1Click:Connect(function()
            require(ReplicatedStorage.Modules.QuestModule):CloseSystems()
        end)
    end
    SettingsStart()
    GuiQusetFrame()
    GuiMouseHover()
end

return UIQuset