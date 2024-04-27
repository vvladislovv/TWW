local MobuleButton = {}

local Player = game:GetService("Players").LocalPlayer
local SoundService = game:GetService("SoundService")
local character = Player.Character or Player.CharacterAdded:Wait()
local HumRootPart = character.HumanoidRootPart

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local TweenModule = require(ReplicatedStorage.Libary.TweenModule)

local SoundIndicator = true
local SoundIndicator2 = true

local TableButton = {
    Hive = false,
    Shop = false
}



function DistationButton(Button,Distation) -- 
    if Distation < 10 then
        --SoundService.OpenButton:Play()
        TweenModule:OpenButton(Button.B)
        if Button.Name == "Hive" then
            for _, index in next, workspace.Map.GameSettings.Hives:GetChildren() do
                if index.Owner.Value == "" or index.Owner.Value == Player.Name then
                    TableButton.Hive = true
                else
                    TweenModule:CloseButton(Button.B)
                end
            end
        elseif Button.Name == "Shop" then
            TableButton.Shop = true
        end

    elseif Distation > 10 then
        --SoundService.CloseButton:Play()
        TweenModule:CloseButton(Button.B)
        if Button.Name == "Hive" then
            TableButton.Hive = false

        elseif Button.Name == "Shop" then
            TableButton.Shop = false

        end
    end
end


function KeyCode(input, GPE)
    if not GPE  then
        if input.KeyCode == Enum.KeyCode.E then
            if TableButton.Hive then
                require(ReplicatedStorage.Modules.HiveModule):StatModule(input)
            elseif TableButton.Shop then
                require(ReplicatedStorage.Modules.ShopModule):StartModule(input)
            end
        end
    end
end

UserInputService.InputBegan:Connect(KeyCode)

for _, Button in next, workspace.Map.GameSettings.Button:GetChildren() do
     _G.Button = Button
     local Distation = nil
 
     coroutine.wrap(function() -- Смотрит растояние
        while true do
            task.wait()
            Distation = (Button.Position - HumRootPart.Position).Magnitude
            _G.Dis = Distation
            DistationButton(Button,Distation) -- Передаю в другую функциию
        end
     end)()
 end

return MobuleButton