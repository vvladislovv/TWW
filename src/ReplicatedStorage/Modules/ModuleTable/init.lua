local TableModuel = {} do
    
    TableModuel.Rarity = {
        ["★"] = {[1] = "Сommon", [2] = Color3.fromRGB(148, 102, 50)}, 
        ["★★"] = {[1] = "Rare", [2] = Color3.fromRGB(126, 126, 126)},
        ["★★★"] = {[1] = "Unusual", [2] = Color3.fromRGB(150, 107, 104)},
        ["★★★★"] = {[1] = "Epic",[2] = Color3.fromRGB(86, 46, 143)}, 
        ["★★★★★"] = {[1] = "Legandary",[2] = Color3.fromRGB(53, 113, 138)},
        ["★★★★★★"] = {[1] = "Mystical",[2] = Color3.fromRGB(150, 101, 142)},
        ["★★★★★★★"] = {[1] = "Event",[2] = Color3.fromRGB(48, 143, 86)},
        ["★★★★★★★★"] = {[1] = "Special",[2] = Color3.fromRGB(150, 78, 79)},
    }

    TableModuel.LevelWasp = {
        [1] = 125,
        [2] = 375,
        [3] = 695,
        [4] = 1200,
        [5] = 1900,
        [6] = 2750,
        [7] = 4650,
        [8] = 6075,
        [9] = 7950,
        [10] = 11500,
        [11] = 19950,
        [12] = 27950,
        [13] = 45000,
        [14] = 90000,
        [15] = 250000,
        [16] = 500000,
        [17] = 1200000,
        [18] = 4000000,
        [19] = 12000000,
        [20] = 35000000,
    }

    TableModuel.Wasp = {
        ['Wasp1'] = {
            Icon = "rbxassetid://17180421548",
            Rarity = "★",
            Color = "Colorless",
            Ability = "",
            AbilitySuper = "",
            Energy = 20,
            AnimFly = "",
            Speed = 8,
            Attack = 3,
            Pollen = 15,
            Converts = 100,
            CollectTime = 0.5,
            ConvertsTime = 0.5,
            FavoriteFood = ""
        },
        ['Wasp2'] = {
            Icon = "rbxassetid://17180399814",
            Rarity = "★★",
            Color = "Colorless",
            Ability = "",
            AbilitySuper = "",
            Energy = 20,
            AnimFly = "",
            Speed = 8,
            Attack = 3,
            Pollen = 15,
            Converts = 100,
            CollectTime = 0.5,
            ConvertsTime = 0.5,
            FavoriteFood = ""
        },
        ['Wasp3'] = {
            Icon = "rbxassetid://17180388767",
            Rarity = "★★★",
            Color = "Colorless",
            Ability = "",
            AbilitySuper = "",
            Energy = 20,
            AnimFly = "",
            Speed = 8,
            Attack = 3,
            Pollen = 15,
            Converts = 100,
            CollectTime = 0.5,
            ConvertsTime = 0.5,
            FavoriteFood = ""
        },
        ['Wasp4'] = {
            Icon = "rbxassetid://17180394950",
            Rarity = "★★★★",
            Color = "Colorless",
            Ability = "",
            AbilitySuper = "",
            Energy = 20,
            AnimFly = "",
            Speed = 8,
            Attack = 3,
            Pollen = 15,
            Converts = 100,
            CollectTime = 0.5,
            ConvertsTime = 0.5,
            FavoriteFood = ""
        },
        ['Wasp5'] = {
            Icon = "rbxassetid://17180412078",---rbxassetid://17180406585
            Rarity = "★★★★★★★★",
            Color = "Colorless",
            Ability = "",
            AbilitySuper = "",
            Energy = 20,
            AnimFly = "",
            Speed = 8,
            Attack = 3,
            Pollen = 15,
            Converts = 100,
            CollectTime = 0.5,
            ConvertsTime = 0.5,
            FavoriteFood = ""
        },
        ['Wasp6'] = {
            Icon = "rbxassetid://17180406585",
            Rarity = "★★★★★★★★",
            Color = "Colorless",
            Ability = "",
            AbilitySuper = "",
            Energy = 20,
            AnimFly = "",
            Speed = 8,
            Attack = 3,
            Pollen = 15,
            Converts = 100,
            CollectTime = 0.5,
            ConvertsTime = 0.5,
            FavoriteFood = ""
        }
    }
    TableModuel.ColorTable = {
        Noffical = {
            Color1 = {[1] = Color3.fromRGB(213, 14, 18),[2] = Color3.fromRGB(194, 13, 19)}, -- Red
            Color2 = {[1] = Color3.fromRGB(28, 112, 185),[2] = Color3.fromRGB(32, 129, 208)}, -- Blue
            Color3 = {[1] = Color3.fromRGB(213, 131, 32),[2] = Color3.fromRGB(195, 118, 29)}, -- Orange
            Color4 = {[1] = Color3.fromRGB(85, 103, 185),[2] = Color3.fromRGB(64, 78, 140)}, -- Pupler
            Color5 = {[1] = Color3.fromRGB(79, 154, 29),[2] = Color3.fromRGB(92, 179, 34)} -- Green
        },
        Shops = {
            Purchase = {[1] = Color3.fromRGB(78, 220, 87), [2] = Color3.fromRGB(90, 255, 98)},
            Equip = {[1] = Color3.fromRGB(220, 193, 42), [2] = Color3.fromRGB(255, 221, 49)}, -- Изменить
            NoEquip = {[1] = Color3.fromRGB(200, 0, 7), [2] = Color3.fromRGB(226, 0, 8)}
        }
    }

    TableModuel.ItemsPlayer = {
        Tools = {
            ['Shovel'] = {
                Type = 'PlayerData',
                Coouldown = 0.2,
                SpeedCoper = 0.75,
                Collecting = 12,
                Stamp = "2x1",
                ColorTools = "None",
                AnimTools = "",


                ShopBuy = {
                    Name = 'Shovel',
                    ShopType = "ShopMini",
                    Cost = 0,
                    Description = "",
                    Ingriends = nil,
                },

                GuiItems = "rbxassetid://17180412078",

            },
            ['Hammer'] = {
                Type = 'PlayerData',
                Coouldown = 0.2,
                SpeedCoper = 0.75,
                Collecting = 80,
                Stamp = "2x1",
                ColorTools = "None",
                AnimTools = "",


                ShopBuy = {
                    Name = 'Hammer',
                    ShopType = "ShopMini",
                    Cost = 18500,
                    Description = "",
                    Ingriends = {
                        ['Waspik Egg'] = 1,
                        ['Strabbery'] = 15,
                        ['Send'] = 15,
                    },
                },

                GuiItems = "rbxassetid://17180412078",

            },
            ['Scissors'] = {
                Type = 'PlayerData',
                Coouldown = 0.45,
                SpeedCoper = 0.75,
                Collecting = 25,
                Stamp = "2x1",
                ColorTools = "None",
                AnimTools = "",


                ShopBuy = {
                    Name = 'Scissors',
                    ShopType = "ShopMini",
                    Cost = 2350,
                    Description = "",
                    Ingriends = nil
                },

                GuiItems = "rbxassetid://17180412078",

            },
            ['Casa'] = {
                Type = 'PlayerData',
                Coouldown = 0.2,
                SpeedCoper = 0.75,
                Collecting = 45,
                Stamp = "2x1",
                ColorTools = "None",
                AnimTools = "",


                ShopBuy = {
                    Name = 'Casa',
                    ShopType = "ShopMini",
                    Cost = 9500,
                    Description = "",
                    Ingriends = {
                        ['Waspik Egg'] = 1,
                    },
                },

                GuiItems = "rbxassetid://17180412078",

            },
        },
        Bags = {
            ['Backpack'] = {

                Type = 'PlayerData',
                Capacity = 350,
                ColorTools = "None",


                ShopBuy = {
                    Name = 'Backpack',
                    ShopType = "ShopMini",
                    Cost = 0,
                    Description = "",
                    Ingriends = nil,
                },

                GuiItems = "rbxassetid://17161583288",

            },
            ['Big Backpack'] = {

                Type = 'PlayerData',
                Capacity = 15000,
                ColorTools = "None",


                ShopBuy = {
                    
                    ShopType = "ShopMini",
                    Cost = 17500,
                    Description = "",
                    Name = 'Big Backpack',
                    Ingriends = {
                        ['Strabbery'] = 2222,
                        ['Rock'] = 2222,
                    },
                },

                GuiItems = "rbxassetid://17161583288",

            },
            ['Bubble magical'] = {

                Type = 'PlayerData',
                Capacity = 1650,
                ColorTools = "None",


                ShopBuy = {
                    
                    ShopType = "ShopMini",
                    Cost = 2750,
                    Description = "",
                    Name = 'Bubble magical',
                    Ingriends = nil
                },

                GuiItems = "rbxassetid://17161583288",

            },
            ['Wheat backpack'] = {

                Type = 'PlayerData',
                Capacity = 8500,
                ColorTools = "None",


                ShopBuy = {
                    
                    ShopType = "ShopMini",
                    Cost = 8600,
                    Description = "",
                    Name = 'Wheat backpack',
                    Ingriends = {['Rock'] = 200,}
                },

                GuiItems = "rbxassetid://17161583288",

            },
        },
        Boots = {
            ['Vio Boot'] = {
                    
                Type = 'PlayerData',
                SpeedPlayer = 1.25,
                ColorTools = "None",


                ShopBuy = {
                    ShopType = "ShopMini",
                    Cost = 23500,
                    Description = "",
                    Name = 'Vio Boot',
                    Ingriends = {
                        ['Rock'] = 250,

                    }
                },

                GuiItems = "rbxassetid://17161583288",
            },
        },
        Hats = {
            ['Vio hat'] = {
                    
                Type = 'PlayerData',
                Capacity = 4750,
                Boost = {},
                ColorTools = "None",


                ShopBuy = {
                    
                    ShopType = "ShopMini",
                    Cost = 21000,
                    Description = "",
                    Name = 'Vio hat',
                    Ingriends = {
                        ['Rock'] = 200,

                    }
                },

                GuiItems = "rbxassetid://17161583288",
            },
        },
        Gloves = {},
        Belts = {},
        Guards = {},
        Parachutes = {}
    }

end

return TableModuel