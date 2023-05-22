-- Modules
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

--Spacer
local separator = wibox.widget.textbox("    ")

-----------------------------
--Brightness Slider Widget
-----------------------------
local volume_slider = wibox.widget({
  widget = wibox.widget.slider,
  bar_shape = gears.shape.rounded_rect,
  bar_height = 10,
  bar_color = "#b7b2f1",
  handle_shape = gears.shape.circle,
  handle_color = "#ffffff",
  handle_width = 20,
  handle_border_width = 1,
  handle_border_color = "#aaaaaa",
  minimum = 5,
  maximum = 100,
})

-- Define a timer to update the volume slider value every second
local update_volume_slider = function()
  awful.spawn.easy_async("amixer sget Master", function(stdout)
    local volume = tonumber(string.match(stdout, "(%d?%d?%d)%%"))
    volume_slider.value = volume
  end)
end

local volume_slider_timer = gears.timer({
  timeout = 1,
  call_now = true,
  autostart = true,
  callback = update_volume_slider,
})

-- Add signal to set the Volume using amixer
volume_slider:connect_signal("property::value", function(slider)
  local volume_level = math.floor(slider.value / 100 * 65537)
  awful.spawn.easy_async("amixer set Master" .. volume_level, function()
  end)
end)


local volume_container = {
  {
    id = "audio",
    widget = wibox.widget.imagebox,
    image = os.getenv("HOME") .. "/.icons/papirus-icon-theme-20230301/Papirus/audio2.png",
    resize = true,
    opacity = 1,
  },
  {
    volume_slider,
    widget = wibox.container.margin,
    margins = 10,
    forced_width = 350,
    forced_height = 60,
  },
  layout = wibox.layout.fixed.horizontal,
  forced_width = 400,
  forced_height = 40,
}


return volume_container
