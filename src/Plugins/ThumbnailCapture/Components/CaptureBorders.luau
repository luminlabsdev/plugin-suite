local Packages = script.Parent.Parent.Parent.Parent.Packages
local Fusion = require(Packages.fusion)
local Children = Fusion.Children

type UsedAs<T> = Fusion.UsedAs<T>
type CaptureBorders = {
	BackgroundColor: UsedAs<Color3>?,
	LayoutOrder: UsedAs<number>?,
}

return function(scope: Fusion.Scope<typeof(Fusion)>, props: CaptureBorders)
	return scope:New "Frame" {
		Name = "Border",
		Size = UDim2.fromScale(0, 1),

		BackgroundColor3 = props.BackgroundColor or Color3.fromRGB(0, 0, 0),
		LayoutOrder = props.LayoutOrder,
        [Children] = props[Children]
	}
end
