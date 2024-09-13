local Packages = script.Parent.Parent.Packages
local Framework = require(Packages.framework)

local Initiated = false
local Toolbars = {}
local Categories = {
	"Building",
	"Data Management",
	"Lighting & Environment",
	"Utilities",
}

local function Init()
	for _, category in Categories do
		Toolbars[category] = Framework.Toolbar.New(category)
	end
	Initiated = true
end

return Framework.New({
	Init = Init,

	Initiated = Initiated,
	Toolbars = Toolbars,
})
