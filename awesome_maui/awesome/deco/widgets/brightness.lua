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
local brightness_slider = wibox.widget({
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
  value = tonumber(io.popen("light -G"):read("*all")),
})

--FUnctionality of Brightness Slider
brightness_slider:connect_signal("property::value", function(slider)
  local brightness_level = math.floor(slider.value / 100 * 100)
  awful.spawn.easy_async("light -S " .. brightness_level, function()
  end)
end)

--Image for brightness Slider
local brightness_pic = {
  id = "brightness",
  widget = wibox.widget.imagebox,
  image = os.getenv("HOME") .. "/.icons/papirus-icon-theme-20230301/Papirus/brightness2.png",
  resize = true,
  opacity = 1,
}

-- local brightness_container = wibox.widget {
--   {
--     {
--       brightness_pic,
--       {
--         brightness_slider,
--         widget = wibox.container.margin,
--         margins = 10,
--         forced_width = 250,
--         forced_height = 40,
--       },
--       layout = wibox.layout.fixed.horizontal
--     },
--     bg = "#111111",
--     shape = gears.shape.rounded_rect,
--     widget = wibox.container.background,
--     forced_width = 300,
--     forced_height = 70,
--   }
-- }

local brightness_container = {
  {
    id = "brightness",
    widget = wibox.widget.imagebox,
    image = os.getenv("HOME") .. "/.icons/papirus-icon-theme-20230301/Papirus/brightness2.png",
    resize = true,
    opacity = 1,
  },
  {
    brightness_slider,
    widget = wibox.container.margin,
    margins = 10,
    forced_width = 350,
    forced_height = 60,
  },
  layout = wibox.layout.fixed.horizontal,
  forced_width = 400,
  forced_height = 40,
}


return brightness_container
