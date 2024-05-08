local ModuleDop = require(script.ModuleDop)

_G.PData = game.ReplicatedStorage.Remotes.GetDataSave:InvokeServer()


task.spawn(function()
    game.ReplicatedStorage.Remotes.DataUpdate.OnClientEvent:Connect(function(key, value)
        _G.PData[key] = value
		if key == 'IStats'then

			script.Parent.UIs.Coin.Frame.Frame.TextLabel.Text = _G.PData.IStats.Coin
        end
    end)

    script.Parent.UIs.Coin.Frame.Frame.TextLabel.Text = _G.PData.IStats.Coin
end)

task.spawn(function()
    game.ReplicatedStorage.Remotes.DataUpdate.OnClientEvent:Connect(function(key, value)
        _G.PData[key] = value
        if key == 'IStats'then
			script.Parent.UIs.Pollen.CanvasGroup.TextLabel.Text = _G.PData.IStats.Pollen..'/'.._G.PData.IStats.Capacity
        end
    end)

    task.spawn(function()--{0, 0},{0.85, 0} -- нужно сделать нормально
        while true do
            task.wait()
			ModuleDop:Update(script.Parent.UIs.Pollen.CanvasGroup.Frame)
        end
    end)

    -- дописать красную штуку
    script.Parent.UIs.Pollen.CanvasGroup.TextLabel.Text = _G.PData.IStats.Pollen ..'/'.._G.PData.IStats.Capacity

        
end)