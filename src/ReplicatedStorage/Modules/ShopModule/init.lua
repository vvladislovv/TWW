local Player = game:GetService("Players").LocalPlayer
local PlayerGui = Player:WaitForChild('PlayerGui')
local UIs = PlayerGui:WaitForChild('UIs')
local ShopFrame = UIs:WaitForChild('ShopFrame')
local PlayerScript = Player:WaitForChild("PlayerScripts")
local PlayerModule = require(PlayerScript:WaitForChild("PlayerModule"))
local Controls = PlayerModule:GetControls()

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SoundService = game:GetService("SoundService")
local UserInputService = game:GetService("UserInputService")
local Remotes = ReplicatedStorage:WaitForChild('Remotes')
local FolderCamers = workspace.Map.GameSettings.Shops
local TweenModule = require(ReplicatedStorage.Libary.TweenModule)
local ModuleTable = require(ReplicatedStorage.Modules.ModuleTable)


local Cam = game.Workspace.CurrentCamera
local CamOriginal = nil
local CameraNow = 0
local ButtonCam = nil
local ShopModule = {}

function ShopModule:CheckShop(Button)
    if Button.ShopOBJ.Value == "ShopMini" then
        ButtonCam = Button.ShopOBJ.Value
        ShopModule:ShopMini(Button)
    end
end

function ShopModule:StartModule(input) -- тут еще бесконечный цикл (Нужно придумать как цикл останавливать почить на дефорумах)
    for _, Button in next, workspace.Map.GameSettings.Button:GetChildren() do
        if Button.Name == "Shop" then

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

            ShopModule:CheckShop(Button) 
        end
    end
end


function ShopModule:ShopMini(Button)
    if not _G.PData.BaseFakeSettings.OpenCameraCustom then
        _G.PData.BaseFakeSettings.OpenCameraCustom = true
        Remotes.RemoteShop:FireServer(true)
        StartCamer(Button)
    else
        Remotes.RemoteShop:FireServer(false)
        CloseShop()
    end
end

function StartCamer(Button)
    CameraNow = 1
    GetItemShop(CameraNow)
    CamOriginal = Cam.CFrame
    Cam.CameraType = Enum.CameraType.Scriptable
    TweenModule:StartShop(ShopFrame)
    Controls:Disable()
    TweenModule:CameraCustomStart(Cam,workspace.Map.GameSettings.Shops[Button.ShopOBJ.Value].Camers.Cam1)
    _G.PData.BaseFakeSettings.OpenCameraCustom = true
end

function CloseShop()
    CameraNow = 1
    TweenModule:CameraCustomStop(Cam,CamOriginal)
    task.wait(0.1)
    Cam.CameraType = Enum.CameraType.Custom
    TweenModule:StopShop(ShopFrame)
    Controls:Enable()
    _G.PData.BaseFakeSettings.OpenCameraCustom = false
end


Remotes.UIShop.OnClientEvent:Connect(function()
    ShopFrame.BuyButton.Frame.Frame.TextButton.Text = "Equipped"
    ShopFrame.BuyButton.Frame.BackgroundColor3 = ModuleTable.ColorTable.Shops.Purchase[1]
    ShopFrame.BuyButton.Frame.Frame.BackgroundColor3 = ModuleTable.ColorTable.Shops.Purchase[2]
end)


