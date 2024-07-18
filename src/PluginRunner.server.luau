local Toolbar = plugin:CreateToolbar("AssetPreview")
local MainButton = Toolbar:CreateButton("AssetPreview", "Preview Assets when highlighting them", "", "AssetPreviewer")

local AssetPreviewer = require(script.Parent.AssetPreviewer)
AssetPreviewer._init(MainButton)

local activated = false
local widget
MainButton.Click:Connect(function()
    activated = not activated
    if activated then 
        widget = plugin:CreateDockWidgetPluginGui("AssetPreviewer", DockWidgetPluginGuiInfo.new(
            Enum.InitialDockState.Float,
            true, 
            false, 
            500,
            200,
            150,
            150
        ))
        widget:BindToClose(function()
            activated = false
            widget:Destroy()
        end)
        AssetPreviewer.CreateGui(widget) 
    else
        widget:Destroy()
    end
end)
