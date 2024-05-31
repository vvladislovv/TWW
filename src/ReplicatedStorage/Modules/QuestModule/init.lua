local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild('PlayerGui')
local UIs = PlayerGui:WaitForChild('UIs')
local PlayerScript = Player:WaitForChild("PlayerScripts")
local SoundService = game:GetService("SoundService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local FolderCamers = workspace.Map.GameSettings.NPC.Camers
local CamCurr = game.Workspace.CurrentCamera

local TweenModule = require(ReplicatedStorage.Libary.TweenModule)
local PlayerModule = require(PlayerScript:WaitForChild("PlayerModule"))
local Controls = PlayerModule:GetControls()

local CameraOpen = false
local CamOriginal = nil
local TweenCamers = nil
local QuestModule = {}

function QuestModule:CheckNPC(Button)
    if Button.QuestNPC.Value == "Snail" then
        QuestModule:StartSystems(Button.QuestNPC.Value)
    end
end

function QuestModule:StartModule(input)
    for _, Button in next, workspace.Map.GameSettings.Button:GetChildren() do
        if Button.Name == "Quest" then

            task.spawn(function()
                Button.B.ButtonE.ImageColor3 = Color3.fromRGB(255, 255, 255)
                SoundService.OpenButton:Play()

                while UserInputService:IsKeyDown(input.KeyCode.EnumType.E) do
                    task.wait()
                    CameraNow = 1
                    Button.B.ButtonE.ImageColor3 = Color3.fromRGB(166, 166, 166)
                    TweenModule:KeyCode(Button.B)
                end

                if not UserInputService:IsKeyDown(input.KeyCode.EnumType.E) then
                    --SoundService.CloseButton:Play()
                    SoundService.OpenButton:Play()
                    CameraNow = 1
                    Button.B.ButtonE.ImageColor3 = Color3.fromRGB(255, 255, 255)
                end                
            end)

            QuestModule:CheckNPC(Button) 
        end
    end
end

function TweenGuiModule()
    coroutine.wrap(function()
        TweenService:Create(UIs.FrameBlackScreen, TweenInfo.new(1,Enum.EasingStyle.Quad,Enum.EasingDirection.In),{BackgroundTransparency = 0}):Play()
        task.wait(9)
        TweenService:Create(UIs.FrameBlackScreen, TweenInfo.new(1,Enum.EasingStyle.Quad,Enum.EasingDirection.In),{BackgroundTransparency = 1}):Play()
    end)()
end


function CameraCirile(CamsFolder,CamersMax,CameraMin,Cam) -- Тут смотреть
    while CameraOpen do
        CameraMin += 1
        if CameraMin > CamersMax then
            TweenGuiModule()
            task.wait(0.3)
            CameraMin = CamersMax
            CameraMin = 1
        end
        print(CameraMin)
        print(CamersMax)
        TweenCamers = TweenService:Create(Cam, TweenInfo.new(8, Enum.EasingStyle.Linear,Enum.EasingDirection.InOut), {CFrame = CamsFolder['Cam'..CameraMin].CFrame})
        TweenCamers:Play()
        task.wait(8)
    end
end

function EnabledUIModuleGui()
    local BlockFrame = UIs.FrameBlock
    TweenService:Create(BlockFrame,TweenInfo.new(0.8,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut), {Position = UDim2.new(0.359, 0,0.899, 0)}):Play() 
    local function GuiQusetFrame()
        local QusetFrame = UIs.QuestFrame
        TweenService:Create(QusetFrame.FrameCancel,TweenInfo.new(0.8,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut), {Position = UDim2.new(0.287, 0,1.5, 0)}):Play() -- {0.287, 0},{0.374, 0}
        TweenService:Create(QusetFrame.FrameName1,TweenInfo.new(0.8,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut), {Position = UDim2.new(0.077, 0,-0.1, 0)}):Play() -- {0.077, 0},{0.338, 0}
        TweenService:Create(QusetFrame.FrameName2,TweenInfo.new(0.8,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut), {Position = UDim2.new(0.364, 0,1, 0)}):Play() -- {0.364, 0},{0.34, 0}
        TweenService:Create(QusetFrame.FrameQuest,TweenInfo.new(0.8,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut), {Position = UDim2.new(0.221, 0,1.5, 0)}):Play() -- {0.221, 0},{0.374, 0}
        TweenService:Create(QusetFrame.FrameTallk,TweenInfo.new(0.8,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut), {Position = UDim2.new(0.156, 0,1.5, 0)}):Play() -- {0.156, 0},{0.374, 0}
        TweenService:Create(QusetFrame.MSGFRAME,TweenInfo.new(0.8,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut), {Position = UDim2.new(0.154, 0,-1, 0)}):Play() -- {0.154, 0},{0.132, 0}
        TweenService:Create(QusetFrame.NPCFrame,TweenInfo.new(0.8,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut), {Position = UDim2.new(1.5, 0,0.175, 0)}):Play() -- {0.355, 0},{0.175, 0}
        TweenService:Create(QusetFrame.PlayerFrame,TweenInfo.new(0.8,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut), {Position = UDim2.new(-1, 0,0.175, 0)}):Play() -- {0.067, 0},{0.175, 0}
        QusetFrame.Visible = false
    end

    GuiQusetFrame()
end

function UIModuleGui()
    local BlockFrame = UIs.FrameBlock
    TweenService:Create(BlockFrame,TweenInfo.new(0.8,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut), {Position = UDim2.new(0.359, 0,1, 0)}):Play() -- уезжает вниз ({0.359, 0},{0.899, 0})

    local TableSizeQuestFrame = {
        StartCancel = UDim2.new(0.061, 0,0.036, 0),
        EndCancel = UDim2.new(0.067, 0,0.04, 0)
    }

    local function GuiQusetFrame()
        local QusetFrame = UIs.QuestFrame
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
        TweenService:Create(QusetFrame.FrameCancel,TweenInfo.new(0.8,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut), {Position = UDim2.new(0.317, 0,0.391, 0)}):Play() -- {0.287, 0},{0.374, 0}
        TweenService:Create(QusetFrame.FrameName1,TweenInfo.new(0.8,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut), {Position = UDim2.new(0.077, 0,0.338, 0)}):Play() -- {0.077, 0},{0.338, 0}
        TweenService:Create(QusetFrame.FrameName2,TweenInfo.new(0.8,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut), {Position = UDim2.new(0.364, 0,0.34, 0)}):Play() -- {0.364, 0},{0.34, 0}
        TweenService:Create(QusetFrame.FrameQuest,TweenInfo.new(0.8,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut), {Position = UDim2.new(0.221, 0,0.374, 0)}):Play() -- {0.221, 0},{0.374, 0}
        TweenService:Create(QusetFrame.FrameTallk,TweenInfo.new(0.8,Enum.EasingStyle.Quad,Enum.EasingDirection.InOut), {Position = UDim2.new(0.156, 0,0.374, 0)}):Play() -- {0.156, 0},{0.374, 0}
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

        QusetFrame.FrameCancel.Frame.Frame.TextButton.MouseButton1Click:Connect(function()
            QuestModule:CloseSystems()
        end)
    end
    GuiQusetFrame()
    GuiMouseHover()
end

function QuestModule:CloseSystems()
    CameraOpen = false
    TweenService:Create(CamCurr, TweenInfo.new(1, Enum.EasingStyle.Linear,Enum.EasingDirection.InOut), {CFrame = CamOriginal}):Play()
    task.wait(0.1)
    CamCurr.CameraType = Enum.CameraType.Custom
    Controls:Enable()
    EnabledUIModuleGui()

end

function QuestModule:StartSystems(QuestNPC)
    if not CameraOpen then
        CameraOpen = true
        local CamsFolder = FolderCamers[QuestNPC]
        local CamersMax = #CamsFolder:GetChildren()
        CamCurr.CameraType = Enum.CameraType.Scriptable
        CamOriginal = CamCurr.CFrame
        Controls:Disable()
        TweenService:Create(CamCurr, TweenInfo.new(1, Enum.EasingStyle.Linear,Enum.EasingDirection.InOut), {CFrame = CamsFolder.Cam1.CFrame}):Play()
        UIModuleGui()
        task.wait(0.8)
        local CameraMin = 1
        CameraCirile(CamsFolder,CamersMax,CameraMin,CamCurr)
    end
end


return QuestModule