function GetItemShop(CameraNow)
    local showIngredients = false
    local CameraType = workspace.Map.GameSettings.Shops[ButtonCam].Camers["Cam"..CameraNow]

    for NameIndex, GetIndex in next, ModuleTable.ItemsPlayer do
        if CameraNow == CameraType.Order.Value then
            if CameraType.Type.Value.."s" == NameIndex then
                if GetIndex[CameraType.ItemsName.Value] ~= nil then
                    local TableItems = GetIndex[CameraType.ItemsName.Value]
                    if TableItems.ShopBuy.Ingriends ~= nil then

                        for _, indexFrame in pairs(ShopFrame.Ingrigient.Frame.Frame:GetChildren()) do -- Проверка при каждом новом товаре
                            if indexFrame:IsA("Frame") then
                                indexFrame:Destroy()
                            end
                        end
                        for i, Tableindex in next, TableItems.ShopBuy.Ingriends do
                            showIngredients = true
                            local ItemsGuiAdd = ReplicatedStorage.Assert.ItemsGuiAdd:Clone()
                            ItemsGuiAdd.Parent = ShopFrame.Ingrigient.Frame.Frame
                            ItemsGuiAdd.Name = i
                            ItemsGuiAdd.Frame.Frame.ImageLabel.TextLabel.Text = "x"..Tableindex
                            if _G.PData.EquipmentShop[CameraType.Type.Value.."s"][CameraType.ItemsName.Value] == false then -- Equip
                                updateItemDisplay(TableItems, showIngredients)
                                ShopFrame.BuyButton.Frame.Frame.TextButton.Text = "Equip"
                                ShopFrame.BuyButton.Frame.BackgroundColor3 = ModuleTable.ColorTable.Shops.Equip[1]
                                ShopFrame.BuyButton.Frame.Frame.BackgroundColor3 = ModuleTable.ColorTable.Shops.Equip[2]

                                ShopFrame.BuyButton.Frame.Frame.TextButton.MouseButton1Click:Connect(function()
                                    local TextBuy = ShopFrame.BuyButton.Frame.Frame.TextButton.Text
                                    if _G.PData.EquipmentShop[CameraType.Type.Value.."s"][CameraType.ItemsName.Value] == false and CameraNow == CameraType.Order.Value and ShopFrame.BuyButton.Frame.Frame.TextButton.Text == "Equip" then
                                        ShopFrame.BuyButton.Frame.Frame.TextButton.Text = "Equipped"
                                        Remotes.BuyShop2:FireServer(TextBuy, TableItems.ShopBuy, CameraType,CameraNow,ModuleTable)
                                    end
                                end)

                            elseif _G.PData.EquipmentShop[CameraType.Type.Value.."s"][CameraType.ItemsName.Value] == true then -- Equipped
                                updateItemDisplay(TableItems, showIngredients)
                                ShopFrame.BuyButton.Frame.Frame.TextButton.Text = "Equipped"
                                ShopFrame.BuyButton.Frame.BackgroundColor3 = ModuleTable.ColorTable.Shops.Purchase[1]
                                ShopFrame.BuyButton.Frame.Frame.BackgroundColor3 = ModuleTable.ColorTable.Shops.Purchase[2]

                            elseif _G.PData.IStats.Coin == TableItems.ShopBuy.Cost and _G.PData.EquipmentShop[CameraType.Type.Value.."s"][CameraType.ItemsName.Value] == nil then -- Purchase
                                updateItemDisplay(TableItems, showIngredients)
                                ShopFrame.BuyButton.Frame.Frame.TextButton.Text = "Purchase"
                                ShopFrame.BuyButton.Frame.BackgroundColor3 = ModuleTable.ColorTable.Shops.Purchase[1]
                                ShopFrame.BuyButton.Frame.Frame.BackgroundColor3 = ModuleTable.ColorTable.Shops.Purchase[2]

                                ShopFrame.BuyButton.Frame.Frame.TextButton.MouseButton1Click:Connect(function()
                                    local TextBuy = ShopFrame.BuyButton.Frame.Frame.TextButton.Text
                                    ShopFrame.BuyButton.Frame.Frame.TextButton.Text = "Equipped"
                                    Remotes.BuyShop:FireServer(TextBuy, TableItems.ShopBuy, CameraType,CameraNow)
                                end)

                            elseif _G.PData.IStats.Coin ~= TableItems.ShopBuy.Cost and _G.PData.EquipmentShop[CameraType.Type.Value.."s"][CameraType.ItemsName.Value] == nil then -- No Purchase
                                updateItemDisplay(TableItems, showIngredients)
                                ShopFrame.BuyButton.Frame.BackgroundColor3 = ModuleTable.ColorTable.Shops.NoEquip[1]
                                ShopFrame.BuyButton.Frame.Frame.BackgroundColor3 = ModuleTable.ColorTable.Shops.NoEquip[2]
                                ShopFrame.BuyButton.Frame.Frame.TextButton.Text = "No Purchase"

                            end
                            if _G.PData.Inventory[i] == Tableindex then
                                ItemsGuiAdd.Frame.Frame.ImageLabel.TextLabel.TextColor3 = ModuleTable.ColorTable.Shops.Purchase[2]
                            elseif not _G.PData.Inventory[i] then
                                ItemsGuiAdd.Frame.Frame.ImageLabel.TextLabel.TextColor3 = ModuleTable.ColorTable.Shops.NoEquip[2]
                            elseif _G.PData.Inventory[i] > Tableindex then
                                ItemsGuiAdd.Frame.Frame.ImageLabel.TextLabel.TextColor3 = ModuleTable.ColorTable.Shops.Purchase[2]
                            else
                                ItemsGuiAdd.Frame.Frame.ImageLabel.TextLabel.TextColor3 = ModuleTable.ColorTable.Shops.NoEquip[2]
                            end
                        end
                    else
                        if _G.PData.EquipmentShop[CameraType.Type.Value.."s"][CameraType.ItemsName.Value] == false then -- Equip
                            updateItemDisplay(TableItems, showIngredients)
                           -- print(CameraType.ItemsName.Value)
                            ShopFrame.BuyButton.Frame.Frame.TextButton.Text = "Equip"
                            ShopFrame.BuyButton.Frame.BackgroundColor3 = ModuleTable.ColorTable.Shops.Equip[1]
                            ShopFrame.BuyButton.Frame.Frame.BackgroundColor3 = ModuleTable.ColorTable.Shops.Equip[2]
                            ShopFrame.BuyButton.Frame.Frame.TextButton.MouseButton1Click:Connect(function()
                                local TextBuy = ShopFrame.BuyButton.Frame.Frame.TextButton.Text
                                if _G.PData.EquipmentShop[CameraType.Type.Value.."s"][CameraType.ItemsName.Value] == false and CameraNow == CameraType.Order.Value and ShopFrame.BuyButton.Frame.Frame.TextButton.Text == "Equip" then
                                    --print(CameraType.ItemsName.Value)
                                    ShopFrame.BuyButton.Frame.Frame.TextButton.Text = "Equipped"
                                    Remotes.BuyShop2:FireServer(TextBuy, TableItems.ShopBuy, CameraType,CameraNow,ModuleTable)
                                end
                            end)

                        elseif _G.PData.EquipmentShop[CameraType.Type.Value.."s"][CameraType.ItemsName.Value] == true then -- Equipped
                            updateItemDisplay(TableItems, showIngredients)
                            ShopFrame.BuyButton.Frame.Frame.TextButton.Text = "Equipped"
                            ShopFrame.BuyButton.Frame.BackgroundColor3 = ModuleTable.ColorTable.Shops.Purchase[1]
                            ShopFrame.BuyButton.Frame.Frame.BackgroundColor3 = ModuleTable.ColorTable.Shops.Purchase[2]

                        elseif TableItems.ShopBuy.Cost <= _G.PData.IStats.Coin and _G.PData.EquipmentShop[CameraType.Type.Value.."s"][CameraType.ItemsName.Value] == nil and not _G.PData.Equipment[CameraType.ItemsName.Value] then -- Purchase
                            updateItemDisplay(TableItems, showIngredients)
                            ShopFrame.BuyButton.Frame.Frame.TextButton.Text = "Purchase"
                            ShopFrame.BuyButton.Frame.BackgroundColor3 = ModuleTable.ColorTable.Shops.Purchase[1]
                            ShopFrame.BuyButton.Frame.Frame.BackgroundColor3 = ModuleTable.ColorTable.Shops.Purchase[2]

                            ShopFrame.BuyButton.Frame.Frame.TextButton.MouseButton1Click:Connect(function()
                                local TextBuy = ShopFrame.BuyButton.Frame.Frame.TextButton.Text
                                if CameraNow == CameraType.Order.Value and ShopFrame.BuyButton.Frame.Frame.TextButton.Text == "Purchase" then
                                    ShopFrame.BuyButton.Frame.Frame.TextButton.Text = "Equipped"
                                    Remotes.BuyShop:FireServer(TextBuy, TableItems.ShopBuy, CameraType,CameraNow)
                                end
                            end)

                        elseif TableItems.ShopBuy.Cost ~= _G.PData.IStats.Coin and _G.PData.EquipmentShop[CameraType.Type.Value.."s"][CameraType.ItemsName.Value] == nil then -- No Purchase
                            updateItemDisplay(TableItems, showIngredients)
                            ShopFrame.BuyButton.Frame.BackgroundColor3 = ModuleTable.ColorTable.Shops.NoEquip[1]
                            ShopFrame.BuyButton.Frame.Frame.BackgroundColor3 = ModuleTable.ColorTable.Shops.NoEquip[2]
                            ShopFrame.BuyButton.Frame.Frame.TextButton.Text = "No Purchase"

                        end
                    end
                    updateItemDisplay(TableItems, showIngredients)
                end
            end
        end
    end

   -- надо подумать над реализацией
