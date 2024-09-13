local CoreGui = game:GetService "CoreGui"

local Packages = script.Parent.Parent.Packages
local InternalPackages = script.Parent.Parent.Internal

local Framework = require(Packages.framework)
local Communicator = require(InternalPackages.Communicator)

local Components = script.Components
local CaptureCurrentSnapshot = require(script.CaptureCurrentSnapshot)

local Fusion = require(Packages.fusion)

local Children = Fusion.Children
local OnEvent = Fusion.OnEvent
local peek = Fusion.peek

local scoped = Fusion.scoped
local scope = scoped(Fusion, {
	CaptureSpace = require(Components.CaptureSpace),
	CaptureBorders = require(Components.CaptureBorders),
})

local CurrentCamera = workspace.CurrentCamera

local FOVValue = scope:Value(70)
local FOVSpring = scope:Spring(FOVValue, 12.5)

local CATEGORY = "Building"
local NAME = "ThumbnailCapture"
local Active = scope:Value(false)

scope:Hydrate(workspace.CurrentCamera) {
	FieldOfView = FOVSpring,
}

local function UpdateCamera()
	CurrentCamera.AncestryChanged:Once(function()
		scope:Hydrate(workspace.CurrentCamera) {
			FieldOfView = FOVSpring,
		}
		CurrentCamera = workspace.CurrentCamera
		UpdateCamera()
	end)
end

local function Init()
	local Toolbar = Communicator.Toolbars[CATEGORY]
	Toolbar:Append("Thumbnail Capture", "Start capture", "rbxassetid://18879737891", function()
		if peek(Active) then
			FOVValue:set(70)
		else
			FOVValue:set(40)
		end
		Active:set(not peek(Active))
	end)

    if CoreGui:FindFirstChild(NAME) then
        CoreGui[NAME]:Destroy()
    end

	scope:New "ScreenGui" {
		Name = NAME,
		Archivable = false,
		IgnoreGuiInset = true,
		Enabled = Active,
		Parent = CoreGui,
		[Children] = {
			scope:New "UIListLayout" {
				VerticalAlignment = Enum.VerticalAlignment.Center,
				HorizontalFlex = Enum.UIFlexAlignment.Fill,
				FillDirection = Enum.FillDirection.Horizontal,
				SortOrder = Enum.SortOrder.LayoutOrder,
				Padding = UDim.new(0, 1),
			},
			CaptureBorder1 = scope:CaptureBorders {
				LayoutOrder = 1,
			},
			CaptureSpace = scope:CaptureSpace {
				LayoutOrder = 2,
			},
			CaptureBorder2 = scope:CaptureBorders {
				LayoutOrder = 3,
				[Children] = {
					CaptureButton = scope:New "TextButton" {
						Name = "CaptureButton",
						BackgroundColor3 = Color3.fromRGB(249, 249, 249),
						Position = UDim2.new(1, -130, 1, -60),
						Size = UDim2.fromOffset(110, 40),
						FontFace = Font.fromName("SourceSansPro", Enum.FontWeight.SemiBold),
						Text = "Capture",
						TextSize = 20,
                        AutoButtonColor = true,

						[OnEvent "Activated"] = function()
							CaptureCurrentSnapshot()
							FOVValue:set(70)
							Active:set(false)
						end,

						[Children] = {
							scope:New "UICorner" {
								CornerRadius = UDim.new(0, 10),
							},
						},
					},
				},
			},
		},
	}
end

UpdateCamera()

return Framework.New {
	Uses = { Communicator :: any },
	Init = Init,
}
