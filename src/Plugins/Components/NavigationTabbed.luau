local Packages = script.Parent.Parent.Parent.Packages
local Fusion = require(Packages.fusion)
local Ignite = require(Packages.ignite)
local peek = Fusion.peek

type UsedAs<T> = Fusion.UsedAs<T>
type Navigation = {
	Sections: { string },
    ActiveSection: Fusion.UsedAs<number>,
    DefaultActiveSection: Fusion.UsedAs<number?>?,
    FillDirection: Fusion.UsedAs<Enum.FillDirection>?
}

return function(scope: Fusion.Scope<typeof(Fusion) & typeof(Ignite)>, props: Navigation)
    local TabStates = {}
    for index in props.Sections do
        table.insert(TabStates, index, scope:Value(
            if index == props.ActiveSection then true else false
        ))
    end

    local CurrentlyActiveTab = scope:Value(props.ActiveSection)
    local CurrentlyActiveTabObserver = scope:Observer(CurrentlyActiveTab)

    CurrentlyActiveTabObserver:onChange(function()
        for _, value in TabStates do
			value:set(false)
		end
		TabStates[peek(CurrentlyActiveTab :: any)]:set(true)
    end)

    local Navigation = scope:Navigation {
        Sections = props.Sections,
        ActiveSection = CurrentlyActiveTab :: any,
        DefaultActiveSection = props.DefaultActiveSection,
        FillDirection = props.FillDirection,
    }

	return Navigation, TabStates
end
