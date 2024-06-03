local Diologs = {}

Diologs.QuesetDialog = {
    ["Snail"] = {
        SettingsQuset = { 
            Name = 'Snail',
            Icon = "rbxassetid://16312164831",
            Talk = {
            [1] = {
                Type = "Player",
                MSG = "ssss",
                Order = 1
            },
            [2] = {
                Type = "NPC",
                MSG = "2",
                Order = 2
            },
            [3] = {
                Type = "NPC",
                MSG = "3",
                Order = 3
            },
        },
            QusetTable = {
                [1] = {
                    Icon = "rbxassetid://16312164831",
                    NameQuset = "Start Game", 
                    QuestNameTask = "",
                    Dialogs = { 
                        NewQuset = { 
                            [1] = {
                                Type = "NPC",
                                MSG = "1",
                                Order = 1
                            },
                            [2] = {
                                Type = "NPC",
                                MSG = "2",
                                Order = 2
                            },
                            [3] = {
                                Type = "NPC",
                                MSG = "3",
                                Order = 3
                        },
                        [4] = {
                                Type = "Player",
                                MSG = "Player",
                                Order = 4
                            },
                            [5] = {
                                Type = "NPC",
                                MSG = "5",
                                Order = 5
                            },               
                        },

                        OldQuset = { 
                        },

                        Completed = { 
                            
                        },

                    },

                    Task = {
                        [1] = {
                        Type = "TimeGame", --! Timer
                        StartAmt = 0,
                        NeedAmt = 3600,
                        },
                    },

                    Rewards = {
                        [1] = {
                            Rewar = "BaseSettings",
                            Type = "Sneliki",
                            Amount = 1000
                        } 
                    }
                }
            }
        }
    }
}
return Diologs 