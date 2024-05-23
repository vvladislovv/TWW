local ReplicatedStorage = game:GetService("ReplicatedStorage")

local TweenModule = require(ReplicatedStorage.Libary.TweenModule)
local ModuleTable = require(ReplicatedStorage.Modules.ModuleTable)
local Nofical = false
local NofficalModule = {}


function NofficalModule:NofficalCreate(OBJ,Text,ColorIndex,icon,items)
    if not Nofical then
        Nofical = true
        if icon and items ~= nil then
            OBJ.FrameImage.Frame2.Image = ModuleTable.TokenTables.TokenGame[items].Image
            OBJ.FrameImage.Frame2.BackgroundColor3 = ModuleTable.ColorTable.Noffical["Color"..ColorIndex][1]
            OBJ.FrameMain.BackgroundColor3 = ModuleTable.ColorTable.Noffical["Color"..ColorIndex][1] 
            OBJ.FrameMain.Frame2.BackgroundColor3 = ModuleTable.ColorTable.Noffical["Color"..ColorIndex][2]
            OBJ.FrameMain.Frame2.TextButton.Text = Text
            TweenModule:NofficalUp(OBJ,icon)
            task.wait(3)
            TweenModule:NofficalDown(OBJ)
            Nofical = false
        else
            OBJ.FrameMain.BackgroundColor3 = ModuleTable.ColorTable.Noffical["Color"..ColorIndex][1] 
            OBJ.FrameMain.Frame2.BackgroundColor3 = ModuleTable.ColorTable.Noffical["Color"..ColorIndex][2]
            OBJ.FrameMain.Frame2.TextButton.Text = Text
            TweenModule:NofficalUp(OBJ,icon)
            task.wait(3)
            TweenModule:NofficalDown(OBJ)
            Nofical = false
        end
    end
end

return NofficalModule