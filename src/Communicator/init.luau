local Packages = script.Parent.Packages
local AegisComponentsStudio = require(Packages.aegiscomponents_studio)
local Aegis = require(Packages.aegis)

local PluginComponents = AegisComponentsStudio.PluginComponents

local New = Aegis.new

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
		Toolbars[category] = New(PluginComponents.Toolbar, {
			Name = category,
		}) :: PluginToolbar
	end
	Initiated = true
end

return {
	Init = Init,

	Initiated = Initiated,
	Toolbars = Toolbars,
}
