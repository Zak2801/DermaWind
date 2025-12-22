-- lua/zks_dermawind/sh_theme.lua

ZKsDermaWind = ZKsDermaWind or {}
ZKsDermaWind.Theme = {}

-- 1. Color Palette
-- Users can add "primary", "accent", etc. here.
ZKsDermaWind.Theme.Colors = {
    -- Semantic names (Easier to change later)
    ["primary"]   = Color(59, 130, 246), -- Blue-500
    ["secondary"] = Color(107, 114, 128), -- Gray-500
    ["danger"]    = Color(239, 68, 68),  -- Red-500
    ["success"]   = Color(34, 197, 94),  -- Green-500
    
    -- Standard Palette
    ["white"]     = Color(255, 255, 255),
    ["black"]     = Color(0, 0, 0),
    ["dark"]      = Color(30, 30, 30),
    ["darker"]    = Color(20, 20, 20),
}

-- 2. Spacing / Sizing Scale (Multipliers)
ZKsDermaWind.Theme.Spacing = {
    ["0"] = 0,
    ["1"] = 4,
    ["2"] = 8,
    ["3"] = 12,
    ["4"] = 16,
    ["5"] = 20,
    ["6"] = 24,
    ["8"] = 32,
    ["10"] = 40,
    ["full"] = -1, -- Special flag for 100%
}

-- 3. Border Radius
ZKsDermaWind.Theme.Radius = {
    ["sm"] = 2,
    ["md"] = 4,
    ["lg"] = 8,
    ["xl"] = 12,
    ["full"] = 999, -- Circle
}

-- 4. Font Sizes (Optional but recommended)
ZKsDermaWind.Theme.Fonts = {
    ["sm"] = "DermaDefault",
    ["base"] = "DermaDefault",
    ["lg"] = "DermaLarge",
}