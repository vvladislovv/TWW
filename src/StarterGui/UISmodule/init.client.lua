local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local Utils = require(ReplicatedStorage.Libary.Utils)
local ModuleDop = require(script.ModuleDop)

_G.PData = game.ReplicatedStorage.Remotes.GetDataSave:InvokeServer()


task.spawn(function()
    game.ReplicatedStorage.Remotes.DataUpdate.OnClientEvent:Connect(function(key, value)
        _G.PData[key] = value
		if key == 'IStats'then

            script.Parent.UIs.Coin.Frame.Frame.TextLabel.Changed:Connect(function(property)
                if property == "Text" then
                    TweenService:Create(script.Parent.UIs.Coin, TweenInfo.new(0.3,Enum.EasingStyle.Elastic,Enum.EasingDirection.Out),{Rotation = script.Parent.UIs.Coin.Rotation + math.random(-3,3)}):Play()
                end
            end)

            if _G.PData.Settings.CoinGuiAdd then
                script.Parent.UIs.Coin.Frame.Frame.TextLabel.Text = Utils:Addprefixes(_G.PData.IStats.Coin)
            else
                script.Parent.UIs.Coin.Frame.Frame.TextLabel.Text = Utils:CommaNumber(_G.PData.IStats.Coin)
            end
            task.wait(1)
            TweenService:Create(script.Parent.UIs.Coin, TweenInfo.new(0.3,Enum.EasingStyle.Elastic,Enum.EasingDirection.Out),{Rotation = 0}):Play()
        end
    end)

    if _G.PData.Settings.CoinGuiAdd then
        script.Parent.UIs.Coin.Frame.Frame.TextLabel.Text = Utils:Addprefixes(_G.PData.IStats.Coin)
    else
        script.Parent.UIs.Coin.Frame.Frame.TextLabel.Text = Utils:CommaNumber(_G.PData.IStats.Coin)
    end
end)

task.spawn(function()
    game.ReplicatedStorage.Remotes.DataUpdate.OnClientEvent:Connect(function(key, value)
        _G.PData[key] = value
        if key == 'IStats'then

            script.Parent.UIs.Pollen.CanvasGroup.TextLabel.Changed:Connect(function(property)
                if property == "Text" then
                    TweenService:Create(script.Parent.UIs.Pollen, TweenInfo.new(0.3,Enum.EasingStyle.Elastic,Enum.EasingDirection.Out),{Rotation = script.Parent.UIs.Pollen.Rotation + math.random(-3,3)}):Play()
                end
            end)

            if _G.PData.Settings.PollenGuiAdd then
                script.Parent.UIs.Pollen.CanvasGroup.TextLabel.Text = Utils:Addprefixes(_G.PData.IStats.Pollen)..'/'..Utils:Addprefixes(_G.PData.IStats.Capacity)
            else
                script.Parent.UIs.Pollen.CanvasGroup.TextLabel.Text = Utils:CommaNumber(_G.PData.IStats.Pollen)..'/'..Utils:CommaNumber(_G.PData.IStats.Capacity)
            end
            task.wait(1)
            TweenService:Create(script.Parent.UIs.Pollen, TweenInfo.new(0.3,Enum.EasingStyle.Elastic,Enum.EasingDirection.Out),{Rotation = 0}):Play()

        end
    end)

    task.spawn(function()--{0, 0},{0.85, 0} -- нужно сделать нормально
        while true do
            task.wait()
			ModuleDop:Update(script.Parent.UIs.Pollen.CanvasGroup.Frame)
        end
    end)

    if _G.PData.Settings.PollenGuiAdd then
        script.Parent.UIs.Pollen.CanvasGroup.TextLabel.Text = Utils:Addprefixes(_G.PData.IStats.Pollen)..'/'..Utils:Addprefixes(_G.PData.IStats.Capacity)
    else
        script.Parent.UIs.Pollen.CanvasGroup.TextLabel.Text = Utils:CommaNumber(_G.PData.IStats.Pollen)..'/'..Utils:CommaNumber(_G.PData.IStats.Capacity)
    end

        
end)