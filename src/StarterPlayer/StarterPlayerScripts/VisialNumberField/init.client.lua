
local Rs = game:GetService("ReplicatedStorage")
local VisEv = Rs.Remotes.VisualNumber
local TextPollen = Rs.Assert.Visual
local Player = game.Players.LocalPlayer
local TS = game:GetService("TweenService")
local Utils = require(Rs.Libary.Utils)
local TweenModule = require(Rs.Libary.TweenModule)

local TableCollers = { 
	Coin = Color3.fromRGB(255, 195, 75),
	Crit = Color3.fromRGB(160, 0, 255),
	Damage = Color3.fromRGB(255, 43, 47),

	White = Color3.fromRGB(255, 255, 255),
	Pupler = Color3.fromRGB(240, 75, 255),
	Blue = Color3.fromRGB(43, 117, 255),
}

local function Crit(Text)
	task.spawn(function()
		local RotationAngle = 15
		local BasicColor = Text.TextColor3
		TS:Create(Text, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Rotation = RotationAngle}):Play()
		--TS:Create(Text, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {TextColor3 = TableCollers.Crit}):Play()
		task.wait(0.25)
		TS:Create(Text, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Rotation = -RotationAngle}):Play()
		--TS:Create(Text, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {TextColor3 = BasicColor}):Play()
		task.wait(0.25)
		TS:Create(Text, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Rotation = RotationAngle}):Play()
		--TS:Create(Text, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {TextColor3 = TableCollers.Crit}):Play()
		task.wait(0.25)
		TS:Create(Text, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Rotation = -RotationAngle}):Play()
		--TS:Create(Text, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {TextColor3 = BasicColor}):Play()
		task.wait(0.25)
		TS:Create(Text, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Rotation = RotationAngle}):Play()
		--TS:Create(Text, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {TextColor3 = TableCollers.Crit}):Play()
		task.wait(0.25)
		TS:Create(Text, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Rotation = -RotationAngle}):Play()
		--TS:Create(Text, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {TextColor3 = BasicColor}):Play()
		task.wait(0.25)
		TS:Create(Text, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Rotation = RotationAngle}):Play()
		--TS:Create(Text, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {TextColor3 = TableCollers.Crit}):Play()
		task.wait(0.25)
		TS:Create(Text, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Rotation = -RotationAngle}):Play()
		--TS:Create(Text, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {TextColor3 = BasicColor}):Play()
		task.wait(0.25)
		TS:Create(Text, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Rotation = RotationAngle}):Play()
		--TS:Create(Text, TweenInfo.new(0.25, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {TextColor3 = TableCollers.Crit}):Play()
		task.wait(0.25)
	end)
end

local HoneyPos = 0
local DanagePos = 0

function GetLocation(VP)
	for Count = 1,2 do
		for i,v in workspace.Map.GameSettings.GameOnline.TextPollen:GetChildren() do
			for d, l in next, workspace.Map.GameSettings.GameOnline.TextPollen:GetChildren() do
				if l ~= v then
					if (v.Position - l.Position).Magnitude <= 0.5 then --  Следующая позиция после первой текста 
						if  tonumber(l.Name) > tonumber(v.Name) then
							l.Position = v.Position + Vector3.new(0,v.BillboardGui.Size.Height.Scale,0)
						else
							l.Position = v.Position + Vector3.new(0,v.BillboardGui.Size.Height.Scale,0)
						end
					end
				end
			end
		end
	end
end

local function GetSize(Amount, Crit)
	local SizeValue = 0

	if Amount <= 100 then
		SizeValue = 2
	elseif Amount > 1000 then
		SizeValue = 4
	elseif Amount > 10000 then
		SizeValue = 5
	end
	if Crit and Crit == true and _G.PData then
		SizeValue = 1.5 -- (_G.PData.Boost.PlayerBoost["Critical Power"])
	end
	return UDim2.fromScale(SizeValue, SizeValue / 2)
end

local function ray(VP)
	local ray = RaycastParams.new()
	ray.FilterDescendantsInstances = {game.Workspace.Map.GameSettings.Fields}
	ray.FilterType = Enum.RaycastFilterType.Include
	local raycast = workspace:Raycast(VP.Position, Vector3.new(0,-100,0), ray)
	if raycast and raycast.Instance then
		local Hit = raycast.Instance
		if Hit.Name == "Flower" then
			VP.Position = Vector3.new(Hit.Position.X, VP.Position.Y, Hit.Position.Z)
		end
	end
end

VisEv.OnClientEvent:Connect(function(Tab)
	local VP = TextPollen:Clone()
	local Character = game.Workspace:FindFirstChild(Player.Name)
	VP.Parent = workspace.Map.GameSettings.GameOnline.TextPollen
	VP.BillboardGui.TextPlayer.Size = UDim2.new(0,0,0,0)
    TweenModule:SizeUp(VP)
	VP.BillboardGui.Size = GetSize(Tab.Amt, Tab.Crit)
	VP.Name = Tab.Amt
	if Tab.Color ~= "Coin" and Tab.Color ~= "Damage" then
		if Tab.Pos then
			if typeof(Tab.Pos) == "Vector3" then
				VP.Position = Tab.Pos
			else
				VP.Position = Tab.Pos.Position
			end
		else
			VP.Position = Character.PrimaryPart.Position
		end
		VP.Position += Vector3.new(0,2,0)
		ray(VP)
		local rand = math.random(1, Tab.Amt)
		if rand > 750 then
			Crit(VP.BillboardGui.TextPlayer)
		end
		VP.BillboardGui.TextPlayer.Text = "+"..Utils:CommaNumber(Tab.Amt)
		VP.BillboardGui.TextPlayer.TextColor3 = TableCollers[Tab.Color]
		GetLocation(VP)
	elseif Tab.Color == "Coin" then
		VP.Parent = workspace.FolderTextPollen
		VP.Position = Character.PrimaryPart.Position + Vector3.new(0,5+HoneyPos,0)
		VP.BillboardGui.TextPlayer.Text = "+"..Utils:CommaNumber(Tab.Amount)
		VP.BillboardGui.TextPlayer.TextColor3 = TableCollers.Coin
		HoneyPos += VP.BillboardGui.Size.Height.Scale
		if HoneyPos > 3 then
			HoneyPos = 0
		end
	end

	task.wait(0.5)
    TweenModule:SizeDown(VP)
	task.wait(1)
	VP:Destroy()
end)
