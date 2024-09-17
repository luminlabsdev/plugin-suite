local RuleTypeToDescription = {
	name = "Does the instance have the specified name?",
	tag = "Does the instance have the specified tag?",
	class = "Does the instance have the specified class name?",
}

local ModifierTypeToDescription = {
    child = "Does the instance have children that match the following rules?"
}

local function Parse(ruleType: string): {string}?
    ruleType = ruleType:lower()
	if RuleTypeToDescription[ruleType] then
        return {string.gsub(ruleType, "^.", function(result)
            return result:upper()
        end), RuleTypeToDescription[ruleType]}
	end
    return nil
end

return {
	Parse = Parse,
}
