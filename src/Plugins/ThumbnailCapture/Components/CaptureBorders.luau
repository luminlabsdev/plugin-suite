local Packages = script.Parent.Parent.Parent.Parent.Packages
local Aegis = require(Packages.aegis)

local New = Aegis.new

type CaptureBorders = {
	BackgroundColor: Color3?,
	LayoutOrder: number,
	[any]: any,
}

return function(props: CaptureBorders)
	return New("Frame", {
		Name = "Border",
		Size = UDim2.fromScale(0, 1),

		BackgroundColor3 = props.BackgroundColor or Color3.fromRGB(0, 0, 0),
		LayoutOrder = props.LayoutOrder,
	}, props.Children)
end
