local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local Separator = wibox.widget.textbox("     ")

------------------------
--Buttons
------------------------

bg_color = "#222222"

Shutdown = wibox.widget {
  {
    {
      widget = wibox.widget.imagebox,
      image = os.getenv("HOME") .. "/.icons/papirus-icon-theme-20230301/Papirus/powermenu/shutdown.png",
      resize = true,
      opacity = 1,
    },
    left   = 3,
    right  = 3,
    top    = 3,
    bottom = 3,
    widget = wibox.container.margin

  },
  bg = bg_color,
  shape = gears.shape.rounded_rect,
  widget = wibox.container.background,
  forced_height = 53,
  forced_width = 53,

}

Restart = wibox.widget {
  {
    {
      widget = wibox.widget.imagebox,
      image = os.getenv("HOME") .. "/.icons/papirus-icon-theme-20230301/Papirus/powermenu/refresh.png",
      resize = true,
      opacity = 1,
    },
    left   = 3,
    right  = 3,
    top    = 3,
    bottom = 3,
    widget = wibox.container.margin

  },
  bg = bg_color,
  shape = gears.shape.rounded_rect,
  widget = wibox.container.background,
  forced_height = 53,
  forced_width = 53,

}

Logout = wibox.widget {
  {
    {
      widget = wibox.widget.imagebox,
      image = os.getenv("HOME") .. "/.icons/papirus-icon-theme-20230301/Papirus/powermenu/logout.png",
      resize = true,
      opacity = 1,
    },
    left   = 3,
    right  = 3,
    top    = 3,
    bottom = 3,
    widget = wibox.container.margin

  },
  bg = bg_color,
  shape = gears.shape.rounded_rect,
  widget = wibox.container.background,
  forced_height = 53,
  forced_width = 53,

}

Lock = wibox.widget {
  {
    {
      widget = wibox.widget.imagebox,
      image = os.getenv("HOME") .. "/.icons/papirus-icon-theme-20230301/Papirus/powermenu/locked.png",
      resize = true,
      opacity = 1,
    },
    left   = 3,
    right  = 3,
    top    = 3,
    bottom = 3,
    widget = wibox.container.margin

  },
  bg = bg_color,
  shape = gears.shape.rounded_rect,
  widget = wibox.container.background,
  forced_height = 53,
  forced_width = 53,

}
