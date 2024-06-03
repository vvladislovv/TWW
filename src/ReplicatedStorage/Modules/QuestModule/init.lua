local Player = game.Players.LocalPlayer
local SoundService = game:GetService("SoundService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local PlayerScript = Player:WaitForChild("PlayerScripts")
local FolderCamers = workspace.Map.GameSettings.NPC.Camers
local CamCurr = game.Workspace.CurrentCamera

local PlayerModule = require(PlayerScript:WaitForChild("PlayerModule"))
local TweenModule = require(ReplicatedStorage.Libary.TweenModule)
local UIQuset = require(script.UIQuset)
local Controls = PlayerModule:GetControls()
local CameraOpen = false
local CamOriginal = nil
local TweenCamers = nil
local QuestModule = {}

function QuestModule:CheckNPC(Button)
    if Button.QuestNPC.Value == "Snail" then
        --QuestModule:StartSystems(Button.QuestNPC.Value)
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
                    Button.B.ButtonE.ImageColor3 = Color3.fromRGB(166, 166, 166)
                    TweenModule:KeyCode(Button.B)
                end

                if not UserInputService:IsKeyDown(input.KeyCode.EnumType.E) then
                    --SoundService.CloseButton:Play()
                    SoundService.OpenButton:Play()
                    Button.B.ButtonE.ImageColor3 = Color3.fromRGB(255, 255, 255)
                end                
            end)

            QuestModule:CheckNPC(Button) 
        end
    end
end



function CameraCirile(CamsFolder,CamersMax,CameraMin,Cam) -- Тут смотреть
    while CameraOpen do
        CameraMin += 1
        if CameraMin > CamersMax then
            task.spawn(function()
                UIQuset:TweenGuiModule()
            end)
            CameraMin = CamersMax
            CameraMin = 1
        end
        TweenCamers = TweenService:Create(Cam, TweenInfo.new(8, Enum.EasingStyle.Linear,Enum.EasingDirection.InOut), {CFrame = CamsFolder['Cam'..CameraMin].CFrame})
        TweenCamers:Play()
        task.wait(8)
    end
end

function QuestModule:CloseSystems()
    CameraOpen = false
    TweenService:Create(CamCurr, TweenInfo.new(1, Enum.EasingStyle.Linear,Enum.EasingDirection.InOut), {CFrame = CamOriginal}):Play()
    UIQuset:BlackSreenOff()
    task.wait(0.1)
    CamCurr.CameraType = Enum.CameraType.Custom
    Controls:Enable()
    UIQuset:EnabledUIModuleGui()
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
        UIQuset:UIModuleGui(QuestNPC)
        task.wait(0.8)
        local CameraMin = 1
        CameraCirile(CamsFolder,CamersMax,CameraMin,CamCurr)
    end
end


return QuestModule