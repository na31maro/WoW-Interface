--Enhanced Raid Frames, a World of Warcraft® user interface addon.

--This file is part of Enhanced Raid Frames.
--
--Enhanced Raid Frames is free software: you can redistribute it and/or modify
--it under the terms of the GNU General Public License as published by
--the Free Software Foundation, either version 3 of the License, or
--(at your option) any later version.
--
--Enhanced Raid Frames is distributed in the hope that it will be useful,
--but WITHOUT ANY WARRANTY; without even the implied warranty of
--MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
--GNU General Public License for more details.
--
--You should have received a copy of the GNU General Public License
--along with this add-on.  If not, see <https://www.gnu.org/licenses/>.
--
--Copyright for Enhanced Raid Frames is held by Britt Yazel (aka Soyier), 2017-2020.

local _, addonTable = ...
local EnhancedRaidFrames = addonTable.EnhancedRaidFrames

local media = LibStub:GetLibrary("LibSharedMedia-3.0")
local unitAuras = {} -- Matrix to keep a list of all auras on all units

EnhancedRaidFrames.iconCache = {}
EnhancedRaidFrames.iconCache["poison"] = 132104
EnhancedRaidFrames.iconCache["disease"] = 132099
EnhancedRaidFrames.iconCache["curse"] = 132095
EnhancedRaidFrames.iconCache["magic"] = 135894

-------------------------------------------------------------------------
-------------------------------------------------------------------------

function EnhancedRaidFrames:SetStockIndicatorVisibility(frame)
	if not self.db.profile.showBuffs then
		CompactUnitFrame_HideAllBuffs(frame)
	end

	if not self.db.profile.showDebuffs then
		CompactUnitFrame_HideAllDebuffs(frame)
	end

	if not self.db.profile.showDispellableDebuffs then
		CompactUnitFrame_HideAllDispelDebuffs(frame)
	end
end

-- Create the FontStrings used for indicators
function EnhancedRaidFrames:CreateIndicators(frame)
	frame.ERFIndicators = {}

	-- Create indicators
	for i = 1, 9 do
		--We have to use CompactAuraTemplate to allow for our clicks to be passed through, otherwise our frames won't allow selecting the raid frame behind it
		frame.ERFIndicators[i] = CreateFrame("Button", nil, frame, "CompactAuraTemplate")

		--create local pointer for readability
		local indicatorFrame = frame.ERFIndicators[i]

		--mark the position of this particular frame for use later (i.e. 1->9)
		indicatorFrame.position = i

		--register clicks
		indicatorFrame:RegisterForClicks("LeftButtonDown", "RightButtonUp")

		--set proper frame level
		indicatorFrame:SetFrameStrata("HIGH")

		--create font strings for both layers, the normal layer and the cooldown frame layer
		--the font string is further modified in SetIndicatorAppearance()
		indicatorFrame.cd_textPtr = indicatorFrame.cooldown:CreateFontString(nil, "OVERLAY", "NumberFontNormalSmall") --if we show the cooldown animation, text should be on the cooldown frame
		indicatorFrame.cd_textPtr:SetPoint("CENTER", indicatorFrame, "CENTER", 0, 0)
		indicatorFrame.normal_textPtr = indicatorFrame:CreateFontString(nil, "OVERLAY", "NumberFontNormalSmall") --if we don't show the cooldown animation, text should be on the parent frame
		indicatorFrame.normal_textPtr:SetPoint("CENTER", indicatorFrame, "CENTER", 0, 0)

		--create a pointer at indicatorFrame.text that will be our handle going forward to our two string pointers
		indicatorFrame.text = indicatorFrame.normal_textPtr --set initial pointer to indicatorFrame.text

		--hook enter and leave for showing ability tooltips
		self:SecureHookScript(indicatorFrame, "OnEnter", function() self:Tooltip_OnEnter(indicatorFrame) end)
		self:SecureHookScript(indicatorFrame, "OnLeave", function() GameTooltip:Hide() end)
	end

	--set our initial indicator appearance
	self:SetIndicatorAppearance(frame)
end

