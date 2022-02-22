--Gryphons
function EDAB:ToNumber(string)
    local i 
    i = tonumber(string)
    return i 
end
--Gryphons
function EDAB:Left_Gryphon(self)
    if self then 
        MainMenuBarArtFrame.LeftEndCap:Show() 
    else 
        MainMenuBarArtFrame.LeftEndCap:Hide()
    end
end
function EDAB:Right_Gryphon(self)
    if self then 
        MainMenuBarArtFrame.RightEndCap:Show()
    else 
        MainMenuBarArtFrame.RightEndCap:Hide()
    end
end
--Main Action Bar background
function EDAB:MainMenuBar_Background(self)
    if self then 
        MainMenuBarArtFrameBackground:Show()
    else 
        MainMenuBarArtFrameBackground:Hide()
    end
end
--Page buttons and number 
function EDAB:PageButton_Up(self)
    if self then 
        ActionBarUpButton:Show()
    else 
        ActionBarUpButton:Hide()
    end
end
function EDAB:PageButton_Down(self)
    if self then 
        ActionBarDownButton:Show()
    else 
        ActionBarDownButton:Hide()
    end
end
function EDAB:PageNumber(self)
    if self then 
        MainMenuBarArtFrame.PageNumber:Show()
    else 
        MainMenuBarArtFrame.PageNumber:Hide()
    end
end
--Bags bar
function EDAB:BagsBar(self)
    if self then 
        MicroButtonAndBagsBar:Show()
    else 
        MicroButtonAndBagsBar:Hide()
    end
end
--Micro bar
--Stance / aura bar
function EDAB:StanceBar(self)
    if self then 
        StanceBarFrame:Show()
    else 
        StanceBarFrame:Hide(); StanceBarFrame:HookScript("OnShow", StanceBarFrame.Hide)
    end
end
--Hider Action Bars
function EDAB:MainActionBar(self)
    if self then 
        for i=1,12 do _G["ActionButton"..i]:Show() end
    else 
        for i=1,12 do _G["ActionButton"..i]:SetAttribute("statehidden", true);_G["ActionButton"..i]:Hide() end
    end
end
function EDAB:MultiBarBottomLeft(self)
    if self then 
        MultiBarBottomLeft:Show()
    else 
        MultiBarBottomLeft:Hide()
    end
end
function EDAB:MultiBarBottomRight(self)
    if self then 
        MultiBarBottomRight:Show()
    else 
        MultiBarBottomRight:Hide()
    end
end
function EDAB:MultiBarLeft(self)
    if self then 
        MultiBarLeft:Show()
    else 
        MultiBarLeft:Hide()
    end
end
function EDAB:MultiBarRight(self)
    if self then 
        MultiBarRight:Show()
    else 
        MultiBarRight:Hide()
    end
end
--pet bar
function EDAB:PetBar(self)
    if self then 
        PetActionBarFrame:Show()
    else 
        PetActionBarFrame:Hide(); PetActionBarFrame:HookScript("OnShow", PetActionBarFrame.Hide)
    end
end
--bottom alpha
function EDAB:MouseoverBottomAlpha(v)
    MultiBarBottomLeft:SetAlpha(v)
    MultiBarBottomRight:SetAlpha(v)
    for i=1,12 do
        _G["ActionButton" ..i]:SetAlpha(v)
    end
end
--side alpha
function EDAB:MouseoverSideAlpha(v)
    MultiBarLeft:SetAlpha(v)
    MultiBarRight:SetAlpha(v)
end
--mouseover bottom
function EDAB:MouseoverBottom(alpha, fadetime)
        EDAB:MainActionBar(true);EDAB:MultiBarBottomLeft(true);EDAB:MultiBarBottomRight(true)
        EDAB:MouseoverBottomAlpha(alpha)
        MultiBarBottomLeft:SetScript("OnEnter", function() EDAB:MouseoverBottomAlpha(1) end)
        MultiBarBottomRight:SetScript("OnEnter", function() EDAB:MouseoverBottomAlpha(1) end)
        for i=1,12 do _G["ActionButton" ..i]:SetScript("OnEnter", function() EDAB:MouseoverBottomAlpha(1) end)end

        MultiBarBottomLeft:SetScript("OnLeave", function() C_Timer.After(fadetime, function() EDAB:MouseoverBottomAlpha(alpha) end) end)
        MultiBarBottomRight:SetScript("OnLeave", function() C_Timer.After(fadetime, function() EDAB:MouseoverBottomAlpha(alpha) end) end)
        for i=1,12 do _G["ActionButton" ..i]:SetScript("OnLeave", function() C_Timer.After(fadetime, function() EDAB:MouseoverBottomAlpha(alpha) end) end)end
