local Packages = script.Parent.Parent.Parent.Parent.Packages
local Fusion = require(Packages.fusion)
local Children = Fusion.Children

type UsedAs<T> = Fusion.UsedAs<T>
type CaptureSpace = {
	Transparency: UsedAs<number>?,
	LayoutOrder: UsedAs<number>,
}

return function(scope: Fusion.Scope<typeof(Fusion)>, props: CaptureSpace)
	return scope:New "Frame" {
		Name = "CaptureSpace",
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Size = UDim2.new(1, 0, 1, -6),
		ZIndex = 2,

		BackgroundTransparency = props.Transparency or 1,
		LayoutOrder = props.LayoutOrder,
		[Children] = {
			scope:New "UIAspectRatioConstraint" {},
			scope:New "UIStroke" {
				ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
				Color = Color3.fromRGB(231, 231, 231),
				Thickness = 3,
			},
		},
	}
end