-- Set the appearance of the Indicator
function EnhancedRaidFrames:SetIndicatorAppearance(frame)
	-- Check if the frame has an ERFIndicators table or if we have a frame unit, this is just for safety
	if not frame.ERFIndicators or not frame.unit then
		return
	end

	for i = 1, 9 do
		--create local pointer for readability
		local indicatorFrame = frame.ERFIndicators[i]

		--set icon size
		indicatorFrame:SetWidth(self.db.profile[i].indicatorSize)
		indicatorFrame:SetHeight(self.db.profile[i].indicatorSize)

		--------------------------------------

		--set indicator frame position
		local PAD = 1
		local iconVerticalOffset = self.db.profile[i].indicatorVerticalOffset * frame:GetHeight()
		local iconHorizontalOffset = self.db.profile[i].indicatorHorizontalOffset * frame:GetWidth()

		--we probably don't want to overlap the power bar (rage, mana, energy, etc) so we need a compensation factor
		local powerBarVertOffset
		if frame.powerBar:IsShown() then
			powerBarVertOffset = frame.powerBar:GetHeight() + 2 --add 2 to not overlap the powerBar border
		else
			powerBarVertOffset = 0
		end

		indicatorFrame:ClearAllPoints()
		if i == 1 then
			indicatorFrame:SetPoint("TOPLEFT", frame, "TOPLEFT", PAD + iconHorizontalOffset, -PAD + iconVerticalOffset)
		elseif i == 2 then
			indicatorFrame:SetPoint("TOP", frame, "TOP", 0 + iconHorizontalOffset, -PAD + iconVerticalOffset)
		elseif i == 3 then
			indicatorFrame:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -PAD + iconHorizontalOffset, -PAD + iconVerticalOffset)
		elseif i == 4 then
			indicatorFrame:SetPoint("LEFT", frame, "LEFT", PAD + iconHorizontalOffset, 0 + iconVerticalOffset + powerBarVertOffset/2)
		elseif i == 5 then
			indicatorFrame:SetPoint("CENTER", frame, "CENTER", 0 + iconHorizontalOffset, 0 + iconVerticalOffset + powerBarVertOffset/2)
		elseif i == 6 then
			indicatorFrame:SetPoint("RIGHT", frame, "RIGHT", -PAD + iconHorizontalOffset, 0 + iconVerticalOffset + powerBarVertOffset/2)
		elseif i == 7 then
			indicatorFrame:SetPoint("BOTTOMLEFT", frame, "BOTTOMLEFT", PAD + iconHorizontalOffset, PAD + iconVerticalOffset + powerBarVertOffset)
		elseif i == 8 then
			indicatorFrame:SetPoint("BOTTOM", frame, "BOTTOM", 0 + iconHorizontalOffset, PAD + iconVerticalOffset + powerBarVertOffset)
		elseif i == 9 then
			indicatorFrame:SetPoint("BOTTOMRIGHT", frame, "BOTTOMRIGHT", -PAD + iconHorizontalOffset, PAD + iconVerticalOffset + powerBarVertOffset)
		end

		--------------------------------------

		--set font size, shape, font, and switch our pointer if necessary
		local font = (media and media:Fetch('font', self.db.profile.indicatorFont)) or STANDARD_TEXT_FONT

		--switch the pointer for the text overlay
		if not self.db.profile[i].showCountdownSwipe then
			indicatorFrame.text:SetText("") --clear previous text pointer
			indicatorFrame.text = indicatorFrame.normal_textPtr --switch indicatorFrame.text to point to normal_textPtr
			indicatorFrame.text:SetFont(font, self.db.profile[i].textSize, "OUTLINE")
		else
			indicatorFrame.text:SetText("") --clear previous text pointer
			indicatorFrame.text = indicatorFrame.cd_textPtr --switch indicatorFrame.text to point to cd_textPtr
			indicatorFrame.text:SetFont(font, self.db.profile[i].textSize, "OUTLINE")
		end

		--clear any animations
		ActionButton_HideOverlayGlow(indicatorFrame)
		CooldownFrame_Clear(indicatorFrame.cooldown)
		indicatorFrame.icon:SetAlpha(1)
	end
