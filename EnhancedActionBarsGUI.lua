EDAB = LibStub("AceAddon-3.0"):NewAddon("EDAB", "AceConsole-3.0")
EDABUI = LibStub("AceGUI-3.0")

local defaults = {
    profile = {
        Gryphons = false,
        BagBar = false,
        MicroBar = false,
        MainActionBarArt = false,
        PageWidget = false,
        PetBar = false,
        StanceBar = true,
        MicroBar = true,
        MouseoverBottomStatus = true,
        MouseoverBottomFade = 3,
        MouseoverBottomAlpha = 0,
        MouseoverSideStatus = false,
        MouseoverSideFade = 3,
        MouseoverSideAlpha = 0,
    },
}
local options = {
	name = "get to settings with /ebars or click the button",
	handler = EDAB,
	type = "group",
	args = {
        button = {
            name = "Settings",
            type = "execute",
            func = function() EDAB:UI() end,
        },
	},
}

local buttonwidth = 80
local mo_buttonwidth = 100
local intabheadline = GameFontNormal

function EDAB:OnInitialize()
    self.db = LibStub("AceDB-3.0"):New("EDABDB", defaults, true)
    self.db.RegisterCallback(self, "OnProfileChanged", "LoadProfile")
    self.db.RegisterCallback(self, "OnProfileCopied", "LoadProfile")
    self.db.RegisterCallback(self, "OnProfileReset", "LoadProfile")
    local profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
    --setting up esc -> interface -> addons screen
    LibStub("AceConfig-3.0"):RegisterOptionsTable("EDAB", options)
    self.optionsFrame =  LibStub("AceConfigDialog-3.0"):AddToBlizOptions("EDAB", "Enhanced Action Bars")
    --add multispec profiles, will add later when i figuered out the best way of doing it
   -- self.db.profile= LibStub('AceDBOptions-3.0'):GetOptionsTable(self.db)
    --local LibDualSpec = LibStub("LibDualSpec-1.0")
    --LibDualSpec:EnhanceDatabase(self.db, "EDAB")
    --LibDualSpec:EnhanceOptions(self.db.profile, self.db)
    --register slash command
    --self:RegisterChatCommand("edab", "SlashCommand")
    self:RegisterChatCommand("ebars", "SlashCommand")
    --setting up profiles tab 
    
    LibStub("AceConfig-3.0"):RegisterOptionsTable("EDAB_Profiles", profiles)
    LibStub("AceConfigDialog-3.0"):AddToBlizOptions("EDAB_Profiles", "Profiles", "EDAB") 
    --startup load hide ui settings from current profile
    EDAB:LoadProfile()
    EDAB:HideBlingBling()
end

function EDAB:LoadProfile()
    EDAB:Left_Gryphon(self.db.profile.Gryphons);EDAB:Right_Gryphon(self.db.profile.Gryphons)
    EDAB:MainMenuBar_Background(self.db.profile.MainActionBarArt)
    EDAB:BagsBar(self.db.profile.BagBar)
    EDAB:PageButton_Up(self.db.profile.PageWidget);EDAB:PageButton_Down(self.db.profile.PageWidget);EDAB:PageNumber(self.db.profile.PageWidget)
    EDAB:StanceBar(self.db.profile.StanceBar)
    EDAB:PetBar(self.db.profile.PeteBar)
    if self.db.profile.MouseoverBottomStatus then
    EDAB:MouseoverBottom(self.db.profile.MouseoverBottomAlpha, self.db.profile.MouseoverBottomFade)
    end
    EDAB:MicroBar(self.db.profile.MicroBar)
    if self.db.profile.MouseoverSideStatus then
        EDAB:MouseoverSide(self.db.profile.MouseoverSideAlpha, self.db.profile.MouseoverSideFade)
    end

end

function EDAB:SlashCommand(msg)
    EDAB:UI()
end


--function EDAB:getProf(info) return self.db.profile[info] end



function EDAB:setProf(info, value) self.db.profile[info] = value end


