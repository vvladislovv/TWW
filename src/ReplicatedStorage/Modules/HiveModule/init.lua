game:IsLoaded()
local CollectionService = game:GetService("CollectionService")
local Player = game:GetService("Players").LocalPlayer
local PlayerGui = Player:WaitForChild('PlayerGui')
local PlayerScript = Player:WaitForChild("PlayerScripts")
local Mouse = Player:GetMouse()
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")
local PlayerModule = require(PlayerScript:WaitForChild("PlayerModule"))
local Remotes = ReplicatedStorage:WaitForChild('Remotes')
local TweenModule = require(ReplicatedStorage.Libary.TweenModule)
local NofficalModule = require(ReplicatedStorage.Libary.NofficalGame)
local Cam = game.Workspace.CurrentCamera
local CamOriginal = nil
local Noffical = true
local StartHive = false
local Controls = PlayerModule:GetControls()
local HiveFolder = workspace.Map.GameSettings.Hives

_G.PData = Remotes.GetDataSave:InvokeServer()

local HiveModule = {}

function HiveModule:StatModule(input)
    for _, Button in next, workspace.Map.GameSettings.Button:GetChildren() do
        if Button.Name == "Hive" then

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

            HiveOwnerCheck()
            if _G.PData.IStats.Pollen > 0 then -- Check Capacity
                --Button.B.Text.Position = UDim2.new(0.27, 0,0.25, 0)
                Button.B:WaitForChild('TextLabel').Text = "Stop Converting"
                Remotes.HiveConvert:FireServer()
                
                task.spawn(function()
                    repeat task.wait(1)
                        Button.B:WaitForChild('TextLabel').Text = "Convert Pollen"
                    until _G.PData.IStats.Pollen == 0
                end)

                Noffical = true
                --print(Noffical)
            else
                --Button.B.Text.Position = UDim2.new(0.27, 0,0.2, 0)
                Button.B:WaitForChild('TextLabel').Text = "Convert Pollen"
                Noffical = false
                
                if not Noffical and _G.PData.IStats.Pollen <= 0 then -- пофиксить баг, при заходе появлеться а надо чтобы при повторном нажатие 
                    task.wait()
                    Noffical = true
                    NofficalModule:NofficalCreate(PlayerGui:FindFirstChild('UIs').Noffical,"You can't recycle your empty backpack.",1,false,nil)
                    task.wait(3)
                    Noffical = false
                end
            end 
        end
    end
end


task.spawn(function()

    local SlotHight = false
    local CameraSlotH = false
    local function DistationCheck()

        local character = Player.Character or Player.CharacterAdded:Wait()
        local HumRootPart = character.HumanoidRootPart
    
        while game:IsLoaded() do -- and true
            task.wait()
            local DistationHRP = (HiveFolder[_G.PData.BaseFakeSettings.HiveNumberOwner].Camera.Position - HumRootPart.Position).Magnitude
            return DistationHRP
        end
    end

    UserInputService.InputBegan:Connect(function(input, GPE)
        if not GPE then
            if input.KeyCode == Enum.KeyCode.Q and _G.PData.BaseFakeSettings.HiveOwner == Player.Name and not _G.PData.BaseFakeSettings.OpenCameraCustomHive then
                local Distation = DistationCheck()
                SlotHight = true
                CameraSlotH = true
                print(Distation)
                if Distation < 10  then
                    TweenModule:OpenGuiButton(PlayerGui.UIs.CloseCameraHive)
                    _G.PData.BaseFakeSettings.OpenCameraCustomHive = true
                    CamOriginal = Cam.CFrame
                    Controls:Disable()
                    Cam.CameraType = Enum.CameraType.Scriptable
                    TweenModule:CameraCustomStart(Cam, HiveFolder[_G.PData.BaseFakeSettings.HiveNumberOwner].Camera)

                    local function CameraSlot()
                        local number = Mouse.Target.Parent.Name
                        if Mouse.Target.Name == "Down" and CameraSlotH then
                            local CameraTypeSlot =  HiveFolder[_G.PData.BaseFakeSettings.HiveNumberOwner].Slots[Mouse.Target.Parent.Name].Down.CameraSlot
                            TweenModule:CameraCustomStop(Cam, CameraTypeSlot.WorldCFrame) 
                        end
                    end

                    Mouse.Button1Down:Connect(CameraSlot)
                    task.spawn(function() -- Highlight slot
                        Mouse.Move:Connect(function()
                            if not Mouse.Target then script.Highlight.Adornee = nil return end
            
                            if CollectionService:HasTag(Mouse.Target, "Highlight") and SlotHight then
                                if HiveFolder[_G.PData.BaseFakeSettings.HiveNumberOwner].Slots[Mouse.Target.Parent.Name] then
                                    local Up =  HiveFolder[_G.PData.BaseFakeSettings.HiveNumberOwner].Slots[Mouse.Target.Parent.Name].Up
                                    if Mouse.Target.Name == "Down" then
                                            script.Highlight.Adornee = Up
                                        return
                                    else
                                            script.Highlight.Adornee = nil
                                        return
                                    end
                                end
                                return
                            end
                        end)
                    end)

                end
                
            elseif input.KeyCode == Enum.KeyCode.Q and _G.PData.BaseFakeSettings.OpenCameraCustomHive then
                SlotHight = false
                CameraSlotH = false
                script.Highlight.Adornee = nil
                _G.PData.BaseFakeSettings.OpenCameraCustomHive = false
                TweenModule:CloseGuiButton(PlayerGui.UIs.CloseCameraHive)
                TweenModule:CameraCustomStop(Cam,CamOriginal)
                task.wait(0.1)
                Cam.CameraType = Enum.CameraType.Custom
                Controls:Enable()
            end
        end
    end)
end)

task.spawn(function()
    task.wait()
    coroutine.wrap(function()
        for _, btn in next, PlayerGui:FindFirstChild('UIs'):WaitForChild('CloseCameraHive'):GetChildren() do
            if btn.Name == "FrameText" or btn.Name == "Button" then
                --! добавить по нажатию
                local buttonSizeX = btn.Size.X.Scale
                local buttonSizeY = btn.Size.Y.Scale
    
                btn.MouseEnter:Connect(function()
                    local newSizeX = (buttonSizeX + 0.02) --// Change this to what you like
                    local newSizeY = (buttonSizeY + 0.02) --// Change this to what you like
    
                    local info = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
                    TweenService:Create(btn, info, {Size = UDim2.new(newSizeX, 0, newSizeY, 0)}):Play()
                end)
    
                btn.MouseLeave:Connect(function()
                    local info = TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.In)
                    TweenService:Create(btn, info, {Size = UDim2.new(buttonSizeX, 0, buttonSizeY, 0)}):Play()
                end)
            end
        end
    end)()
end)

function HiveOwnerCheck()
    for _, index in next, HiveFolder:GetChildren() do
        
        local function Touched(hit)
            if Player.Character == hit.Parent then

                if StartHive == false then
                    StartHive = true
                    Remotes.HiveSpawnSlot:FireServer(index)
                    _G.PData.BaseFakeSettings.HiveOwner = Player.Name
                    _G.PData.BaseFakeSettings.HiveNumberOwner = index.name
                end

                Remotes.HiveOwner:FireServer(index)
            end
        end

        index.HivePlatform.Up.Touched:Connect(Touched)
    end
end

return HiveModule
