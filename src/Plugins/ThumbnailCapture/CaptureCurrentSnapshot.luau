local SelectionService = game:GetService("Selection")

return function()
	local Camera = Instance.fromExisting(workspace.CurrentCamera)
	local CurrentSelection = SelectionService:Get()

	Camera.Name = "ThumbnailCamera"

	if CurrentSelection[1] and CurrentSelection[1]:IsA("Model") then
		Camera.Parent = CurrentSelection[1]
		SelectionService:Set({ Camera })
		return
	end

	Camera.Parent = workspace
	SelectionService:Set({ Camera })
end