--UI Frame
function EDAB:UI()
--tab1 
local function DrawGroup1(container)  
--Gryphons
    local gryph = EDABUI:Create("Label")
    gryph:SetText("Gryphons:")
    gryph:SetFullWidth(true)
    gryph:SetFont(intabheadline:GetFont())
    container:AddChild(gryph)
    local button = EDABUI:Create("Button")
    button:SetText("Hide")
    button:SetWidth(buttonwidth)
    button:SetCallback("OnClick", function() EDAB:Left_Gryphon(false);EDAB:Right_Gryphon(false); EDAB:setProf("Gryphons", false) end)
    container:AddChild(button)
    local button = EDABUI:Create("Button")
    button:SetText("Show")
    button:SetWidth(buttonwidth)
    button:SetCallback("OnClick", function() EDAB:Left_Gryphon(true); EDAB:Right_Gryphon(true);EDAB:setProf("Gryphons", true) end)
    container:AddChild(button)
--Bag Bar 
    local bag = EDABUI:Create("Label")
    bag:SetText("Bag Bar:")
    bag:SetFullWidth(true)
    bag:SetFont(intabheadline:GetFont())
    container:AddChild(bag)
    local button = EDABUI:Create("Button")
    button:SetText("Hide")
    button:SetWidth(buttonwidth)
    button:SetCallback("OnClick", function() EDAB:BagsBar(false); EDAB:setProf("BagBar", false) end)
    container:AddChild(button)
    local button = EDABUI:Create("Button")
    button:SetText("Show")
    button:SetWidth(buttonwidth)
    button:SetCallback("OnClick", function() EDAB:BagsBar(true); EDAB:setProf("BagBar", true) end)
    container:AddChild(button) 
--MicroBar
    local micro = EDABUI:Create("Label")
    micro:SetText("Micro Bar:")
    micro:SetFullWidth(true)
    micro:SetFont(intabheadline:GetFont())
    container:AddChild(micro)
    local button = EDABUI:Create("Button")
    button:SetText("Hide")
    button:SetWidth(buttonwidth)
    button:SetCallback("OnClick", function() EDAB:MicroBar(false); EDAB:setProf("MicroBar", false) end)
    container:AddChild(button)
    local button = EDABUI:Create("Button")
    button:SetText("Show")
    button:SetWidth(buttonwidth)
    button:SetCallback("OnClick", function() EDAB:MicroBar(true); EDAB:setProf("MicroBar", true) end)
    container:AddChild(button) 
--Main Menu Bar Background
    local mainart = EDABUI:Create("Label")
    mainart:SetText("Main Action Bar Art:")
    mainart:SetFullWidth(true)
    mainart:SetFont(intabheadline:GetFont())
    container:AddChild(mainart)
    local button = EDABUI:Create("Button")
    button:SetText("Hide")
    button:SetWidth(buttonwidth)
    button:SetCallback("OnClick", function() EDAB:MainMenuBar_Background(false); EDAB:setProf("MainActionBarArt", false) end)
    container:AddChild(button)
    local button = EDABUI:Create("Button")
    button:SetText("Show")
    button:SetWidth(buttonwidth)
    button:SetCallback("OnClick", function() EDAB:MainMenuBar_Background(true); EDAB:setProf("MainActionBarArt", true) end)
    container:AddChild(button)
--Page Buttons
    local page = EDABUI:Create("Label")
    page:SetText("Page Up & Down Icons:")
    page:SetFullWidth(true)
    page:SetFont(intabheadline:GetFont())
    container:AddChild(page)
    local button = EDABUI:Create("Button")
    button:SetText("Hide")
    button:SetWidth(buttonwidth)
    button:SetCallback("OnClick", function() EDAB:PageButton_Down(false);EDAB:PageButton_Up(false);EDAB:PageNumber(false); EDAB:setProf("PageWidget", false) end)
    container:AddChild(button)
    local button = EDABUI:Create("Button")
    button:SetText("Show")
    button:SetWidth(buttonwidth)
    button:SetCallback("OnClick", function() EDAB:PageButton_Down(true);EDAB:PageButton_Up(true);EDAB:PageNumber(true); EDAB:setProf("PageWidget", true) end)
    container:AddChild(button)
