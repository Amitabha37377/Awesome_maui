--Awesome modules
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

-- local deco = {
--   wallpaper = require("deco.wallpaper"),
-- }

--Separator
local Separator_small = wibox.widget.textbox("  ")
local Separator = wibox.widget.textbox("   ")
Separator.forced_height = 33



local _M = {}

local right_third = awful.popup {
  screen = s,
  widget = wibox.container.background,
  ontop = false,
  bg = "#111111",
  visible = true,
  maximum_width = 200,
  placement = function(c)
    awful.placement.top_right(c,
      { margins = { top = 8, bottom = 8, left = 8, right = 175 } })
  end,
  shape = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 5)
  end,
  opacity = 0.9
}

right_third:setup({
  Separator,
  {
    {
      id = "play",
      widget = wibox.widget.imagebox,
      image = os.getenv("HOME") .. "/.icons/papirus-icon-theme-20230301/Papirus/mic.png",
      resize = false,
      opacity = 1,
    },
    layout = wibox.container.place
  },


  Separator_small,
  {
    {
      id = "play2",
      widget = wibox.widget.imagebox,
      image = os.getenv("HOME") .. "/.icons/papirus-icon-theme-20230301/Papirus/audio_maui.png",
      resize = false,
      opacity = 1,
    },
    layout = wibox.container.place
  },

  Separator,
  {
    {
      id = "play2",
      widget = wibox.widget.imagebox,
      image = os.getenv("HOME") .. "/.icons/papirus-icon-theme-20230301/Papirus/brightness_maui.png",
      resize = false,
      opacity = 1,
    },
    layout = wibox.container.place
  },


  Separator,
  layout = wibox.layout.fixed.horizontal,
})

-- right_third:get_children_by_id("play2"):connect_signal("button::press", function()
--   awful.spawn("thunar")
-- end)

--All Widgets
local brightness_container = require("deco.widgets.brightness")
local volume_container = require("deco.widgets.volume")
local microphone_container = require("deco.widgets.microphone")

--Slider menues
local sliders = wibox.widget {
  {
    brightness_container,
    widget = wibox.container.margin,
    shape = gears.shape.rounded_rect,
    margins = 10,
  },
  {
    volume_container,
    widget = wibox.container.margin,
    shape = gears.shape.rounded_rect,
    margins = 10
  },
  {
    microphone_container,
    widget = wibox.container.margin,
    shape = gears.shape.rounded_rect,
    margins = 10
  },

  widget = wibox.container.background,
  bg = "33333380",
  layout = wibox.layout.fixed.vertical
}


local control_slider = awful.popup {
  screen = s,
  widget = wibox.container.background,
  ontop = true,
  bg = "#111111",
  visible = false,
  placement = function(c) awful.placement.top_right(c, { margins = { top = 228, right = 8 } }) end,
  shape = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 5)
  end,
  opacity = 0.9
}

control_slider:setup({
  -- brightness_container,
  sliders,
  -- volume_container,
  layout = wibox.layout.fixed.vertical
})

-- Define button callback function
right_third:connect_signal("button::release", function()
  control_slider.visible = not control_slider.visible
end)
