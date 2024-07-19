local CoreGui = game:GetService("CoreGui")

local Packages = script.Parent.Parent.Packages
local InternalPackages = script.Parent.Parent

local Communicator = require(InternalPackages.Communicator)

local CaptureCurrentSnapshot = require(script.CaptureCurrentSnapshot)
local AegisComponentsStudio = require(Packages.aegiscomponents_studio)
local Aegis = require(Packages.aegis)

local PluginComponents = AegisComponentsStudio.PluginComponents

local New = Aegis.new
local State = Aegis.state
local Events = Aegis.Key("Events") :: Aegis.Key

local Components = script.Components

local CaptureSpace = require(Components.CaptureSpace)
local CaptureBorders = require(Components.CaptureBorders)

local CATEGORY = "Building"
local Active = State(false)

local function Init()
	New(PluginComponents.ToolbarButton, {
		Toolbar = Communicator.Toolbars[CATEGORY],
		Active = Active,

		OnClick = function()
			Active:Set(not Active:Get())
		end,

		Description = "Thumbnail Capture",
		ToolTip = "Start capture",
		Image = "",
		Name = "Thumbnail Capture",
	})

	New("ScreenGui", {
		Name = "ThumbnailCapture",
		Archivable = false,
		IgnoreGuiInset = true,
		Enabled = Active,
		Parent = CoreGui,
	}, {
		Layout = New("UIListLayout", {
			VerticalAlignment = Enum.VerticalAlignment.Center,
			HorizontalFlex = Enum.UIFlexAlignment.Fill,
			FillDirection = Enum.FillDirection.Horizontal,
			SortOrder = Enum.SortOrder.LayoutOrder,
		}),
		CaptureBorder1 = New(CaptureBorders, {
			LayoutOrder = 1,
		}),
		CaptureSpace = New(CaptureSpace, {
			LayoutOrder = 2,
		}),
		CaptureBorder2 = New(CaptureBorders, {
			LayoutOrder = 3,
		}, {
			CaptureButton = New("TextButton", {
				Name = "CaptureButton",
				BackgroundColor3 = Color3.fromRGB(249, 249, 249),
				Position = UDim2.new(1, -130, 1, -60),
				Size = UDim2.fromOffset(110, 40),
				FontFace = Font.fromName("SourceSansPro", Enum.FontWeight.SemiBold),
				Text = "Capture",
				TextSize = 20,

				[Events] = {
					Activated = function()
						CaptureCurrentSnapshot()
						Active:Set(false)
					end,
				},
			}, {
				New("UICorner", {
					CornerRadius = UDim.new(0, 10),
				}),
			}),
		}),
	})
end

return {
	Init = Init,
}
