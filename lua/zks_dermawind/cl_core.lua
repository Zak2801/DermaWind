-- lua/zks_dermawind/cl_core.lua

ZKsDermaWind = ZKsDermaWind or {}
ZKsDermaWind.Utils = ZKsDermaWind.Utils or {}

local PANEL = FindMetaTable("Panel")

function PANEL:DWClassName(classString)
    ZKsDermaWind.Style(self, classString)
end

-- Helper to safely get a color from the theme
function ZKsDermaWind.GetColor(name)
    return ZKsDermaWind.Theme.Colors[name] or Color(255, 255, 255)
end

-- The Main styling function
function ZKsDermaWind.Style(panel, classString)
    -- Reset state slightly to ensure clean slate (optional)
    panel._dw_bg = nil
    panel._dw_rounded = 0
    
    -- Split string by spaces
    local classes = string.Explode(" ", classString)

    for _, class in ipairs(classes) do
        -- Skip empty spaces
        if class == "" then continue end

        -- 1. Check for Hover prefix
        local isHover = false
        local cleanClass = class
        if string.StartWith(class, "hover:") then
            isHover = true
            cleanClass = string.sub(class, 7) -- remove "hover:"
        end

        -- 2. Parse Utility (Split by first hyphen)
        -- e.g., "bg-primary" -> prefix="bg", value="primary"
        local parts = string.Explode("-", cleanClass)
        local prefix = parts[1]
        local value = table.concat(parts, "-", 2) -- Join the rest back

        -- 3. Execute matching utility
        local utility = ZKsDermaWind.Utils[prefix]
        if utility then
            utility(panel, value, isHover)
        else
            -- Optional: Warn about unknown utility
            -- print("[ZKsDermaWind] Unknown utility:", prefix)
        end
    end

    -- 4. Apply Paint Hook (The "Renderer")
    -- We define this once here to handle the visual properties set above
    panel.Paint = function(self, w, h)
        local bgColor = self._dw_bg
        local border = self._dw_border
        
        -- Handle Hover Logic
        if self:IsHovered() and self._dw_bg_hover then
            bgColor = self._dw_bg_hover
        end

        -- Draw Background
        if bgColor then
            local radius = self._dw_rounded or 0
            draw.RoundedBox(radius, 0, 0, w, h, bgColor)
        end

        if border then
            surface.SetDrawColor(border.color.r, border.color.g, border.color.b, border.color.a)
            surface.DrawOutlinedRect(0, 0, w, h, border.size)
        end
        
        -- Draw Text (Fix for DButton/Label)
        if self.GetText then
            -- This is a simplified text draw. 
            -- For production, you might want to wrap self:DrawButtonText() if it exists
            local txt = self:GetText()
            local succ, err = pcall(function() self:GetTextColor() end)
            local col = succ and self:GetTextColor() or Color(255,255,255)
            
            -- Simple centering. You might want to support "text-left" later.
            draw.SimpleText(txt, self:GetFont(), w/2, h/2, col, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end

        surface.SetAlphaMultiplier(panel._dw_opacity or 1)
    end
end