end


------------------------------------------------
--------------- Process Indicators -------------
------------------------------------------------

function EnhancedRaidFrames:UpdateIndicators(frame, setAppearance)
	--check to see if the bar is even targeting a unit, bail if it isn't
	--also, tanks have two bars below their frame that have a frame.unit that ends in "target" and "targettarget".
	--Normal raid members have frame.unit that says "Raid1", "Raid5", etc.
	--We don't want to put icons over these tiny little target and target of target bars
	--Also, in 8.2.5 blizzard unified the nameplate code with the raid frame code. Don't display icons on nameplates
	if not frame.unit
			or string.find(frame.unit, "target")
			or string.find(frame.unit, "nameplate")
			or string.find(frame.unit, "pet")
			or not CompactRaidFrameContainer:IsShown() then
		return
	end

	self:SetStockIndicatorVisibility(frame)

	-- Check if the indicator frame exists, else create it
	if not frame.ERFIndicators then
		self:CreateIndicators(frame)
	end

	if setAppearance then
		self:SetIndicatorAppearance(frame)
	end

	-- Update unit auras
	self:UpdateUnitAuras(frame.unit)

	-- Loop over all 9 indicators and process them individually
	for i = 1, 9 do
		--create local pointer for readability
		local indicatorFrame = frame.ERFIndicators[i]

		-- this is the meat of our processing loop
		self:ProcessIndicator(indicatorFrame, frame.unit)
	end
end