--Pet Bar
    local pet = EDABUI:Create("Label")
    pet:SetText("Pet Bar:")
    pet:SetFullWidth(true)
    pet:SetFont(intabheadline:GetFont())
    container:AddChild(pet)
    local button = EDABUI:Create("Button")
    button:SetText("Hide")
    button:SetWidth(buttonwidth)
    button:SetCallback("OnClick", function() EDAB:PetBar(false); EDAB:setProf("PetBar", false) end)
    container:AddChild(button)
    local button = EDABUI:Create("Button")
    button:SetText("Show")
    button:SetWidth(buttonwidth)
    button:SetCallback("OnClick", function() EDAB:PetBar(true); EDAB:setProf("PetBar", true)  end)
    container:AddChild(button) 
--Stance Bar
    local stance = EDABUI:Create("Label")
    stance:SetText("Stance Bar:")
    stance:SetFullWidth(true)
    stance:SetFont(intabheadline:GetFont())
    container:AddChild(stance)
    local button = EDABUI:Create("Button")
    button:SetText("Hide")
    button:SetWidth(buttonwidth)
    button:SetCallback("OnClick", function() EDAB:StanceBar(false); EDAB:setProf("StanceBar", false) end)
    container:AddChild(button)
    local button = EDABUI:Create("Button")
    button:SetText("Show")
    button:SetWidth(buttonwidth)
    button:SetCallback("OnClick", function() EDAB:StanceBar(true); EDAB:setProf("StanceBar", true) end)
    container:AddChild(button) 
end
--tab2 
  local function DrawGroup2(container)
--Bottom Bars
    local desc = EDABUI:Create("Label")
    desc:SetText("Bottom Bars")
    desc:SetFullWidth(true)
    desc:SetFont(intabheadline:GetFont())
    container:AddChild(desc)
    local button = EDABUI:Create("Button")
    button:SetText("mouseover")
    button:SetWidth(mo_buttonwidth)
    button:SetCallback("OnClick", function() EDAB:setProf("MouseoverBottomAlpha", 0);EDAB:MouseoverBottom(self.db.profile.MouseoverBottomAlpha, self.db.profile.MouseoverBottomFade); EDAB:setProf("MouseoverBottomStatus", true) end)
    container:AddChild(button)
    local button = EDABUI:Create("Button")
    button:SetText("static")
    button:SetWidth(mo_buttonwidth)
    button:SetCallback("OnClick", function() EDAB:ResetBottom(); EDAB:setProf("MouseoverBottomStatus", false) end)
    container:AddChild(button)
    local editb = EDABUI:Create("EditBox")
    editb:SetLabel("Fadeout in s")
    editb:SetWidth(70)
    local tmp_editb 
    editb:SetCallback("OnEnterPressed", 
        function() 
            tmp_editb = editb:GetText()
            if EDAB:ToNumber(tmp_editb) then 
                EDAB:setProf("MouseoverBottomFade", EDAB:ToNumber(tmp_editb))
                EDAB:MouseoverBottom(self.db.profile.MouseoverBottomAlpha, self.db.profile.MouseoverBottomFade)
            else 
                EDAB:Print("Please enter a valid number")
            end
        end)
    container:AddChild(editb)
    local slider = EDABUI:Create("Slider")
    slider:SetLabel("alpha")
    slider:SetSliderValues(0, 1, 0.01)
    slider:SetIsPercent(true) 
    slider:SetCallback("OnValueChanged", function() EDAB:setProf("MouseoverBottomAlpha", slider:GetValue()); EDAB:MouseoverBottom(slider:GetValue() , self.db.profile.MouseoverBottomFade) end)
    container:AddChild(slider)
