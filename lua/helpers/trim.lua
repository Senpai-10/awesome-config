return function(s)
	return (s:gsub("^%s*(.-)%s*$", "%1"))
end
