local Packages = script.Parent.Packages
local Aegis = require(Packages.aegis)

local new = Aegis.new

local Components = {}

function Components.Frame(Props)
    return new("Frame", {
        BackgroundColor3 = Color3.fromRGB(46, 46, 46)

    })
end
