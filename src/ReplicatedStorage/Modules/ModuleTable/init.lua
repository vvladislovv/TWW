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

    TableModuel.FieldsDrop = {
        ['Banana'] = {
            ['Coin'] = {Name = "Coin", Rarity = 95, APT = 1},
            ['Banana'] = {Name = "Banana", Rarity = 65, APT = 1},
            ['Waspik Egg'] = {Name = "Waspik Egg", Rarity = 50, APT = 1},
            ['Send'] = {Name = "Send", Rarity = 25, APT = 1},
            ['Serk'] = {Name = "Serk", Rarity = 15, APT = 1},
            ['Flower'] = {Name = "Flower", Rarity = 10, APT = 1},
        }
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

    TableModuel.TokenTables = {
        TokenDrop = {
            ['Banana'] = {
                ColorToken = Color3.fromRGB(232, 164, 47),
                Image = "rbxassetid://17180421548",
                Coouldown = 15
            },
            ['Coin'] = {
                ColorToken = Color3.fromRGB(160, 106, 12),
                Image = "rbxassetid://17180421548",
                Coouldown = 15
            },
            ['Waspik Egg'] = {
                ColorToken = Color3.fromRGB(232, 47, 149),
                Image = "rbxassetid://17180421548",
                Coouldown = 15
            },
            ['Flower'] = {
                ColorToken = Color3.fromRGB(47, 232, 140),
                Image = "rbxassetid://17180421548",
                Coouldown = 15
            },
            ['Send'] = {
                ColorToken = Color3.fromRGB(232, 47, 47),
                Image = "rbxassetid://17180421548",
                Coouldown = 15
            },
            ['Serk'] = {
                ColorToken = Color3.fromRGB(47, 158, 232),
                Image = "rbxassetid://17180421548",
                Coouldown = 15
            },
        }
    }

    TableModuel.ItemsPlayer = {
        Tools = {
            ['Shovel'] = {
                Type = 'PlayerData',
                Coouldown = 0.2,
                SpeedCoper = 0.75,
                Collecting = 12,
                PowerTools = 0.3,
                Stamp = "Shovel",
                ColorTools = "None",
                AnimTools = "rbxassetid://17469220213",


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
                Coouldown = 0.5,
                SpeedCoper = 0.5,
                Collecting = 75,
                PowerTools = 0.35,
                Stamp = "Hammer",
                ColorTools = "None",
                AnimTools = "rbxassetid://17468307876",


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
                PowerTools = 0.35,
                Stamp = "Scissors",
                ColorTools = "None",
                AnimTools = "rbxassetid://17468918803",


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
                Collecting = 12,
                PowerTools = 0.3,
                Stamp = "Casa",
                ColorTools = "None",
                AnimTools = "rbxassetid://17468684067",


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
    TableModuel.MonstersTable = {
        ['Monkey'] = {
            Field = {'BananaPath1','BananaPath2','BananaPath3',},
            Level = 1,
            HP = 25,
            SettingsMobs = {
                Speed = 15,
                Damage = 15,
                Dist = 50,
                Cooldown = 300
            },
    
            Reward = {
                ['Coin'] = {
                    Amt = 50, -- Умножать
                    Chance = 1000,
                    Type = "IStats"
                },
                ['Mushrooms'] = {
                    Amt = 1,
                    Chance = 100,
                    Type = "Inventory"
                },
                ['Waspik Egg'] = {
                    Amt = 1,
                    Chance = 1000000,
                    Type = "Inventory"
                },
                ['Battle Points'] = {
                    Amt = 50, -- Умножать
                    Chance = 1000,
                    Type = "TotalItems"
                },
    
            }
        }
    }

end

return TableModuel