-- process a single indicator and apply visuals
function EnhancedRaidFrames:ProcessIndicator(indicatorFrame, unit)
	local i = indicatorFrame.position

	local foundAura, icon, count, duration, expirationTime, debuffType, castBy, auraIndex, auraType, _

	--reset auraIndex and auraType for tooltip
	indicatorFrame.auraIndex = nil
	indicatorFrame.auraType = nil

	-- if we only are to show the indicator on me, then don't bother if I'm not the unit
	if self.db.profile[i].meOnly then
		local unitName, unitRealm = UnitName(unit)
		if unitName ~= UnitName("player") or unitRealm ~= nil then
			return
		end
	end

	--------------------------------------------------------
	--- parse each aura and find the information of each ---
	--------------------------------------------------------

	for _, auraName in pairs(self.auraStrings[i]) do
		--if there's no auraName (i.e. the user never specified anything to go in this spot), stop here there's no need to keep going
		if not auraName then
			break
		end

		-- query the available information for a given indicator and aura
		foundAura, icon, count, duration, expirationTime, debuffType, castBy, auraIndex, auraType = self:QueryAuraInfo(auraName, unit)

		-- add spell icon info to cache in case we need it later on
		if icon and not self.iconCache[auraName] then
			EnhancedRaidFrames.iconCache[auraName] = icon
		end

		-- when tracking multiple things, this determines "where" we stop in the list
		-- if we find the aura, we can stop querying down the list
		-- we want to stop only when castBy == "player" if we are tracking "mine only"
		if foundAura and (not self.db.profile[i].mineOnly or (self.db.profile[i].mineOnly and castBy == "player")) then
			break
		end
	end

	------------------------------------------------------
	------- output visuals to the indicator frame --------
	------------------------------------------------------

	-- if we find the spell and we don't only want to show when it is missing
	if foundAura and UnitIsConnected(unit) and not self.db.profile[i].missingOnly and (not self.db.profile[i].mineOnly or (self.db.profile[i].mineOnly and castBy == "player")) then

		-- calculate remainingTime and round down, this is how the game seems to do it
		local remainingTime = floor(expirationTime - GetTime())

		-- set auraIndex and auraType for tooltip
		indicatorFrame.auraIndex = auraIndex
		indicatorFrame.auraType = auraType

		---------------------------------
		--- process icon to show
		---------------------------------
		if icon and self.db.profile[i].showIcon then
			indicatorFrame.icon:SetTexture(icon)
			indicatorFrame.icon:SetAlpha(self.db.profile[i].indicatorAlpha)
		else
			--set color of custom texture
			indicatorFrame.icon:SetColorTexture(
					self.db.profile[i].indicatorColor.r,
					self.db.profile[i].indicatorColor.g,
					self.db.profile[i].indicatorColor.b,
					self.db.profile[i].indicatorColor.a)

			-- determine if we should change the background color from the default (player set color)
			if self.db.profile[i].colorIndicatorByDebuff and debuffType then -- Color by debuff type
				if debuffType == "curse" then
					indicatorFrame.icon:SetColorTexture(0.64, 0.19, 0.79, 1)
				elseif debuffType == "disease" then
					indicatorFrame.icon:SetColorTexture(0.78, 0.61, 0.43, 1)
				elseif debuffType == "magic" then
					indicatorFrame.icon:SetColorTexture(0, 0.44, 0.87, 1)
				elseif debuffType == "poison" then
					indicatorFrame.icon:SetColorTexture(0.67, 0.83, 0.45, 1)
				end
			end
			if self.db.profile[i].colorIndicatorByTime then -- Color by remaining time
				if remainingTime and self.db.profile[i].colorIndicatorByTime_low ~= 0 and remainingTime <= self.db.profile[i].colorIndicatorByTime_low then
					indicatorFrame.icon:SetColorTexture(0.77, 0.12, 0.23, 1)
				elseif remainingTime and self.db.profile[i].colorIndicatorByTime_high ~= 0 and remainingTime <= self.db.profile[i].colorIndicatorByTime_high then
					indicatorFrame.icon:SetColorTexture(1, 0.96, 0.41, 1)
				end
			end
		end

		---------------------------------
		--- process text to show
		---------------------------------
		if self.db.profile[i].showText ~= "none" then
			local formattedTime = ""
			local formattedCount = ""

			-- determine the formatted time string
			if remainingTime and (self.db.profile[i].showText == "stack+countdown" or self.db.profile[i].showText == "countdown") then
				if remainingTime > 60 then
					formattedTime = string.format("%.0f", remainingTime/60).."m" -- Show minutes without seconds
				elseif remainingTime >= 0 then
					formattedTime = string.format("%.0f", remainingTime) -- Show seconds without decimals
				end
			end

			-- determine the formatted stack string
			if count and count > 0 and (self.db.profile[i].showText == "stack+countdown" or self.db.profile[i].showText == "stack") then
				formattedCount = count
			end

			-- determine the final output string concatenation
			if remainingTime ~= "" and formattedCount ~= "" then
				indicatorFrame.text:SetText(formattedCount .. "-" .. formattedTime) --append both values together with a hyphen separating
			elseif formattedCount ~= "" then
				indicatorFrame.text:SetText(formattedCount) --show just the count
			elseif remainingTime ~= "" then
				indicatorFrame.text:SetText(formattedTime) --show just the time remaining
			end
		else
			indicatorFrame.text:SetText("")
		end

		---------------------------------
		--- process text color
		---------------------------------
		--set default textColor to user selected choice
		indicatorFrame.text:SetTextColor(
				self.db.profile[i].textColor.r,
				self.db.profile[i].textColor.g,
				self.db.profile[i].textColor.b,
				self.db.profile[i].textColor.a)

		if self.db.profile[i].colorTextByDebuff and debuffType then -- Color by debuff type
			if debuffType == "curse" then
				indicatorFrame.text:SetTextColor(0.64, 0.19, 0.79, 1)
			elseif debuffType == "disease" then
				indicatorFrame.text:SetTextColor(0.78, 0.61, 0.43, 1)
			elseif debuffType == "magic" then
				indicatorFrame.text:SetTextColor(0, 0.44, 0.87, 1)
			elseif debuffType == "poison" then
				indicatorFrame.text:SetTextColor(0.67, 0.83, 0.45, 1)
			end
		end
		if self.db.profile[i].colorTextByTime then -- Color by remaining time
			if remainingTime and self.db.profile[i].colorTextByTime_low ~= 0 and remainingTime <= self.db.profile[i].colorTextByTime_low then
				indicatorFrame.text:SetTextColor(0.77, 0.12, 0.23, 1)
			elseif remainingTime and self.db.profile[i].colorTextByTime_high ~= 0 and remainingTime <= self.db.profile[i].colorTextByTime_high then
				indicatorFrame.text:SetTextColor(1, 0.96, 0.41, 1)
			end
		end

		---------------------------------
		--- set cooldown animation
		---------------------------------
		if self.db.profile[i].showCountdownSwipe and expirationTime and duration then
			CooldownFrame_Set(indicatorFrame.cooldown, expirationTime - duration, duration, true, true)
		else
			CooldownFrame_Clear(indicatorFrame.cooldown)
		end

		---------------------------------
		--- set glow animation
		---------------------------------
		if self.db.profile[i].indicatorGlow and (self.db.profile[i].glowRemainingSecs == 0 or self.db.profile[i].glowRemainingSecs >= remainingTime) then
			ActionButton_ShowOverlayGlow(indicatorFrame)
		else
			ActionButton_HideOverlayGlow(indicatorFrame)
		end

		indicatorFrame:Show() --show the frame

	elseif not foundAura and self.db.profile[i].missingOnly then --deal with "show only if missing"
		local auraName = self.auraStrings[i][1] --show the icon for the first auraString position

		--check our iconCache for the auraName. Note the icon cache is pre-populated with generic "poison", "curse", "disease", and "magic" debuff icons
		if not self.iconCache[auraName] then
			_,_,icon = GetSpellInfo(auraName)
			if not icon then
				icon = "Interface\\Icons\\INV_Misc_QuestionMark"
			end
		else
			icon = self.iconCache[auraName]
		end

		if self.db.profile[i].showIcon then
			indicatorFrame.icon:SetTexture(icon)
			indicatorFrame.icon:SetAlpha(self.db.profile[i].indicatorAlpha)
			indicatorFrame.text:SetText("")
		else
			--set color of custom texture
			indicatorFrame.icon:SetColorTexture(
					self.db.profile[i].indicatorColor.r,
					self.db.profile[i].indicatorColor.g,
					self.db.profile[i].indicatorColor.b,
					self.db.profile[i].indicatorColor.a)
			indicatorFrame.text:SetText("")
		end

		indicatorFrame:Show() --show the frame

	else
		indicatorFrame:Hide() --hide the frame
		--if no aura is found and we're not showing missing, clear animations and hide the frame
		CooldownFrame_Clear(indicatorFrame.cooldown)
		ActionButton_HideOverlayGlow(indicatorFrame)
	end
