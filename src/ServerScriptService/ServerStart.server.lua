local Server = game.ServerScriptService.ServerScript
local EquipmentModule = require(Server.Equipment)
EquipmentModule:StartSysmes()
for _, index in next, Server:GetDescendants() do
    if index:IsA('ModuleScript') then
        require(index)
        print(index)
    end
end
