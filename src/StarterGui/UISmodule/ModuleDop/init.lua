local ModuleDop = {}


function ModuleDop:Update(top)
    top:TweenSize(UDim2.new(math.clamp(_G.PData.IStats.Pollen / _G.PData.IStats.Capacity, 0, 1), 0, 1 , 0), Enum.EasingDirection.Out, Enum.EasingStyle.Sine, 0.25, true)
end

return ModuleDop