end

function LeftShopButton()
	if CameraNow >= #workspace.Map.GameSettings.Shops[ButtonCam].Camers:GetChildren() then
		CameraNow = 1
        GetItemShop(CameraNow)
    else
        CameraNow += 1
        GetItemShop(CameraNow)
	end

    TweenModule:CameraCustomStart(Cam,workspace.Map.GameSettings.Shops[ButtonCam].Camers["Cam"..CameraNow])
end


function RightShopButton()
	CameraNow -= 1
	if CameraNow <= 0 then
		CameraNow = #workspace.Map.GameSettings.Shops[ButtonCam].Camers:GetChildren()
        GetItemShop(CameraNow)
	end
    GetItemShop(CameraNow)
    TweenModule:CameraCustomStart(Cam,workspace.Map.GameSettings.Shops[ButtonCam].Camers["Cam"..CameraNow])
end

function updateItemDisplay(ItemsTable,showIngredients)
    TweenModule:TweenIngredients(showIngredients,ShopFrame)
    coroutine.wrap(function()
        task.wait()
        ShopFrame.DescriptionFrame.CostFrame.Frame.Frame.TextLabel.Text = ItemsTable.ShopBuy.Cost.." Coin"
        ShopFrame.DescriptionFrame.FrameDescpt.Frame.Frame.TextLabel.Text = ItemsTable.ShopBuy.Description
        ShopFrame.DescriptionFrame.FrameNameItms.Frame.Frame.TextLabel.Text = ItemsTable.ShopBuy.Name
    end)()
end

ShopFrame.Left.Frame.Frame.TextButton.MouseButton1Click:Connect(LeftShopButton)--LeftShopButton
ShopFrame.Right.Frame.Frame.TextButton.MouseButton1Click:Connect(RightShopButton)--RightShopButton

return ShopModule