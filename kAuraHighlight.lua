-- defines
local AURAS = {
	-- Death Knight
	{ id = 48707 }, -- anti-magic shell
	{ id = 48792 }, -- icebound fortitude
	{ id = 49222 }, -- bone shield
	{ id = 49039 }, -- lichborne
	{ id = 48265 }, -- unholy presence
	{ id = 48266 }, -- blood presence
	{ id = 48263 }, -- frost presence
	{ id = 51271 }, -- pillar of frost
	-- Druid
	{ id = 8936 }, -- regrowth
	{ id = 774 }, -- rejuvenation
	{ id = 33763 }, -- lifebloom
	{ id = 22812 }, -- barkskin
	-- Hunter
	{ id = 19263 }, -- deterrence
	-- Mage
	{ id = 45438 }, -- ice block
	{ id = 11426 }, -- ice barrier
	-- Priest (updated)
	{ id = 17 }, -- power word: shield
	{ id = 152118 }, -- clarity of will
	{ id = 194384, caster = "player", notoriety = "FRIEND" }, -- atonement (own)
	{ id = 194384, notoriety = "ENEMY" }, -- atonement (enemy)
	{ id = 33206 }, -- pain suppresion
	{ id = 47585 }, -- dispersion 

	{ id = 34914, caster = "player", notoriety = "ENEMY"}, -- vampiric touch (enemy)
	{ id = 589, caster = "player", notoriety = "ENEMY"}, -- shadow word: pain (enemy)
	-- Paladin
	{ id = 6940 }, -- hand of sacrifice
	{ id = 1044 }, -- hand of freedom
	{ forceId = 148039, caster = "player", notoriety = "FRIEND" }, -- sacred shield (friendly)
	{ forceId = 148039, notoriety = "ENEMY" }, -- sacred shield (enemy)
	{ id = 25771 }, -- forbearance
	{ id = 53563 }, -- beacon of light
	-- Rogue
	{ id = 26669 }, -- evasion
	-- Shaman
	{ id = 49284 }, -- earth shield
	-- Warlock
	{ id = 110913 }, -- dark bargain
	-- Warrior
};

local FRAME_MARGIN = 3;
local ICON_MARGIN = 2;
local ICON_SIZE = 26;
	
-- imports
local kCore = kCore;
local kWidgets = kWidgets;
local kEvents = kEvents;

local UnitAuras = kCore.UnitAuras;

local AuraFrame = kWidgets.AuraFrame;

-- private
local HealthBarAuraFrame = function(parent, anchor, x, y)
	local frame = kWidgets.AuraFrame(parent, UnitAuras);
	frame:SetIconSize(ICON_SIZE);
	frame:SetMargin(FRAME_MARGIN);
	frame:SetPoint(anchor, parent.Health, anchor, x, y);
	frame:SetFrameStrata(parent:GetFrameStrata());
	frame:SetFrameLevel(parent.Health:GetFrameLevel() + 10);	
	frame:AddFilter(AURAS);

	local drFrame = kWidgets.DrFrame(parent);
	drFrame:SetIconSize(ICON_SIZE);
	drFrame:SetMargin(FRAME_MARGIN);
	if (anchor == "CENTER") then
		drFrame:SetPoint("TOP", parent.Power, "TOP", 0, -ICON_MARGIN);
	else
		drFrame:SetPoint(anchor, parent.Power, anchor, x, y);
	end
	drFrame:SetFrameStrata(parent:GetFrameStrata());
	drFrame:SetFrameLevel(parent.Power:GetFrameLevel() + 10);
end

-- event handlers

-- main
HealthBarAuraFrame(ElvUF_Player, "CENTER", 0, 0);

HealthBarAuraFrame(ElvUF_Target, "CENTER", 0, 0);

for index = 1, 5 do
	local frame = _G[ "ElvUF_PartyGroup1UnitButton" .. tostring( index ) ]
	if ( not frame ) then break; end
	
	HealthBarAuraFrame( frame, "TOPRIGHT", -ICON_MARGIN, -ICON_MARGIN );
end
	
for index = 1, 5 do
	local frame = _G[ "ElvUF_Arena" .. tostring( index ) ]
	if ( not frame ) then break; end
	
	HealthBarAuraFrame( frame, "TOPLEFT", ICON_MARGIN, -ICON_MARGIN );
end

--[[
for index = 1, 5 do
	local frame = _G[ "oUF_PartyPet" .. tostring( index ) ]
	if ( not frame ) then break; end

	HealthBarAuraFrame( frame, "TOPRIGHT", -ICON_MARGIN, -ICON_MARGIN );
end

do
	local event;
	local partyFramesCreated = 1;
	local OnGroupRosterUpdate = function( self )
		for index = partyFramesCreated, 5 do
			local frame = _G[ "ElvUF_PartyGroup1UnitButton" .. tostring( index ) ];
			if ( not frame ) then
				break;
			end
			
			HealthBarAuraFrame( frame, "TOPRIGHT", -ICON_MARGIN, -ICON_MARGIN );
			partyFramesCreated = partyFramesCreated + 1
		end

		if ( partyFramesCreated > 5 ) then
			kEvents.UnregisterEvent( event );
		end
	end
	event = kEvents.RegisterEvent( "GROUP_ROSTER_UPDATE", OnGroupRosterUpdate );
end
]]