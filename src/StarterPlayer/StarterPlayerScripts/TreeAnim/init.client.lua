
local LeafFolder = workspace.Map.GameModel.Tree.Leaves
local Player = game:GetService("Players").LocalPlayer
local TweenService = game:GetService("TweenService")

task.spawn(function()
    task.wait()
	for _, LeafIndex in next, LeafFolder:GetChildren() do
		TweenService:Create(LeafIndex, TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, -1, true),{CFrame = LeafIndex.CFrame * CFrame.Angles(math.rad(math.random(-6,6)),math.rad(math.random(-6,6)),math.rad(math.random(-6,6)))}):Play()
	end
end)
