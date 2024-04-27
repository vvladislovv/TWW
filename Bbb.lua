local MobuleButton = {}

local Player = game:GetService("Players").LocalPlayer
local SoundService = game:GetService("SoundService")
local character = Player.Character or Player.CharacterAdded:Wait()
local HumRootPart = character.HumanoidRootPart

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local TweenModule = require(ReplicatedStorage.Libary.TweenModule)


local SoundIndicator = false
local SoundIndicator2 = false

local TableStart = {
    Hive = false,
    Shop = false,
}



function KeyCodeButton(Button,Distation)
    UserInputService.InputBegan:Connect(function(input, GPE)
        if not GPE  then
            if Distation < 10 then
                print(Distation)
                print(Button)
                if Button.Name == "Hive" then
                    print('fff')
                    for _, index in next, workspace.Map.GameSettings.Hives:GetChildren() do
                        if index.Owner.Value == "" or index.Owner.Value == Player.Name then
                            TweenModule:OpenButton(Button.B)
                            if TableStart.Hive then
                                TableStart.Hive = false
                                require(ReplicatedStorage.Modules.HiveModule):StatModule(Button)
                            end
                            
                            if SoundIndicator2 == false then
                                SoundService.OpenButton:Play()
                                SoundIndicator2 = true
                            end
                    
                            SoundIndicator = true
                        else
                            TweenModule:CloseButton(Button.B)
                        end
                    end
                elseif Button.Name == "Shop" then
                    TweenModule:OpenButton(Button.B)
                    if TableStart.Shop then
                        TableStart.Shop = false
                    end
                end

                if input.KeyCode == Enum.KeyCode.E then
                    TweenModule:OpenButton(Button.B)

                    task.spawn(function() -- IsKeyDown
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

                    print(Distation)
                    if Button.Name == "Hive" then
                        if TableStart.Hive then
                            require(ReplicatedStorage.Modules.HiveModule):StatModule(Button)
                            TableStart.Hive = false
                        end
                    elseif Button.Name == "Shop" then
                        if TableStart.Shop then
                            require(ReplicatedStorage.Modules.ShopModule):StartModule(Button)
                            TableStart.Shop = false
                        end
                    end

                end

            elseif Distation > 10 then
                if Button.Name == "Hive" then
                    TableStart.Hive = true
                    TweenModule:CloseButton(Button.B)
        
                    if SoundIndicator == true then
                        SoundService.CloseButton:Play()
                        SoundIndicator = false
                    end
        
                    SoundIndicator2 = false
                    --SoundService.CloseButton:Play()
                    --MobuleButton:HiveButton(TableButton.HiveButton)
                elseif Button.Name == "Shop" then
                    TableStart.Shop = true
                    TweenModule:CloseButton(Button.B)
                end
            end
        end
    end)
end

function DistationButton(DistationHRP,Button) -- надо придумать как пофиксить бак то что рядом стоит игрок, можно перенести с вапов прошлой из скрипта магазина    task.wait()
    if DistationHRP < 10 then  
        if Button.Name == "Hive" then
            for _, index in next, workspace.Map.GameSettings.Hives:GetChildren() do
                if index.Owner.Value == "" or index.Owner.Value == Player.Name then
                    TweenModule:OpenButton(Button.B)
                    if TableStart.Hive then
                        TableStart.Hive = false
                        require(ReplicatedStorage.Modules.HiveModule):StatModule(Button,DistationHRP)
                    end
                    if SoundIndicator2 == false then
                        SoundService.OpenButton:Play()
                        SoundIndicator2 = true
                    end
            
                    SoundIndicator = true
                else
                    TweenModule:CloseButton(Button.B)
                end
            end
        elseif Button.Name == "Shop"  then
            TweenModule:OpenButton(Button.B)
            if TableStart.Shop then
               TableStart.Shop = false
                require(ReplicatedStorage.Modules.ShopModule):StartModule(Button)
            end
        end
    elseif DistationHRP > 10 then
        if Button.Name == "Hive" then
            TableStart.Hive = true
            TweenModule:CloseButton(Button.B)

            if SoundIndicator == true then
                SoundService.CloseButton:Play()
                SoundIndicator = false
            end

            SoundIndicator2 = false
            --SoundService.CloseButton:Play()
            --MobuleButton:HiveButton(TableButton.HiveButton)
        elseif Button.Name == "Shop" then
            TableStart.Shop = true
            TweenModule:CloseButton(Button.B)
        end
    end
end

for _, Button in next, workspace.Map.GameSettings.Button:GetChildren() do
   -- _G.Button = Button
    --coroutine.resume(Distation, 1)
    local Distation = nil

    coroutine.wrap(function()
        while true do 
            task.wait()
            Distation = (Button.Position - HumRootPart.Position).Magnitude
            KeyCodeButton(Button,Distation)
        end
    end)()
end




return MobuleButton