end

--process the text and icon for an indicator and return these values
--this function returns foundAura, icon, count, duration, expirationTime, debuffType, castBy, auraIndex, auraType
function EnhancedRaidFrames:QueryAuraInfo(auraName, unit)
	-- Check if the aura exist on the unit
	for _,v in pairs(unitAuras[unit]) do --loop through list of auras
		if (tonumber(auraName) and v.spellID == tonumber(auraName)) or v.auraName == auraName or (v.auraType == "debuff" and v.debuffType == auraName) then
			return true, v.icon, v.count, v.duration, v.expirationTime, v.debuffType, v.castBy, v.auraIndex, v.auraType
		end
	end

	-- Check if we want to show pvp flag
	if auraName:upper() == "PVP" then
		if UnitIsPVP(unit) then
			local factionGroup = UnitFactionGroup(unit)
			if factionGroup then
				return true, "Interface\\GroupFrame\\UI-Group-PVP-"..factionGroup, 0, 0, 0, "", "player"
			end
		end
	end

	-- Check if we want to show ToT flag
	if auraName:upper() == "TOT" then
		if UnitIsUnit(unit, "targettarget") then
			return true, "Interface\\Icons\\Ability_Hunter_SniperShot", 0, 0, 0, "", "player"
		end
	end

	return false
end


------------------------------------------------
---------- Update Auras for all units ----------
------------------------------------------------

