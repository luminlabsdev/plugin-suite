local Packages = script.Parent.Parent.Parent.Parent.Packages
local Aegis = require(Packages.aegis)

local New = Aegis.new

type CaptureSpace = {
	Transparency: number?,
	LayoutOrder: number,
	[any]: any,
}

return function(props: CaptureSpace)
	return New("Frame", {
		Name = "CaptureSpace",
		BackgroundColor3 = Color3.fromRGB(0, 0, 0),
		AnchorPoint = Vector2.new(0.5, 0.5),
		Size = UDim2.new(1, 0, 1, -6),
		ZIndex = 2,

		BackgroundTransparency = props.Transparency or 1,
		LayoutOrder = props.LayoutOrder,
	}, {
		New("UIAspectRatioConstraint"),
		New("UIStroke", {
			ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
			Color = Color3.fromRGB(231, 231, 231),
			Thickness = 3,
		}),
	})
end
