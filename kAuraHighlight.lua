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
		-- Druid
		{ id = 8936 }, -- regrowth
		{ id = 774 }, -- rejuvenation
		{ id = 33763 }, -- lifebloom
		{ id = 22812 }, -- barkskin
		-- Hunter
		-- Mage
		-- Priest
		{ id = 17 }, -- power word: shield
		{ id = 33206 }, -- pain suppresion
		{ id = 139 }, -- renew
		{ id = 6788 }, -- weakened soul
		{ id = 33076, caster = "player" }, -- prayer of mending
		{ id = 6346 }, -- fear ward
		-- Paladin
		{ id = 6940 }, -- hand of sacrifice
		{ forceId = 53601 }, -- sacred shield
		{ id = 25771 }, -- forbearance
		-- Rogue
		{ id = 26669 }, -- evasion
		-- Shaman
		{ id = 49284 }, -- earth shield
		-- Warlock
		-- Warrior
	};

-- imports
local kCore = kCore;
local kWidgets = kWidgets;
local kEvents = kEvents;

local UnitAuras = kCore.UnitAuras;

local AuraFrame = kWidgets.AuraFrame;

-- private
local HealthBarAuraFrame = function( parent, anchor, x, y )
	local frame = kWidgets.AuraFrame( parent, UnitAuras );
	frame:SetIconSize( 22 );
	frame:SetMargin( 3 );
	frame:SetPoint( anchor, parent.Health, anchor, x, y );
	frame:SetFrameStrata( parent:GetFrameStrata() );
	frame:SetFrameLevel( parent.Health:GetFrameLevel() + 1 );	
	frame:AddFilter( AURAS );
end

-- event handlers

-- main
HealthBarAuraFrame( oUF_Tukz_player, "TOP", 0, -3 );
HealthBarAuraFrame( oUF_Tukz_target, "TOP", 0, -3 );
	
for index = 1, 5 do
	local frame = _G[ "oUF_Arena" .. tostring( index ) ]
	if ( not frame ) then break; end
	
	HealthBarAuraFrame( frame, "TOPLEFT", 3, -3 );
end

for index = 1, 5 do
	local frame = _G[ "oUF_PartyPet" .. tostring( index ) ]
	if ( not frame ) then break; end

	HealthBarAuraFrame( frame, "TOPRIGHT", -3, -3 );
end

do
	local event;
	local partyFramesCreated = 1;
	local OnPartyMembersChanged = function( self )
		for index = partyFramesCreated, 5 do
			local frame = _G[ "oUF_GroupUnitButton" .. tostring( index ) ];
			if ( not frame ) then
				break;
			end
			
			HealthBarAuraFrame( frame, "TOPRIGHT", -3, -3 );
			partyFramesCreated = partyFramesCreated + 1
		end
		
		if ( partyFramesCreated > 5 ) then
			kEvents.UnregisterEvent( event );
		end
	end
	event = kEvents.RegisterEvent( "PARTY_MEMBERS_CHANGED", OnPartyMembersChanged );
end