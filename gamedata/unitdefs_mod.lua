for _, ud in pairs (UnitDefs) do
    if not ud.customparams then
        ud.customparams = {}
    end
    if ud.cloakcost then
        ud.cloakcost = 0
        ud.canCloak = true
    end
    if ud.cloakcostmoving then
        ud.cloakcostmoving = 0
        ud.canCloak = true
    end
    if ud.energyuse then
        ud.energyuse = 0
    end
    if ud.customparams.area_cloak_upkeep then
        ud.customparams.area_cloak_upkeep = 0
    end

    if ud.weapondefs then
        for _, wd in pairs(ud.weapondefs) do
            if wd.shieldpowerregenenergy and wd.shieldpowerregenenergy > 0 then
                -- unit_commander_upgrade.lua crashes if I set this to exactly 0
                wd.shieldpowerregenenergy = 0.01
            end
        end
    end

    if ud.customparams.pylonrange then
        -- Let us be a bit sloppy about where to place solars/tidals
        ud.customparams.pylonrange = math.max(ud.customparams.pylonrange, 90)
    end
end

-- apply unitTweaks
local unitTweaks = VFS.Include("gamedata/unit_tweaks.lua")
local OverwriteTableInplace = Spring.Utilities.OverwriteTableInplace
if unitTweaks and type(unitTweaks) == "table" then
    Spring.Echo("Loading custom units tweaks for zero-wars")
    for name, ud in pairs(UnitDefs) do
        if unitTweaks[name] then
            Spring.Echo("Loading custom units tweaks for " .. name)
            OverwriteTableInplace(ud, lowerkeys(unitTweaks[name]), true)
        end
    end
end

