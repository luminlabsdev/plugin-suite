local Packages = script.Parent.Parent.Packages
local InternalPackages = script.Parent.Parent.Internal

local Framework = require(Packages.framework)
local Communicator = require(InternalPackages.Communicator)

local GlobalComponents = script.Parent.Components
local PluginComponents = script.Components
local Ignite = require(Packages.ignite)
local Fusion = require(Packages.fusion)

local Children = Fusion.Children
local OnEvent = Fusion.OnEvent
local peek = Fusion.peek
local Scoped = Fusion.scoped
local Scope = Scoped(Fusion, Ignite, {
	Setting = require(GlobalComponents.Setting),
	NavigationTabbed = require(GlobalComponents.NavigationTabbed),
	FilterContainer = require(PluginComponents.FilterContainer),
})

local RuleParser = require(script.RuleParser)

local CATEGORY = "Utilities"
local NAME = "PreciseSelection"
local Active = Scope:Value(false)

local function CreateFilter(tab: Instance, filterType: string)
	local ParsedRule = RuleParser.Parse(filterType)
	if ParsedRule then
		Scope:FilterContainer {
			FilterType = ParsedRule[1],
			FilterDescription = ParsedRule[2],
			Parent = tab:FindFirstChild("Scrollable:ScrollFrame") :: Instance,
		}
	end
end

local function Init()
	local Toolbar = Communicator.Toolbars[CATEGORY]

	Toolbar:Append("Precise Selection", "Open plugin", "rbxassetid://105589339245320", function()
		Active:set(not peek(Active))
	end)

	local Navigation, TabStates = Scope:NavigationTabbed {
		Sections = { "Selection", "Settings" },
		DefaultActiveSection = 1,
		ActiveSection = 1,
	}

	local PluginSettings: { [string]: { [string]: any } } = {
		["Add To Selection"] = {
			Description = "Whether or not to add filtered selection to the current selection",
			Value = Scope:Value(false),
		},
	}

	local FilterType = Scope:Value("")

	local Tab1
	Tab1 = Scope:Scrollable {
		Size = UDim2.new(1, 0, 1, -35),
		CanvasSize = UDim2.fromScale(0, 1),
		Visible = TabStates[1],
		LayoutOrder = 2,
		[Children] = {
			Scope:TextLabel {
				Text = "Create a new filter on the selector page\nFilter rules are similar to how CSS rules are",
			},

			Scope:TextInput {
				Value = FilterType,
				Placeholder = "Filter rules",
			},

			Scope:Button {
				Width = UDim.new(1, 0),
				Text = "Create Filter",
				Variant = "Primary" :: "Primary",

				[OnEvent "MouseButton1Click"] = function()
                    CreateFilter(Tab1, peek(FilterType))
                end,
			},

			Scope:Button {
				Width = UDim.new(1, 0),
				Text = "Select Items",
				Variant = "Primary" :: "Primary",

				[OnEvent "MouseButton1Click"] = function() end,
			},

			Scope:New "UIListLayout" {
				FillDirection = Enum.FillDirection.Vertical,
				Padding = UDim.new(0, 8),
				SortOrder = Enum.SortOrder.LayoutOrder,
			},

			Scope:New "UIPadding" {
				PaddingLeft = UDim.new(0, 16),
				PaddingRight = UDim.new(0, 16),
				PaddingTop = UDim.new(0, 16),
				PaddingBottom = UDim.new(0, 16),
			},
		},
	}

	local Tab2 = Scope:Background {
		Visible = TabStates[2],
		LayoutOrder = 2,
		[Children] = {
			Scope:New "UIListLayout" {
				FillDirection = Enum.FillDirection.Vertical,
				Padding = UDim.new(0, 8),
				SortOrder = Enum.SortOrder.LayoutOrder,
			},

			Scope:New "UIPadding" {
				PaddingLeft = UDim.new(0, 16),
				PaddingRight = UDim.new(0, 16),
				PaddingTop = UDim.new(0, 16),
				PaddingBottom = UDim.new(0, 16),
			},
		},
	}

	for settingName, settingData in PluginSettings do
		Scope:Setting {
			Parent = Tab2,
			Name = settingName,
			Setting = settingData,
		}
	end

	Scope:Widget {
		Id = "PreciseSelection",
		Title = "Precise Selection",
		InitDockState = Enum.InitialDockState.Left,
		FloatXSize = 400,
		FloatYSize = 180,

		Enabled = Active,

		[Children] = {
			Scope:New "UIListLayout" {
				FillDirection = Enum.FillDirection.Vertical,
				Padding = UDim.new(0, 8),
				SortOrder = Enum.SortOrder.LayoutOrder,
			},

			Tab1,
			Tab2,

			Scope:New "UIPadding" {
				PaddingLeft = UDim.new(0, 8),
				PaddingRight = UDim.new(0, 8),
				PaddingTop = UDim.new(0, 8),
				PaddingBottom = UDim.new(0, 8),
			},

			Navigation,
		},
	}
end

Scope:SetPlugin(Framework.Plugin)

return Framework.New {
	Uses = { Communicator },
	Init = Init,
}
