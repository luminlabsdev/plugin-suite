local ScriptEditor = game:GetService("ScriptEditorService")
local RunService = game:GetService("RunService")
local Marketplace = game:GetService("MarketplaceService")

local Packages = script.Parent.Packages
local Aegis = require(Packages.aegis)
local new = Aegis.new
local cleanup = Aegis.Key("Cleanup")

local AssetPreviewer = {
}


function AssetPreviewer.CreateGui(parent)
    local CurrentDocs = ScriptEditor:GetScriptDocuments() :: {ScriptDocument}
    local connection1 = ScriptEditor.TextDocumentDidOpen:Connect(function(newDocument: ScriptDocument)
        table.insert(CurrentDocs, newDocument)
    end)

    local connection2 = ScriptEditor.TextDocumentDidClose:Connect(function(oldDocument)
        table.remove(CurrentDocs, table.find(CurrentDocs, oldDocument))
    end)

    local LastID
    local LastCheck = 0
    local connection3 = RunService.Heartbeat:Connect(function(deltaTime)
        LastCheck += deltaTime
        if LastCheck > 0.1 then
            local ID
            LastCheck = 0
            for i,v in CurrentDocs do
                if v:IsCommandBar() then continue end
                if not v:HasSelectedText() then continue end
                local text = v:GetSelectedText()
                if string.find(text,"rbxassetid://")then
					local newstring = string.gsub(text, "rbxassetid://", "")
					local num = tonumber(newstring)
                    if num then
                        ID = num
                    end
                elseif tonumber(text)  then
                    ID = tonumber(text)
                end
            end
            if ID and ID ~= LastID then
                LastID = ID
                local foundData,err = pcall(function()
                    return Marketplace:GetProductInfo(ID)
                end)
                if foundData then
                    print(foundData, err)
                end
            end
        end
    end)

    local gui = new("ScrollingFrame", {
        Size = UDim2.new(1,0,1,0),
        Transparency = 1,
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        CanvasSize = UDim2.new(0,0,0,0),
        Parent = parent
    }, {
        ImageLabel=new("ImageLabel", {
            Size = UDim2.new(0.4,0,0.8,0),
            Position = UDim2.new(0.05,0,0.1,0)
        }, {
            new("UIAspectRatioConstraint", {
                AspectRatio = 1
            })
        }),
        TextLabel = new("TextLabel", {
            Position = UDim2.new(0.4, 0, 0.1, 0),
            Size = UDim2.new(0.5, 0, 0.15, 0),
            FontFace = Font.new(Enum.Font.Arimo.Name, Enum.FontWeight.Regular),
            TextXAlignment = Enum.TextXAlignment.Left,
            TextColor3 = Color3.new(1,1,1),
            TextScaled = true,
            BackgroundTransparency = 1
        })
    })

    gui.ImageLabel.Destroying:Connect(function()
        connection1:Disconnect()
        connection2:Disconnect()
        connection3:Disconnect()
    end)
end

function AssetPreviewer._init(button: PluginToolbarButton)


end


--[[


]]
return AssetPreviewer