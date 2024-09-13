local SelectionService = game:GetService("Selection")

return function(objects: { Instance })
	SelectionService:Set(objects)
end
