local ReplicatedStorage = game:GetService("ReplicatedStorage")

local TweenModule = require(ReplicatedStorage.Libary.TweenModule)
local ModuleTable = require(ReplicatedStorage.Modules.ModuleTable)
local Nofical = false
local NofficalModule = {}



function NofficalModule:NofficalCreate(OBJ,Text,ColorIndex)
    if not Nofical then
        Nofical = true
        OBJ.FrameColor.BackgroundColor3 = ModuleTable.ColorTable.Noffical["Color"..ColorIndex][1]
        OBJ.FrameColor.TextLabel.BackgroundColor3 = ModuleTable.ColorTable.Noffical["Color"..ColorIndex][2]
        OBJ.FrameColor.TextLabel.Text = Text
        TweenModule:NofficalUp(OBJ)
        task.wait(3)
        TweenModule:NofficalDown(OBJ)
        Nofical = false
    end
end

return NofficalModule