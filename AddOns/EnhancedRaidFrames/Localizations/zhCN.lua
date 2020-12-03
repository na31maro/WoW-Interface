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

local L = LibStub("AceLocale-3.0"):NewLocale("EnhancedRaidFrames", "zhCN", false)

if not L then return end

L["Animations"] = "动画效果"
L["Attached to Cursor"] = "附着在光标上"
L["Aura Watch List"] = "光环监视列表"
L["auras_desc"] = "在这里显示监视的增益、减益法术和“wildcards”列表"
L["auras_usage"] = "任何有效的光环名称或法术ID在正确拼写的情况下都应该可以正常工作"
L["Background Opacity"] = "背景不透明度"
L["backgroundAlpha_desc"] = "团队框架背景的不透明度百分比"
L["Blizzard Default"] = "暴雪原生默认"
L["blizzardRaidOptionsButton_desc"] = "打开系统自带的团队框架界面设置菜单"
L["Bottom Center"] = "下部中间"
L["Bottom Left"] = "下部左侧"
L["Bottom Right"] = "下部右侧"
L["Color"] = "颜色"
L["Color By Debuff Type"] = "默认颜色"
L["Color By Remaining Time"] = "根据剩余时间显示颜色"
L["colorByDebuff_desc"] = "根据减益法术的类型来决定颜色"
L["colorByTime_desc"] = "根据剩余时间来决定颜色"
--[[Translation missing --]]
--[[ L["colorByTime_high_desc"] = ""--]] 
--[[Translation missing --]]
--[[ L["colorByTime_low_desc"] = ""--]] 
L["colorOverride_desc"] = "这将代替默认的颜色"
L["Countdown"] = "倒数计时"
L["Curse"] = "诅咒"
L["curseWildcard_desc"] = "任何诅咒类型的减益"
L["customRange_desc"] = "代替默认的超出距离指示器（默认为40码）"
L["customRangeCheck_desc"] = "将默认的40码超出距离指示器修改为指定的距离"
L["Default Icon Visibility"] = "系统默认图标的可见性"
L["Disease"] = "疾病"
L["diseaseWildcard_desc"] = "任何疾病类型的减益"
L["Example"] = "举例"
L["frameScale_desc"] = "团队框架相对于正常尺寸的比例"
L["General"] = "通常"
L["General Options"] = "通常设置"
L["generalOptions_desc"] = "配置团队标记图标在团队框架上如何显示"
L["Glow At Countdown Time"] = "倒计时发光"
L["glowRemainingSecs_desc1"] = "在增益或减益法术倒计时发光开始之前的时间长度（单位为秒）"
L["glowRemainingSecs_desc2"] = "“0”代表将一直发光"
L["Horizontal Offset"] = "水平位置补偿"
L["horizontalOffset_desc"] = "水平位置相对于起始位置的补偿百分比"
L["Icon"] = "图标"
L["Icon and Visuals"] = "图标和视觉效果"
L["Icon Opacity"] = "图标不透明度"
L["Icon Options"] = "图标设置"
L["Icon Position"] = "图标位置"
L["Icon Size"] = "图标大小"
L["iconAlpha_desc"] = "图标不透明度的百分比"
L["iconPosition_desc"] = "图标相对于团队框架的位置"
L["iconSize_desc"] = "图标的像素大小"
L["Indicator Color"] = "指示器颜色"
L["Indicator Font"] = "指示器字体"
L["Indicator Glow Effect"] = "指示器发光效果"
L["Indicator Options"] = "指示器设置"
--[[Translation missing --]]
--[[ L["Indicator Size"] = ""--]] 
--[[Translation missing --]]
--[[ L["indicatorAlpha_desc"] = ""--]] 
--[[Translation missing --]]
--[[ L["indicatorColor_desc1"] = ""--]] 
--[[Translation missing --]]
--[[ L["indicatorColor_desc2"] = ""--]] 
--[[Translation missing --]]
--[[ L["indicatorFont_desc"] = ""--]] 
--[[Translation missing --]]
--[[ L["indicatorGlow_desc"] = ""--]] 
--[[Translation missing --]]
--[[ L["indicatorOptions_desc"] = ""--]] 
--[[Translation missing --]]
--[[ L["indicatorSize_desc"] = ""--]] 
--[[Translation missing --]]
--[[ L["instructions_desc1"] = ""--]] 
--[[Translation missing --]]
--[[ L["instructions_desc2"] = ""--]] 
--[[Translation missing --]]
--[[ L["Magic"] = ""--]] 
--[[Translation missing --]]
--[[ L["magicWildcard_desc"] = ""--]] 
--[[Translation missing --]]
--[[ L["meOnly_desc"] = ""--]] 
--[[Translation missing --]]
--[[ L["Middle Center"] = ""--]] 
--[[Translation missing --]]
--[[ L["Middle Left"] = ""--]] 
--[[Translation missing --]]
--[[ L["Middle Right"] = ""--]] 
--[[Translation missing --]]
--[[ L["Mine Only"] = ""--]] 
--[[Translation missing --]]
--[[ L["mineOnly_desc"] = ""--]] 
--[[Translation missing --]]
--[[ L["missingOnly_desc"] = ""--]] 
--[[Translation missing --]]
--[[ L["None"] = ""--]] 
--[[Translation missing --]]
--[[ L["Open the Blizzard Raid Profiles Menu"] = ""--]] 
--[[Translation missing --]]
--[[ L["Out-of-Range"] = ""--]] 
--[[Translation missing --]]
--[[ L["Out-of-Range Opacity"] = ""--]] 
--[[Translation missing --]]
--[[ L["Override Default Distance"] = ""--]] 
--[[Translation missing --]]
--[[ L["Poison"] = ""--]] 
--[[Translation missing --]]
--[[ L["poisonWildcard_desc"] = ""--]] 
--[[Translation missing --]]
--[[ L["Position"] = ""--]] 
--[[Translation missing --]]
--[[ L["Profiles"] = ""--]] 
--[[Translation missing --]]
--[[ L["pvpWildcard_desc"] = ""--]] 
--[[Translation missing --]]
--[[ L["Raidframe Scale"] = ""--]] 
--[[Translation missing --]]
--[[ L["rangeAlpha_desc"] = ""--]] 
--[[Translation missing --]]
--[[ L["Select a Custom Distance"] = ""--]] 
--[[Translation missing --]]
--[[ L["Show Countdown Swipe"] = ""--]] 
--[[Translation missing --]]
--[[ L["Show Icon"] = ""--]] 
--[[Translation missing --]]
--[[ L["Show On Me Only"] = ""--]] 
--[[Translation missing --]]
--[[ L["Show Only if Missing"] = ""--]] 
--[[Translation missing --]]
--[[ L["Show Raid Icons"] = ""--]] 
--[[Translation missing --]]
--[[ L["Show Text"] = ""--]] 
--[[Translation missing --]]
--[[ L["Show Tooltip"] = ""--]] 
--[[Translation missing --]]
--[[ L["showBuffs_desc"] = ""--]] 
--[[Translation missing --]]
--[[ L["showCountdownSwipe_desc"] = ""--]] 
--[[Translation missing --]]
--[[ L["showDebuffs_desc"] = ""--]] 
--[[Translation missing --]]
--[[ L["showDispellableDebuffs_desc"] = ""--]] 
--[[Translation missing --]]
--[[ L["showIcon_desc1"] = ""--]] 
--[[Translation missing --]]
--[[ L["showIcon_desc2"] = ""--]] 
--[[Translation missing --]]
--[[ L["showRaidIcons_desc"] = ""--]] 
--[[Translation missing --]]
--[[ L["showText_desc"] = ""--]] 
--[[Translation missing --]]
--[[ L["showTooltip_desc"] = ""--]] 
--[[Translation missing --]]
--[[ L["Stack Size"] = ""--]] 
--[[Translation missing --]]
--[[ L["Stock Buff Icons"] = ""--]] 
--[[Translation missing --]]
--[[ L["Stock Debuff Icons"] = ""--]] 
--[[Translation missing --]]
--[[ L["Stock Dispellable Icons"] = ""--]] 
--[[Translation missing --]]
--[[ L["Text"] = ""--]] 
--[[Translation missing --]]
--[[ L["Text Color"] = ""--]] 
--[[Translation missing --]]
--[[ L["Text Size"] = ""--]] 
--[[Translation missing --]]
--[[ L["textColor_desc1"] = ""--]] 
--[[Translation missing --]]
--[[ L["textColor_desc2"] = ""--]] 
--[[Translation missing --]]
--[[ L["textSize_desc"] = ""--]] 
--[[Translation missing --]]
--[[ L["Time #1"] = ""--]] 
--[[Translation missing --]]
--[[ L["Time #2"] = ""--]] 
--[[Translation missing --]]
--[[ L["Tooltip Location"] = ""--]] 
--[[Translation missing --]]
--[[ L["tooltipLocation_desc"] = ""--]] 
--[[Translation missing --]]
--[[ L["Tooltips"] = ""--]] 
--[[Translation missing --]]
--[[ L["Top Center"] = ""--]] 
--[[Translation missing --]]
--[[ L["Top left"] = ""--]] 
--[[Translation missing --]]
--[[ L["Top Right"] = ""--]] 
--[[Translation missing --]]
--[[ L["totWildcard_desc"] = ""--]] 
--[[Translation missing --]]
--[[ L["Vertical Offset"] = ""--]] 
--[[Translation missing --]]
--[[ L["verticalOffset_desc"] = ""--]] 
--[[Translation missing --]]
--[[ L["Visibility and Behavior"] = ""--]] 
--[[Translation missing --]]
--[[ L["Wildcards"] = ""--]] 
--[[Translation missing --]]
--[[ L["zeroMeansIgnored_desc"] = ""--]] 


