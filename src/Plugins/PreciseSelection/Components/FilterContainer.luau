local Packages = script.Parent.Parent.Parent.Parent.Packages
local Fusion = require(Packages.fusion)
local Ignite = require(Packages.ignite)
local Children = Fusion.Children
local OnEvent = Fusion.OnEvent

type UsedAs<T> = Fusion.UsedAs<T>
type FilterContainer = {
	FilterType: UsedAs<string>,
    Parent: UsedAs<Instance>,
	FilterDescription: UsedAs<string>,
}

return function(scope: Fusion.Scope<typeof(Fusion) & typeof(Ignite)>, props: FilterContainer)
    local InputValue = scope:Value("")
    local Container
    Container = scope:Container {
        Header = {Text =  props.FilterType},
        Parent = props.Parent,
        LayoutOrder = 3,
        [Children] = {
            scope:TextInput {
                Value = InputValue,
                Placeholder = "Rule..."
            },

            scope:TextLabel {
                Text = props.FilterDescription
            },

            scope:Button {
                Text = "Delete",
                Variant = "Destructive" :: "Destructive",
                [OnEvent "MouseButton1Click"] = function()
                    Container:Destroy()
                end,
            },

            scope:New "UIListLayout" {
				FillDirection = Enum.FillDirection.Vertical,
				Padding = UDim.new(0, 8),
				SortOrder = Enum.SortOrder.LayoutOrder,
			},

            scope:New "UIPadding" {
                PaddingLeft = UDim.new(0, 8),
                PaddingRight = UDim.new(0, 8),
                PaddingTop = UDim.new(0, 8),
                PaddingBottom = UDim.new(0, 8),
            },
        }
    }
	return InputValue, Container
end
