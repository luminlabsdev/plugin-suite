local Packages = script.Packages
local Framework = require(Packages.framework)
local InternalPackages = script.Internal
local Plugins = script.Plugins

local Fusion = require(Packages.fusion)
local Ignite = require(Packages.ignite)

local PreciseSelection = require(Plugins.PreciseSelection)
local ThumbnailCapture = require(Plugins.ThumbnailCapture)

Framework.Start(Framework.Load({
    InternalPackages,
}))

PreciseSelection.Init()
ThumbnailCapture.Init()