--side bars
    local desc = EDABUI:Create("Label")
    desc:SetText("Side Bars")
    desc:SetFullWidth(true)
    desc:SetFont(intabheadline:GetFont())
    container:AddChild(desc)
    local button = EDABUI:Create("Button")
    button:SetText("mouseover")
    button:SetWidth(mo_buttonwidth)
    button:SetCallback("OnClick", function() EDAB:setProf("MouseoverSideAlpha", 0);EDAB:MouseoverSide(self.db.profile.MouseoverSideAlpha, self.db.profile.MouseoverSideFade); EDAB:setProf("MouseoverSideStatus", true) end)
    container:AddChild(button)
    local button = EDABUI:Create("Button")
    button:SetText("static")
    button:SetWidth(mo_buttonwidth)
    button:SetCallback("OnClick", function() EDAB:ResetSide(); EDAB:setProf("MouseoverSideStatus", false) end)
    container:AddChild(button)
    local editb = EDABUI:Create("EditBox")
    editb:SetLabel("Fadeout in s")
    editb:SetWidth(70)
    local tmp_editb 
    editb:SetCallback("OnEnterPressed", 
        function() 
            tmp_editb = editb:GetText()
            if EDAB:ToNumber(tmp_editb) then 
                EDAB:setProf("MouseoverSideFade", EDAB:ToNumber(tmp_editb))
                EDAB:MouseoverBottom(self.db.profile.MouseoverSideAlpha, self.db.profile.MouseoverSideFade)
            else 
                EDAB:Print("Please enter a valid number")
            end
        end)
    container:AddChild(editb)
    local slider = EDABUI:Create("Slider")
    slider:SetLabel("alpha")
    slider:SetSliderValues(0, 1, 0.01)
    slider:SetIsPercent(true) 
    slider:SetCallback("OnValueChanged", function() EDAB:setProf("MouseoverSideAlpha", slider:GetValue()); EDAB:MouseoverSide(slider:GetValue() , self.db.profile.MouseoverSideFade) end)
    container:AddChild(slider)
  end
