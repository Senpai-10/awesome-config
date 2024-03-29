local awful = require("awful")
local default = require("lua.rc.default")
local trim = require("lua.helpers.trim")

local M = {}

-- Delete the current tag
function M.delete_tag()
	local tag = awful.screen.focused().selected_tag

	tag:delete()
end

-- Create a new tag at the end of the list
function M.add_tag()
	awful.tag
		.add(default.tag_icon, {
			screen = awful.screen.focused(),
			layout = awful.layout.layouts[1],
		})
		:view_only()
end

-- Rename the current tag
function M.rename_tag()
	local current_tag_name = trim(awful.screen.focused().selected_tag.name)

	awful.prompt.run({
		prompt = " <b>New tag name:</b> ",
		text = current_tag_name,
		textbox = awful.screen.focused().mypromptbox.widget,
		exe_callback = function(new_name)
			if not new_name or #new_name == 0 then
				return
			end

			local t = awful.screen.focused().selected_tag
			if t then
				-- padd inside tag name
				--  e. g " 1 "
				-- t.name = new_name

				if new_name == "icon" then
					t.name = default.tag_icon
				else
					t.name = " " .. new_name .. " "
				end
			end
		end,
	})
end

-- Move the focused client to a new tag
function M.move_to_new_tag()
	local c = client.focus
	if not c then
		return
	end

	local tag_name = " " .. c.class .. " "
	local t = awful.tag.add(tag_name, { screen = c.screen })
	c:tags({ t })
	t:view_only()
end

-- Copy the current tag at the end of the list
function M.copy_tag()
	local t = awful.screen.focused().selected_tag
	if not t then
		return
	end

	local clients = t:clients()
	local t2 = awful.tag.add(t.name, awful.tag.getdata(t))
	t2:clients(clients)
	t2:view_only()
end

return M
