local Packages = script.Parent.Parent.Parent.Packages
local Fusion = require(Packages.fusion)
local Ignite = require(Packages.ignite)
local Children = Fusion.Children
local peek = Fusion.peek

local DataTypeToComponent = {
    boolean = "Switch",
    string = "TextInput",
    number = "Slider"
}

local ComponentToProp = {
    Switch = "Enabled",
    TextInput = "Value",
    Slider = "ProgressPercent",
}

type UsedAs<T> = Fusion.UsedAs<T>
type Setting = {
    Parent: Instance,
    Name: string,
	Setting: { [string]: any },
}

return function(scope: Fusion.Scope<typeof(Fusion) & typeof(Ignite)>, props: Setting)
    local SettingType = type(peek(props.Setting.Value))
    local ComponentType = DataTypeToComponent[SettingType]
    print(SettingType)
    print(ComponentType)
	return scope:Container {
		Header = { Text = props.Name },
        Parent = props.Parent,
        [Children] = {
            scope:TextLabel {
                Text = props.Setting.Description,
                TextWrapped = true,
            },

            (scope[ComponentType] :: any)(scope, {
                [ComponentToProp[ComponentType]] = props.Setting.Value,
            }),

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
        },
	}
end
