
ZKsDermaWind = ZKsDermaWind or {}

concommand.Add("zks_test_ui", function()
    if not ZKsDermaWind.Loaded == true then return end
    local frame = vgui.Create("DFrame")
    frame:DWClassName("w-[50%] h-[50%] bg-secondary rounded-lg")
    frame:SetTitle("")
    frame:ShowCloseButton(false)
    frame:Center()
    frame:MakePopup()

    local cbtn = vgui.Create("DButton", frame)
    cbtn:SetText("X")
    cbtn:DWClassName("bg-secondary text-black text-lg rounded-lg hover:bg-danger")
    cbtn:SetPos(frame:GetWide()-cbtn:GetWide(), 0)
    cbtn.DoClick = function()
        frame:Close()
    end

    local btn = vgui.Create("DButton", frame)
    btn:SetText("Click Meee")
    btn:DWClassName("bg-primary text-black text-lg rounded-lg hover:bg-danger m-4 w-500 dock-left border-5")
end)