function EnhancedRaidFrames:UpdateUnitAuras(unit)
	-- Create or clear out the tables for the unit
	unitAuras[unit] = {}

	-- Get all unit buffs
	local i = 1
	while (true) do
		local auraName, icon, count, duration, expirationTime, castBy, spellID

		if not self.isWoWClassic then
			auraName, icon, count, _, duration, expirationTime, castBy, _, _, spellID = UnitAura(unit, i, "HELPFUL")
		else
			auraName, icon, count, _, duration, expirationTime, castBy, _, _, spellID = self.UnitAuraWrapper(unit, i, "HELPFUL") --for wow classic. This is the LibClassicDurations wrapper
		end

		if not spellID then --break the loop once we have no more buffs
			break
		end

		--it's important to use the 4th argument in string.find to turn of pattern matching, otherwise things with parentheses in them will fail to be found
		if auraName and self.allAuras:find(" "..auraName:lower().." ", nil, true) or self.allAuras:find(" "..spellID.." ", nil, true) then -- Only add the spell if we're watching for it
			local auraTable = {}
			auraTable.auraType = "buff"
			auraTable.auraIndex = i
			auraTable.auraName = auraName:lower()
			auraTable.icon = icon
			auraTable.count = count
			auraTable.duration = duration
			auraTable.expirationTime = expirationTime
			auraTable.castBy = castBy
			auraTable.spellID = spellID

			table.insert(unitAuras[unit], auraTable)
		end
		i = i + 1
	end

	-- Get all unit debuffs
	i = 1
	while (true) do
		local auraName, icon, count, duration, expirationTime, castBy, spellID, debuffType

		if not self.isWoWClassic then
			auraName, icon, count, debuffType, duration, expirationTime, castBy, _, _, spellID  = UnitAura(unit, i, "HARMFUL")
		else
			auraName, icon, count, debuffType, duration, expirationTime, castBy, _, _, spellID  = self.UnitAuraWrapper(unit, i, "HARMFUL") --for wow classic. This is the LibClassicDurations wrapper
		end

		if not spellID then --break the loop once we have no more buffs
			break
		end

		--it's important to use the 4th argument in string.find to turn off pattern matching, otherwise things with parentheses in them will fail to be found
		if auraName and self.allAuras:find(" "..auraName:lower().." ", nil, true) or self.allAuras:find(" "..spellID.." ", nil, true) or (debuffType and self.allAuras:find(" "..debuffType:lower().." ", nil, true)) then -- Only add the spell if we're watching for it
			local auraTable = {}
			auraTable.auraType = "debuff"
			auraTable.auraIndex = i
			auraTable.auraName = auraName:lower()
			auraTable.icon = icon
			auraTable.count = count
			if debuffType then
				auraTable.debuffType = debuffType:lower()
			end
			auraTable.duration = duration
			auraTable.expirationTime = expirationTime
			auraTable.castBy = castBy
			auraTable.spellID = spellID

			table.insert(unitAuras[unit], auraTable)
		end
		i = i + 1
	end
end

------------------------------------------------
----------------- Tooltip Code -----------------
------------------------------------------------
function EnhancedRaidFrames:Tooltip_OnEnter(indicatorFrame)
	local i = indicatorFrame.position

	if not self.db.profile[i].showTooltip then --don't show tooltips unless we have the option set for this position
		return
	end

	local frame = indicatorFrame:GetParent() --this is the parent raid frame that holds all the indicatorFrames

	-- Set the tooltip
	if indicatorFrame.auraIndex and indicatorFrame.icon:GetTexture() then -- -1 is the pvp icon, no tooltip for that
		-- Set the buff/debuff as tooltip and anchor to the cursor
		GameTooltip:SetOwner(UIParent, self.db.profile[i].tooltipLocation)
		if indicatorFrame.auraType == "buff" then
			GameTooltip:SetUnitAura(frame.unit, indicatorFrame.auraIndex, "HELPFUL")
		else
			GameTooltip:SetUnitAura(frame.unit, indicatorFrame.auraIndex, "HARMFUL")
		end
	else
		--causes the tooltip to reset to the "default" tooltip which is usually information about the character
		if frame then
			UnitFrame_UpdateTooltip(frame)
		end
	end

	GameTooltip:Show()
end
