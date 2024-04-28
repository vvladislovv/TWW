local TweenService = game:GetService("TweenService")
local TweenModule = {}

local TweenInfo1 = TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out)

function TweenModule:OpenButton(Button)
    TweenService:Create(Button,TweenInfo1,{Size = UDim2.new(10,0,5, 0)}):Play()
end

function TweenModule:CloseButton(Button)
    TweenService:Create(Button,TweenInfo1,{Size = UDim2.new(0,0,0,0)}):Play()
end

function TweenModule:KeyCode(Button)
    TweenService:Create(Button,TweenInfo1,{Size = UDim2.new(8,0,4, 0)}):Play()
end

function TweenModule:SpawnHive(Hive)
    TweenService:Create(Hive.HiveModel, TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, 0, true), {Color = Color3.fromRGB(255, 255, 255)}):Play()
end

function TweenModule:StartShop(ShopFrame)
   TweenService:Create(ShopFrame.BuyButton,TweenInfo1,{Position = UDim2.new(0.444, 0,0.781, 0)}):Play()
   TweenService:Create(ShopFrame.DescriptionFrame,TweenInfo1,{Position = UDim2.new(0.084, 0,0.179, 0)}):Play() 
   TweenService:Create(ShopFrame.Left,TweenInfo1,{Position = UDim2.new(0.394, 0,0.784, 0)}):Play() 
   TweenService:Create(ShopFrame.Right,TweenInfo1,{Position = UDim2.new(0.576, 0,0.783, 0)}):Play() 
end

function TweenModule:FlowerDown(Flower,FlowerPos)
    TweenService:Create(Flower, TweenInfo.new(0.7, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Position = FlowerPos}):Play()
end

function TweenModule:RegenUp(Pollen,ToMaxFlower,InfoFieldGame,FlowerPos,FlowerPosTime)
    if ToMaxFlower < InfoFieldGame.RegenFlower then
        Pollen.ParticleEmitter.Enabled = false
        TweenService:Create(Pollen, TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Position = FlowerPos}):Play()
    else
        Pollen.ParticleEmitter.Enabled = false
        TweenService:Create(Pollen, TweenInfo.new(3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Position = FlowerPosTime}):Play()
    end
end

function TweenModule:StopShop(ShopFrame)
    TweenService:Create(ShopFrame.BuyButton,TweenInfo1,{Position = UDim2.new(0.444, 0,1.5, 0)}):Play()
    TweenService:Create(ShopFrame.DescriptionFrame,TweenInfo1,{Position = UDim2.new(-1, 0,0.179, 0)}):Play() 
    TweenService:Create(ShopFrame.Left,TweenInfo1,{Position = UDim2.new(0.394, 0,1.5, 0)}):Play() 
    TweenService:Create(ShopFrame.Right,TweenInfo1,{Position = UDim2.new(0.576, 0,1.5, 0)}):Play()
    TweenService:Create(ShopFrame.Ingrigient,TweenInfo1,{Position = UDim2.new(0.744, 0,-1, 0)}):Play()
end

function TweenModule:SpawnSlotHive(Hive,CheckSlot)
    local TweenInfoSlot = TweenInfo.new(1,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut)
    TweenService:Create(Hive.Slots[CheckSlot].Up, TweenInfoSlot, {Transparency = 0}):Play()
    TweenService:Create(Hive.Slots[CheckSlot].Down, TweenInfoSlot, {Transparency = 0.45}):Play()
    Hive.Slots[CheckSlot].Level.SurfaceGui.Enabled = true
    Hive.Slots[CheckSlot].Down.SurfaceGui.Enabled = true
    Hive.Slots[CheckSlot].Up.ParticleEmitter.Enabled = true
    task.wait(0.25)
    Hive.Slots[CheckSlot].Up.ParticleEmitter.Enabled = false
end

function TweenModule:DestroySlotHive(Hive,CheckSlot)
    local TweenInfoSlot = TweenInfo.new(1,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut)
    TweenService:Create(Hive.Slots[CheckSlot].Up, TweenInfoSlot, {Transparency = 1}):Play()
    TweenService:Create(Hive.Slots[CheckSlot].Down, TweenInfoSlot, {Transparency = 1}):Play()
    Hive.Slots[CheckSlot].Level.SurfaceGui.Enabled = false
    Hive.Slots[CheckSlot].Down.SurfaceGui.Enabled = false
end

function TweenModule:CameraCustomStart(Cam, CamCFrame)
    TweenService:Create(Cam, TweenInfo.new(0.6, Enum.EasingStyle.Linear,Enum.EasingDirection.InOut), {CFrame = CamCFrame.CFrame}):Play()
end
function TweenModule:CameraCustomStop(Cam, CamCFrame)
    TweenService:Create(Cam, TweenInfo.new(0.6, Enum.EasingStyle.Linear,Enum.EasingDirection.InOut), {CFrame = CamCFrame}):Play()
end

function TweenModule:OpenGuiButton(Button)
    TweenService:Create(Button, TweenInfo.new(0.5,Enum.EasingStyle.Back,Enum.EasingDirection.Out), {Position = UDim2.new(0.533, 0,0.917, 0)}):Play()
end

function TweenModule:CloseGuiButton(Button)
    TweenService:Create(Button, TweenInfo.new(1,Enum.EasingStyle.Back,Enum.EasingDirection.Out), {Position = UDim2.new(0.533, 0,1.5, 0)}):Play()
end

function TweenModule:NofficalUp(Button)
    TweenService:Create(Button, TweenInfo.new(1,Enum.EasingStyle.Back,Enum.EasingDirection.Out), {Position = UDim2.new(0.714, 0,0.905, 0)}):Play()
end

function TweenModule:NofficalDown(Button)
    TweenService:Create(Button, TweenInfo.new(1.5,Enum.EasingStyle.Back,Enum.EasingDirection.Out), {Position = UDim2.new(0.714, 0,1.5, 0)}):Play()
end

function TweenModule:TweenIngredients(Ingredients,ShopFrame) -- 0,0,0,0
	if Ingredients then
		TweenService:Create(ShopFrame.Ingrigient,TweenInfo1,{Position = UDim2.new(0.744, 0,0.207, 0)}):Play()
    elseif not Ingredients then
		TweenService:Create(ShopFrame.Ingrigient,TweenInfo1,{Position = UDim2.new(0.744, 0,-1, 0)}):Play()
	end
end

return TweenModule