end
--mouseover side
function EDAB:MouseoverSide(alpha, fadetime)
    EDAB:MultiBarLeft(true);EDAB:MultiBarRight(true)
    EDAB:MouseoverSideAlpha(alpha)
    MultiBarLeft:SetScript("OnEnter", function() EDAB:MouseoverSideAlpha(1) end)
    MultiBarRight:SetScript("OnEnter", function() EDAB:MouseoverSideAlpha(1) end)
    MultiBarLeft:SetScript("OnLeave", function() C_Timer.After(fadetime, function() EDAB:MouseoverSideAlpha(alpha) end) end)
    MultiBarRight:SetScript("OnLeave", function() C_Timer.After(fadetime, function() EDAB:MouseoverSideAlpha(alpha) end) end)
end
--remove OnShow/OnHide handler and set alpha back to 1
function EDAB:ResetBottom()
    MultiBarBottomLeft:SetAlpha(1)
    MultiBarBottomRight:SetAlpha(1)
    for i=1,12 do _G["ActionButton" ..i]:SetAlpha(1)end
    MultiBarBottomLeft:SetScript("OnEnter", nil)
    MultiBarBottomRight:SetScript("OnEnter", nil)
    for i=1,12 do _G["ActionButton" ..i]:SetScript("OnEnter", nil) end
    MultiBarBottomLeft:SetScript("OnLeave", nil)
    MultiBarBottomRight:SetScript("OnLeave", nil)
    for i=1,12 do _G["ActionButton" ..i]:SetScript("OnLeave", nil) end
end
-- same for side
function EDAB:ResetSide()
    MultiBarLeft:SetAlpha(1)
    MultiBarRight:SetAlpha(1)
    MultiBarLeft:SetScript("OnEnter", nil)
    MultiBarRight:SetScript("OnEnter", nil)
    MultiBarLeft:SetScript("OnLeave", nil)
    MultiBarRight:SetScript("OnLeave", nil)
end
--function to transform table true/false content as boolean
function EDAB:tobool(str)
    local bool = false
    if str == "true" then
        bool = true
    end
    return bool
end
--hide gcd bling credits to Finney on mmo-champion https://www.mmo-champion.com/threads/2414999-How-do-I-disable-the-GCD-flash-on-my-bars
function EDAB:HideBlingBling()
    for i,v in pairs(_G) do
        if type(v)=="table" and type(v.SetDrawBling)=="function" then
            v:SetDrawBling(false)
        end
    end
    hooksecurefunc(getmetatable(ActionButton1Cooldown).__index, 'SetCooldown', function(self) self:SetDrawBling(false)end)
end
function EDAB:MicroBar(self)
    if self then
        CharacterMicroButton:Show()
        SpellbookMicroButton:Show()
        TalentMicroButton:Show()
        AchievementMicroButton:Show()
        QuestLogMicroButton:Show()
        GuildMicroButton:Show()
        LFDMicroButton:Show()
        CollectionsMicroButton:Show()
        EJMicroButton:Show()
        StoreMicroButton:Show()
        MainMenuMicroButton:Show()
    else
        CharacterMicroButton:Hide()
        SpellbookMicroButton:Hide()
        TalentMicroButton:Hide()
        AchievementMicroButton:Hide()
        QuestLogMicroButton:Hide()
        GuildMicroButton:Hide()
        LFDMicroButton:Hide()
        CollectionsMicroButton:Hide()
        EJMicroButton:Hide()
        StoreMicroButton:Hide()
        MainMenuMicroButton:Hide()
        CharacterMicroButton:HookScript("OnShow", CharacterMicroButton.Hide)
        SpellbookMicroButton:HookScript("OnShow", SpellbookMicroButton.Hide)
        TalentMicroButton:HookScript("OnShow", TalentMicroButton.Hide)
        AchievementMicroButton:HookScript("OnShow", AchievementMicroButton.Hide)
        QuestLogMicroButton:HookScript("OnShow", QuestLogMicroButton.Hide)
        GuildMicroButton:HookScript("OnShow", GuildMicroButton.Hide)
        LFDMicroButton:HookScript("OnShow", LFDMicroButton.Hide)
        CollectionsMicroButton:HookScript("OnShow", CollectionsMicroButton.Hide)
        EJMicroButton:HookScript("OnShow", EJMicroButton.Hide)
        StoreMicroButton:HookScript("OnShow", StoreMicroButton.Hide)
        MainMenuMicroButton:HookScript("OnShow", MainMenuMicroButton.Hide)
    end
end
function EDAB:MicroBarAlpha(alpha)
    CharacterMicroButton:SetAlpha(alpha)
    SpellbookMicroButton:SetAlpha(alpha)
    TalentMicroButton:SetAlpha(alpha)
    AchievementMicroButton:SetAlpha(alpha)
    QuestLogMicroButton:SetAlpha(alpha)
    GuildMicroButton:SetAlpha(alpha)
    LFDMicroButton:SetAlpha(alpha)
    CollectionsMicroButton:SetAlpha(alpha)
    EJMicroButton:SetAlpha(alpha)
    StoreMicroButton:SetAlpha(alpha)
    MainMenuMicroButton:SetAlpha(alpha)
end
