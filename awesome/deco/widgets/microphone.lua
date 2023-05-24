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

--Image for brightness Slider
local mic_pic = {
  id = "mic",
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

local microphone_container = {
  {
    id = "brightness",
    widget = wibox.widget.imagebox,
    image = os.getenv("HOME") .. "/.icons/papirus-icon-theme-20230301/Papirus/microphone.png",
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


return microphone_container
