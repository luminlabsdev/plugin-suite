local Packages = script.Packages
local Framework = require(Packages.framework)
local InternalPackages = script.Internal
local ThumbnailCapture = require(script.Plugins.ThumbnailCapture)

Framework.Start(Framework.Load({
    InternalPackages,
}))

ThumbnailCapture.Init()
