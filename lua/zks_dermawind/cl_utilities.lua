-- lua/zks_dermawind/cl_utilities.lua

ZKsDermaWind = ZKsDermaWind or {}
ZKsDermaWind.Utils = ZKsDermaWind.Utils or {}

local docks = {
    ["top"] = TOP,
    ["bottom"] = BOTTOM,
    ["left"] = LEFT,
    ["right"] = RIGHT,
    ["fill"] = FILL,
    ["center"] = CENTER
}

local alignments = {
    ["bottom-left"] = 1,
    ["bottom-center"] = 2,
    ["bottom-right"] = 3,
    ["middle-left"] = 4,
    ["center"] = 5,
    ["middle-right"] = 6,
    ["top-left"] = 7,
    ["top-center"] = 8,
    ["top-right"] = 9,
}

local function GetPerc(val)
    local num = string.match(val, "%[(%d+)%%%]")
    if not num then return end

    num = math.Clamp(tonumber(num), 1, 100)
    return num / 100
end

local R = ZKsDermaWind.Utils -- Short alias

-- Background Color
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

-- Text position, font, color
-- Usage: text-white, text-primary, text-red, text-sm
R["text"] = function(panel, val, isHover)
    if val == "center" then panel:SetContentAlignment(5) end

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

-- Padding (Apply to all sides)
-- Usage: p-4, p-2
R["p"] = function(panel, val)
    local px = ZKsDermaWind.Theme.Spacing[val]
    if px then
        panel:DockPadding(px, px, px, px)
    end
end

-- Margin
-- Usage: m-4
R["m"] = function(panel, val)
    local px = ZKsDermaWind.Theme.Spacing[val]
    if px then
        panel:DockMargin(px, px, px, px)
    end
end

-- Border Radius
-- Usage: rounded-md, rounded-full
R["rounded"] = function(panel, val)
    local rad = ZKsDermaWind.Theme.Radius[val]
    if rad then
        panel._dw_rounded = rad
    end
end

-- Width/Height (Sizing)
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

-- Dock (flex)
-- Usage: dock-top, dock-left
R["dock"] = function(panel, val)
    if not docks[val] then return end
    panel:Dock(docks[val])
end

-- Opacity (perc)
-- Usage: opacity-20
R["opacity"] = function(panel, val)
    panel._dw_opacity = math.Clamp(tonumber(val), 0, 100) / 100
end

-- Border
-- Usage: border-2, border-red
R["border"] = function(panel, val)
    panel._dw_border = {}
    if isnumber(val) then
        panel._dw_border["size"] = val
    else
        panel._dw_border["size"] = panel._dw_border["size"] or 1
        panel._dw_border["color"] = ZKsDermaWind.Theme.Colors[val] or Color(255, 255, 255)
    end
end

-- Z-index
-- Usage: z-10
R["z"] = function(panel, val)
    if isnumber(val) then
        panel:SetZPos(tonumber(val))
    end
end

-- align items
-- Usage: align-center
R["align"] = function(panel, val)
    if alignments[val] then
        panel:SetContentAlignment(alignments[val])
    elseif isnumber(val) then
        panel:SetContentAlignment(tonumber(val))
    end
end

-- Wrap
-- Usage: wrap-true
R["wrap"] = function(panel, val)
    if string.lower(val) == "false" then panel:SetWrap(false) return end
    if string.lower(val) == "true" then panel:SetWrap(true) return end
end

local PANEL = FindMetaTable("Panel")
for funcName, func in pairs(PANEL) do
    funcName = string.lower(funcName)
    if table.HasValue(R, funcName) or table.HasValue(R, string.Replace(funcName, "set", "")) then continue end
    if not isfunction(func) then continue end

    R[string.Replace(funcName, "set", "")] = function(panel, val)
        func(panel, val)
    end
end

-- Mark lib as loaded
ZKsDermaWind.Loaded = true