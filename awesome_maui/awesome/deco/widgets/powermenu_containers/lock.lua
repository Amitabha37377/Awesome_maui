local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local Separator = wibox.widget.textbox("     ")

------------------------
--Buttons
------------------------

bg_color = "#222222"

Lock = wibox.widget {
  {
    {
      widget = wibox.widget.imagebox,
      image = os.getenv("HOME") .. "/.icons/papirus-icon-theme-20230301/Papirus/powermenu/locked.png",
      resize = true,
      opacity = 1,
    },
    left   = 15,
    right  = 15,
    top    = 15,
    bottom = 15,
    widget = wibox.container.margin

  },
  bg = bg_color,
  shape = gears.shape.rounded_rect,
  widget = wibox.container.background,
  forced_height = 80,
  forced_width = 80,

}

return Lock
