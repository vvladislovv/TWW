local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remotes = ReplicatedStorage:WaitForChild('Remotes')
local Data = require(game.ServerScriptService.ServerScript.Data)
local ZonePlus = require(game.ReplicatedStorage.Zone)
local FieldModule = {}

	FieldModule.MaxSize = 4
	FieldModule.Flowers = {}
	FieldModule.Fields = {
		["Banana"] = {
			Flowers = {
				MiniWhite = {1, 50},
				DoubleWhite = {1, 40},
                TripleWhite ={0,0},

				MiniPupler = {1, 3},
				DoublePupler = {1, 5},
                TriplePupler ={0,0},

				MiniBlue = {1, 6},
				DoubleBlue = {1, 5},
                TripleBlue ={0,0}
			}
		},
		["Blueberries"] = {
			Flowers = {
				MiniWhite = {1, 50},
				DoubleWhite = {1, 40},
                TripleWhite ={0,0},

				MiniPupler = {1, 3},
				DoublePupler = {1, 5},
                TriplePupler ={0,0},

				MiniBlue = {1, 6},
				DoubleBlue = {1, 5},
                TripleBlue ={0,0}
			}
		},
		["Pear"] = {
			Flowers = {
				MiniWhite = {1, 50},
				DoubleWhite = {1, 40},
                TripleWhite ={0,0},

				MiniPupler = {1, 3},
				DoublePupler = {1, 5},
                TriplePupler ={0,0},

				MiniBlue = {1, 6},
				DoubleBlue = {1, 5},
                TripleBlue ={0,0}
			}
		},
	}
	
	FieldModule.Correspondant = {
		["BananaPath1"] = "Banana",
        ["BananaPath2"] = "Banana",
        ["BananaPath3"] = "Banana",

		['BlueberriesPath1'] = "Blueberries",
		['BlueberriesPath2'] = "Blueberries",

		['PearParth1'] = "Pear",
	}
	
	FieldModule.FlowerTypes = {
		Blue = {
			["1"] = "rbxassetid://16804666619",
            ["2"] = "rbxassetid://16804670208",
            ["3"] = "rbxassetid://16804672980",
		},
		Pupler = {
			["1"] = "rbxassetid://16804647138",
            ["2"] = "rbxassetid://16804650053",
            ["3"] = "rbxassetid://16804651100",
		},
		White = {
            ["1"] = "rbxassetid://16791144157",
            ["2"] = "rbxassetid://16804620887",
            ["3"] = "rbxassetid://16804623294",
		}
	}

	function GetFlowerType(FlowerName)
		local Type = {}
		if string.find(FlowerName, "Mini") then
			Type["Value"] = "1"
		elseif string.find(FlowerName, "Double") then
			Type["Value"] = "2"
		elseif string.find(FlowerName, "Triple") then
			Type["Value"] = "3"
		end

		if string.find(FlowerName, "Pupler") then
			Type["Color"] = "Pupler"
		elseif string.find(FlowerName, "Blue") then
			Type["Color"] = "Blue"
		elseif string.find(FlowerName, "White") then
			Type["Color"] = "White"
		end

		Type["Texture"] = FieldModule.FlowerTypes[FlowerName]
		return Type
	end

	--! NumberRandom --
	function GetRandomFlower(FieldName)
		local MainTable, Number = {}, 0
		for _,imd in pairs(FieldModule.Fields[FieldName].Flowers) do
			local v = imd[math.random(1,2)]
			if v > 0 then
				Number = Number + v
				MainTable[#MainTable + 1] = { v + Number, _ }
			end
		end

		local RandomNumber = math.random(0, Number)

		for _,v in pairs(MainTable) do
			if RandomNumber <= v[1] then
				return v[2]
			end
		end

		return nil
	end
	
	function FieldModule:RegisterFlower(Flower)
		local FlowerParentName = Flower.Parent.Name
		local FlowerType = GetFlowerType(GetRandomFlower(FieldModule.Correspondant[FlowerParentName]))
		local FlowerID = Flower:FindFirstChild("FlowerID")
		local FlowerColor = FlowerType.Color
		local ID = #FieldModule.Flowers + 1
		FlowerID.Value = ID
		FieldModule.Flowers[ID] = {
			Color = FlowerColor,
			Stat = FlowerType,
			MaxP = Flower.Position.Y,
			MinP = Flower.Position.Y - 2,
			RegenFlower = 0.3,
		}
		local Color = FieldModule.Flowers[ID].Color
		local Number = FieldModule.Flowers[ID].Stat.Value
		Flower.TopTexture.Texture = FieldModule.FlowerTypes[Color][Number]
	end

	function FieldModule:GenerateFlower(Field, Position)
		local Flower = script.Flower:Clone()
		Flower.Parent = Field
		Flower.CFrame = Position

		local orientations = {Vector3.new(0, 90, 0), Vector3.new(0, 180, 0),Vector3.new(0, -90, 0), Vector3.new(0, -180, 0)}
		Flower.Orientation = orientations[math.random(1, 4)]

		FieldModule:RegisterFlower(Flower)
	end
    --! GetField --
    function FieldModule:GetField(Field)
        if game:GetService("RunService"):IsServer() then
            return FieldModule
        else
            return Remotes.GetField:InvokeServer()
        end
    end
    
    Remotes.GetField.OnServerInvoke = function(client)
        local PData = FieldModule:GetField(client)
        return PData
    end

	--! Generate --
    task.spawn(function()
        task.wait()
        for i, Fieldfolder in pairs(workspace.Map.GameSettings.FieldStudio:GetChildren()) do
            for i, Zone in pairs(Fieldfolder:GetChildren()) do
                if Zone:IsA("Part") then
                    local Field = Instance.new("Folder", workspace.Map.GameSettings.Fields)
                        Field.Name = Zone.Parent.Name
                        Zone.Transparency = 1
    
                        local halfX = (Zone.Size.X / 2) - 1
                        local halfZ = (Zone.Size.Z / 2) - 1
                        local step = 4
    
                        for x = Zone.Position.X - halfX, Zone.Position.X + halfX, step do
                            for z = Zone.Position.Z - halfZ, Zone.Position.Z + halfZ, step do
                                FieldModule:GenerateFlower(Field, CFrame.new(x, Zone.Position.Y, z))
                            end
                        end
                end
            end
        end
    end)


return FieldModule


