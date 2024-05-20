local SoundService = game:GetService("SoundService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local TweenModule = require(ReplicatedStorage.Libary.TweenModule)

local QuestModule = {}

function QuestModule:CheckNPC(Button)
    if Button.QuestNPC.Value == "Snail" then
        print('Snail')
       -- ButtonCam = Button.ShopOBJ.Value
        --ShopModule:ShopMini(Button)
    end
end

function QuestModule:StartModule(input) -- тут еще бесконечный цикл (Нужно придумать как цикл останавливать почить на дефорумах)
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

return QuestModule