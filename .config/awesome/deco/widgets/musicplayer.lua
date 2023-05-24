local wibox = require("wibox")
local lgi = require("lgi")

local Playerctl = lgi.Playerctl
local player = Playerctl.Player {}
local playerctl_widget = wibox.widget.textbox()

update_metadata = function()
  if player:get_title() then
    playerctl_widget:set_text(player:get_artist() .. " – " .. player:get_title())
  else
    playerctl_widget:set_text('Nothing Playing')
  end
end

player.on_metadata = update_metadata

playerctl_widget:connect_signal("button::press", function() player:play_pause() end)

update_metadata()

return playerctl_widget


-- local awful = require("awful")
-- local wibox = require("wibox")
-- local naughty = require("naughty")
--
-- -- Create the widget
-- local music_widget = wibox.widget {
--   {
--     id = "icon",
--     widget = wibox.widget.imagebox,
--     resize = true
--   },
--   {
--     id = "text",
--     widget = wibox.widget.textbox
--   },
--   layout = wibox.layout.fixed.horizontal
-- }
--
-- -- Function to update the music information
-- local function update_music_widget()
--   awful.spawn.easy_async("mpc -f '%title%|%album%|%artist%|%file%' current", function(stdout)
--     local title, album, artist, file = stdout:match("([^|]+)|([^|]+)|([^|]+)|([^|]+)")
--
--     -- Update the widget content
--     music_widget:get_children_by_id("text")[1]:set_markup(string.format(
--       "<b>%s</b>\n<i>%s</i>\n%s",
--       title or "",
--       album or "",
--       artist or ""
--     ))
--
--     -- Update the album picture
--     if file then
--       local album_art = string.format("%s/cover.jpg", file:match("(.*/).-$"))
--       music_widget:get_children_by_id("icon")[1]:set_image(album_art)
--     end
--   end)
-- end
--
-- -- Create a tooltip to display the music information
-- local music_tooltip = awful.tooltip {
--   objects = { music_widget },
--   delay_show = 1,
--   text = "Loading..."
-- }
--
-- -- Function to show the music tooltip
-- local function show_music_tooltip()
--   naughty.destroy(music_tooltip)
--   update_music_widget()
--   naughty.notification {
--     icon = music_widget:get_children_by_id("icon")[1]:get_image(),
--     title = "Now Playing",
--     message = music_widget:get_children_by_id("text")[1]:get_text(),
--     timeout = 5,     -- Adjust the timeout as desired
--     hover_timeout = 0.5,
--     hover_callback = function()
--       update_music_widget()
--       return music_tooltip
--     end
--   }
-- end
--
-- -- Update the music information periodically (adjust the interval as desired)
-- awful.widget.watch("mpc -f '%title%|%album%|%artist%|%file%' current", 5, function(widget, stdout)
--   -- Check if the music has changed
--   if stdout ~= widget.last_stdout then
--     widget.last_stdout = stdout
--     show_music_tooltip()
--   end
-- end, music_widget)
--
-- -- Connect the mouse button event to show the music tooltip on click
-- music_widget:connect_signal("button::press", function(_, _, _, button)
--   if button == 1 then
--     show_music_tooltip()
--   end
-- end)
--
-- return music_widget
