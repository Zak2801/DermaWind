-- lua/zks_dermawind/cl_utilities.lua

ZKsDermaWind = ZKsDermaWind or {}
ZKsDermaWind.Utils = ZKsDermaWind.Utils or {}

local docks = {
    ["top"] = TOP,
    ["bottom"] = BOTTOM,
    ["left"] = LEFT,
    ["right"] = RIGHT,
    ["fill"] = FILL,
    ["center"] = CENTER,
}

local function GetPerc(val)
    local num = string.match(val, "%[(%d+)%%%]")
    if not num then return end

    num = math.Clamp(tonumber(num), 1, 100)
    return num / 100
end

local R = ZKsDermaWind.Utils -- Short alias

-- 1. Background Color
-- Usage: bg-primary, bg-red-500, bg-dark
R["bg"] = function(panel, val, isHover)
    local col = ZKsDermaWind.Theme.Colors[val]
    if not col then return end

    if isHover then
        panel._dw_bg_hover = col
    else
        panel._dw_bg = col
    end
end

-- 2. Text Color
-- Usage: text-white, text-primary
R["text"] = function(panel, val, isHover)
    local col = ZKsDermaWind.Theme.Colors[val]
    if col and panel.SetTextColor then
        panel:SetTextColor(col)
        return
    end

    -- if not color, font
    local font = ZKsDermaWind.Theme.Fonts[val]
    if font and panel.SetFont then
        panel:SetFont(font)
        return
    end
end

-- 3. Padding (Apply to all sides)
-- Usage: p-4, p-2
R["p"] = function(panel, val)
    local px = ZKsDermaWind.Theme.Spacing[val]
    if px then
        panel:DockPadding(px, px, px, px)
    end
end

-- 4. Margin
-- Usage: m-4
R["m"] = function(panel, val)
    local px = ZKsDermaWind.Theme.Spacing[val]
    if px then
        panel:DockMargin(px, px, px, px)
    end
end

-- 5. Border Radius
-- Usage: rounded-md, rounded-full
R["rounded"] = function(panel, val)
    local rad = ZKsDermaWind.Theme.Radius[val]
    if rad then
        panel._dw_rounded = rad
    end
end

-- 6. Width/Height (Sizing)
-- Usage: w-full, h-10
R["w"] = function(panel, val)
    local px
    if val == "full" then 
        -- If creating a flex-like system, this might differ, 
        -- but usually w-full in derma implies expanding to parent
        panel:Dock(TOP) -- or FILL depending on context
        return
    end

    local n = GetPerc(val)
    if n then
        local scrWidth = ScrW()
        px = n * scrWidth
    else
        px = ZKsDermaWind.Theme.Spacing[val] or tonumber(val)
    end
    
    if px then panel:SetWide(px) end
end

R["h"] = function(panel, val)
    local px
    local n = GetPerc(val)
    if n then
        local scrHeight = ScrH()
        px = n * scrHeight
    else
        px = ZKsDermaWind.Theme.Spacing[val] or tonumber(val)
    end

    if px then panel:SetTall(px) end
end

R["dock"] = function(panel, val)
    if not docks[val] then return end
    panel:Dock(docks[val])
end

ZKsDermaWind.Loaded = true