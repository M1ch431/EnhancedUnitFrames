function ColorStyling()
	-- Changes the Shaman class color to reflect live.

	if isClassic() then
		local function Color()
			RAID_CLASS_COLORS['SHAMAN']["r"] = 0
			RAID_CLASS_COLORS['SHAMAN']["g"] = 0.44
			RAID_CLASS_COLORS['SHAMAN']["b"] = 0.87
			RAID_CLASS_COLORS['SHAMAN']["colorStr"] = "ff0070de"
		end

		if eufCharacterDB.enabled then
			if eufCharacterDB.shamanClassColorFix then
				Color()
			end
		else
			if eufDB.shamanClassColorFix then
				Color()
			end
		end
	end

	-- Source: whoa UnitFrames by whoarrior & smokked_.
	-- Changes the unit frame health bar colors to the unit's class or reaction color.

	function HealthBarColor(self, unit)
		local function ClassColor()
			if UnitIsPlayer(unit) and UnitIsConnected(unit) and UnitClass(unit) then
				local classColor = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[select(2, UnitClass(self.unit))]

				if classColor then
					self:SetStatusBarColor(classColor.r, classColor.g, classColor.b)
				end
			elseif UnitIsPlayer(unit) and not UnitIsConnected(unit) then
				self:SetStatusBarColor(0.5, 0.5, 0.5)
			else
				self:SetStatusBarColor(0, 0.9, 0)
			end
		end

		local function ReactionColor()
			local function Color()
				if UnitIsTapDenied(unit) and not UnitPlayerControlled(unit) then
					self:SetStatusBarColor(0.5, 0.5, 0.5)
				elseif not UnitIsTapDenied(unit) then
					local reactionColor = FACTION_BAR_COLORS[UnitReaction(unit, "player")]

					if reactionColor then
						self:SetStatusBarColor(reactionColor.r, reactionColor.g, reactionColor.b)
					else
						self:SetStatusBarColor(0, 0.9, 0)
					end
				end
			end

			if eufCharacterDB.enabled then
				if eufCharacterDB.reactionHealthBarColor and not eufCharacterDB.classHealthBarColor then
					if UnitExists(unit) then
						Color()
					end
				else
					if UnitExists(unit) and not UnitIsPlayer(unit) then
						Color()
					end
				end
			else
				if eufDB.reactionHealthBarColor and not eufDB.classHealthBarColor then
					if UnitExists(unit) then
						Color()
					end
				else
					if UnitExists(unit) and not UnitIsPlayer(unit) then
						Color()
					end
				end
			end
		end

		if eufCharacterDB.enabled then
			if eufCharacterDB.classHealthBarColor then
				ClassColor()
			end

			if eufCharacterDB.reactionHealthBarColor then
				ReactionColor()
			end
		else
			if eufDB.classHealthBarColor then
				ClassColor()
			end

			if eufDB.reactionHealthBarColor then
				ReactionColor()
			end
		end
	end

	hooksecurefunc("HealthBar_OnValueChanged", function(self)
		HealthBarColor(self, self.unit)
	end)

	hooksecurefunc("UnitFrameHealthBar_Update", HealthBarColor)

	-- Changes the unit frame name background colors to the unit's class or reaction color.

	function NameBackgroundColor(self, unit)
		local function ClassColor()
			if UnitIsPlayer(unit) and UnitIsConnected(unit) and UnitClass(unit) then
				local classColor = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[select(2, UnitClass(self.unit))]

				if classColor then
					self.nameBackground:SetVertexColor(classColor.r, classColor.g, classColor.b)
				end
			elseif UnitIsPlayer(unit) and not UnitIsConnected(unit) then
				self.nameBackground:SetVertexColor(0.5, 0.5, 0.5)
			else
				self.nameBackground:SetVertexColor(0, 0.9, 0)
			end
		end

		local function ReactionColor()
			if eufCharacterDB.enabled then
				if eufCharacterDB.reactionNameBackgroundColor and not eufCharacterDB.classNameBackgroundColor then
					if UnitExists(unit) then
						if UnitIsTapDenied(unit) and not UnitPlayerControlled(unit) then
							self.nameBackground:SetVertexColor(0.5, 0.5, 0.5)
						elseif not UnitIsTapDenied(unit) then
							local reactionColor = FACTION_BAR_COLORS[UnitReaction(unit, "player")]

							if reactionColor then
								self.nameBackground:SetVertexColor(reactionColor.r, reactionColor.g, reactionColor.b)
							else
								self.nameBackground:SetVertexColor(0, 0.9, 0)
							end
						end
					end
				else
					if UnitExists(unit) and not UnitIsPlayer(unit) then
						if UnitIsTapDenied(unit) and not UnitPlayerControlled(unit) then
							self.nameBackground:SetVertexColor(0.5, 0.5, 0.5)
						elseif not UnitIsTapDenied(unit) then
							local reactionColor = FACTION_BAR_COLORS[UnitReaction(unit, "player")]

							if reactionColor then
								self.nameBackground:SetVertexColor(reactionColor.r, reactionColor.g, reactionColor.b)
							else
								self.nameBackground:SetVertexColor(0, 0.9, 0)
							end
						end
					end
				end
			else
				if eufDB.reactionNameBackgroundColor and not eufDB.classNameBackgroundColor then
					if UnitExists(unit) then
						if UnitIsTapDenied(unit) and not UnitPlayerControlled(unit) then
							self.nameBackground:SetVertexColor(0.5, 0.5, 0.5)
						elseif not UnitIsTapDenied(unit) then
							local reactionColor = FACTION_BAR_COLORS[UnitReaction(unit, "player")]

							if reactionColor then
								self.nameBackground:SetVertexColor(reactionColor.r, reactionColor.g, reactionColor.b)
							else
								self.nameBackground:SetVertexColor(0, 0.9, 0)
							end
						end
					end
				else
					if UnitExists(unit) and not UnitIsPlayer(unit) then
						if UnitIsTapDenied(unit) and not UnitPlayerControlled(unit) then
							self.nameBackground:SetVertexColor(0.5, 0.5, 0.5)
						elseif not UnitIsTapDenied(unit) then
							local reactionColor = FACTION_BAR_COLORS[UnitReaction(unit, "player")]

							if reactionColor then
								self.nameBackground:SetVertexColor(reactionColor.r, reactionColor.g, reactionColor.b)
							else
								self.nameBackground:SetVertexColor(0, 0.9, 0)
							end
						end
					end
				end
			end
		end

		if eufCharacterDB.enabled then
			if eufCharacterDB.classNameBackgroundColor then
				ClassColor()
			end

			if eufCharacterDB.reactionNameBackgroundColor then
				ReactionColor()
			end
		else
			if eufDB.classNameBackgroundColor then
				ClassColor()
			end

			if eufDB.reactionNameBackgroundColor then
				ReactionColor()
			end
		end
	end

	-- Changes the unit frame name background colors to the unit's class or reaction color.

	hooksecurefunc("TargetFrame_CheckClassification", function(self, forceNormalTexture)
		NameBackgroundColor(self, self.unit)
	end)

	-- Hides the unit frame name background.

	hooksecurefunc("TargetFrame_CheckClassification", function(self, forceNormalTexture)
		if eufCharacterDB.enabled then
			if eufCharacterDB.hideNameBackground then
				self.nameBackground:SetAlpha(0)
			end
		else
			if eufDB.hideNameBackground then
				self.nameBackground:SetAlpha(0)
			end
		end
	end)
end