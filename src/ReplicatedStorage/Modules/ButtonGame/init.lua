local MobuleButton = {}

local Player = game:GetService("Players").LocalPlayer
local SoundService = game:GetService("SoundService")
local character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = character:WaitForChild('Humanoid')
local HumRootPart = character:WaitForChild("HumanoidRootPart")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = ReplicatedStorage:WaitForChild('Remotes')
local UserInputService = game:GetService("UserInputService")
local TweenModule = require(ReplicatedStorage.Libary.TweenModule)

local SoundIndicator = true
local SoundIndicator2 = true

_G.PData = Remotes.GetDataSave:InvokeServer()

local TableButton = {
    Hives = {
        Hive1 = false,
        Hive2 = false,
        Hive3 = false,
        Hive4 = false,
        Hive5 = false,
        Hive6 = false,
    },
    Shop = false,
    Quest = false
}


function DistationButton(Button,Distation)
    if Distation < 10 then
        --SoundService.OpenButton:Play()
            if Button.Name == "Shop" then
                TweenModule:OpenButton(Button.B)
                TableButton.Shop = true
            elseif Button.Name == "Quest" then
                TweenModule:OpenButton(Button.B)
                TableButton.Quest = true
            elseif workspace.Map.GameSettings.Hives[Button.Name].Owner.Value == "" and _G.PData.BaseFakeSettings.HiveOwner == "" then
                _G.Button = Button
                TweenModule:OpenButton(Button.B)
                TableButton.Hives[Button.Name] = true
            elseif workspace.Map.GameSettings.Hives[Button.Name].Owner.Value ~= "" and _G.PData.BaseFakeSettings.HiveOwner ~= nil then
                _G.Button = Button
                TweenModule:OpenButton(Button.B)
                TableButton.Hives[Button.Name] = true
            end

    elseif Distation > 10 then
        --SoundService.CloseButton:Play()
            TweenModule:CloseButton(Button.B)
            if Button.Name == "Shop" then
                TableButton.Shop = false
            elseif Button.Name == "Quest" then
                TableButton.Quest = false
            elseif Button.Name ~= Button then
                TableButton.Hives[Button.Name] = false
               -- Button.B.Enabled = false
            end    
    end
end


function KeyCode(input, GPE)
    if not GPE  then
        if input.KeyCode == Enum.KeyCode.E then
            if _G.Button ~= nil then
                if TableButton.Hives[_G.Button.Name] then
                    require(ReplicatedStorage.Modules.HiveModule):StatModule(input)
                end
            end
            if TableButton.Shop then
                require(ReplicatedStorage.Modules.ShopModule):StartModule(input)
            elseif TableButton.Quest then
                require(ReplicatedStorage.Modules.QuestModule):StartModule(input)
            end
        end
    end
end

UserInputService.InputBegan:Connect(KeyCode)

ReplicatedStorage.Remotes.ButtonClient.OnClientEvent:Connect(DistationButton)

return MobuleButton