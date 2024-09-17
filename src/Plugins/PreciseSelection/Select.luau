local SelectionService = game:GetService("Selection")

local function Select(add: boolean, objects: { Instance })
    if add then
        SelectionService:Add(objects)
    else
        SelectionService:Set(objects)
    end
end

return function(rules: { { string } })
    local Objects = {}
	for _, rule in rules do
        
	end
end