--tab3 to buggy leaving it out for now have to handle some events fist to avoid frustration 
--[[
  local function DrawGroup3(container)
    local desc = EDABUI:Create("Label")
    desc:SetText("Main Action Bar:")
    desc:SetFullWidth(true)
    desc:SetFont(intabheadline:GetFont())
    container:AddChild(desc)
    local button = EDABUI:Create("Button")
    button:SetText("Hide")
    button:SetWidth(buttonwidth)
    button:SetCallback("OnClick", function() EDAB:MainActionBar(false) end)
    container:AddChild(button)
    local button = EDABUI:Create("Button")
    button:SetText("Show")
    button:SetWidth(buttonwidth)
    button:SetCallback("OnClick", function() EDAB:MainActionBar(true) end)
    container:AddChild(button)
-------------------------------------------------------------------------------  
    local bag = EDABUI:Create("Label")
    bag:SetText("Multi Bar Bottom Left:")
    bag:SetFullWidth(true)
    bag:SetFont(intabheadline:GetFont())
    container:AddChild(bag)
    local button = EDABUI:Create("Button")
    button:SetText("Hide")
    button:SetWidth(buttonwidth)
    button:SetCallback("OnClick", function() EDAB:MultiBarBottomLeft(false) end)
    container:AddChild(button)
    local button = EDABUI:Create("Button")
    button:SetText("Show")
    button:SetWidth(buttonwidth)
    button:SetCallback("OnClick", function() EDAB:MultiBarBottomLeft(true) end)
    container:AddChild(button) 
------------------------------------------------------------------------------------
    local bag = EDABUI:Create("Label")
    bag:SetText("Multi Bar Bottom Right:")
    bag:SetFullWidth(true)
    bag:SetFont(intabheadline:GetFont())
    container:AddChild(bag)
    local button = EDABUI:Create("Button")
    button:SetText("Hide")
    button:SetWidth(buttonwidth)
    button:SetCallback("OnClick", function() EDAB:MultiBarBottomRight(false) end)
    container:AddChild(button)
    local button = EDABUI:Create("Button")
    button:SetText("Show")
    button:SetWidth(buttonwidth)
    button:SetCallback("OnClick", function() EDAB:MultiBarBottomRight(true) end)
    container:AddChild(button) 
-------------------------------------------------------------------------------------
    local bag = EDABUI:Create("Label")
    bag:SetText("Multi Bar Left:")
    bag:SetFullWidth(true)
    bag:SetFont(intabheadline:GetFont())
    container:AddChild(bag)
    local button = EDABUI:Create("Button")
    button:SetText("Hide")
    button:SetWidth(buttonwidth)
    button:SetCallback("OnClick", function() EDAB:MultiBarLeft(false) end)
    container:AddChild(button)
    local button = EDABUI:Create("Button")
    button:SetText("Show")
    button:SetWidth(buttonwidth)
    button:SetCallback("OnClick", function() EDAB:MultiBarLeft(true) end)
    container:AddChild(button) 
--------------------------------------------------------------------
    local bag = EDABUI:Create("Label")
    bag:SetText("Multi Bar Right:")
    bag:SetFullWidth(true)
    bag:SetFont(intabheadline:GetFont())
    container:AddChild(bag)
    local button = EDABUI:Create("Button")
    button:SetText("Hide")
    button:SetWidth(buttonwidth)
    button:SetCallback("OnClick", function() EDAB:MultiBarRight(false) end)
    container:AddChild(button)
    local button = EDABUI:Create("Button")
    button:SetText("Show")
    button:SetWidth(buttonwidth)
    button:SetCallback("OnClick", function() EDAB:MultiBarRight(true) end)

    container:AddChild(button) 
----------------------------------------------------------
    local bag = EDABUI:Create("Label")
    bag:SetText("Stance Bar:")
    bag:SetFullWidth(true)
    bag:SetFont(intabheadline:GetFont())
    container:AddChild(bag)
    local button = EDABUI:Create("Button")
    button:SetText("Hide")
    button:SetWidth(buttonwidth)
    button:SetCallback("OnClick", function() EDAB:StanceBar(false) end)
    container:AddChild(button)
    local button = EDABUI:Create("Button")
    button:SetText("Show")
    button:SetWidth(buttonwidth)
    button:SetCallback("OnClick", function() EDAB:StanceBar(true) end)
    container:AddChild(button) 
---------------------------------------------------------------
    local bag = EDABUI:Create("Label")
    bag:SetText("Pet Bar:")
    bag:SetFullWidth(true)
    bag:SetFont(intabheadline:GetFont())
    container:AddChild(bag)
    local button = EDABUI:Create("Button")
    button:SetText("Hide")
    button:SetWidth(buttonwidth)
    button:SetCallback("OnClick", function() EDAB:PetBar(false) end)
    container:AddChild(button)
    local button = EDABUI:Create("Button")
    button:SetText("Show")
    button:SetWidth(buttonwidth)
    button:SetCallback("OnClick", function() EDAB:PetBar(true) end)
    container:AddChild(button) 
----------------------------------------------------------
  end
]]--
-- Create the frame container
local frame = EDABUI:Create("Frame")
frame:SetTitle("Enhanced Action Bars")
frame:SetStatusText("Flex timed mehr 20er als 15er")
frame:SetCallback("OnClose", function(widget) EDABUI:Release(widget) end)
frame:SetLayout("Fill")
-- Callback function to show container content
local function SelectGroup(container, event, group)
    container:ReleaseChildren()
    if group == "tab1" then
        DrawGroup1(container)
        frame:SetStatusText("Stance Bar, Pet Bar & Micro Bar require a /reload")
    elseif group == "tab2" then
        DrawGroup2(container)
        frame:SetStatusText("Fadeout has to be a number e.g. 7.2")
    end
end
  -- Create the TabGroup
  local tab =  EDABUI:Create("TabGroup")
  tab:SetLayout("Flow")
  -- Setup which tabs to show
  tab:SetTabs({{text="Hide UI Parts", value="tab1"}, {text="Mouseover Bars", value="tab2"}})
  -- Register callback
  tab:SetCallback("OnGroupSelected", SelectGroup)
  -- Set initial Tab (this will fire the OnGroupSelected callback)
  tab:SelectTab("tab1")
  -- add to the frame container
  frame:AddChild(tab)
end
