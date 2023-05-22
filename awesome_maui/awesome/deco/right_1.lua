--Awesome modules
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local deco = {
  -- wallpaper = require("deco.wallpaper"),
  taglist = require("deco.taglist"),
  tasklist = require("deco.tasklist")
}

local _M = {}

--Separator
local Separator_small = wibox.widget.textbox("  ")
local Separator = wibox.widget.textbox("   ")
Separator.forced_height = 33

local Separator_aa = wibox.widget.textbox("  ")
Separator_aa.forced_height = 120
Separator_aa.forced_width = 20


--BAttery Widget
local batteryarc_widget = require("deco.widgets.batteryarc")


--Wibox
local right_first = awful.popup {
  screen = s,
  widget = wibox.container.background,
  ontop = true,
  bg = "#111111",
  visible = true,
  -- maximum_width = 200,
  placement = function(c) awful.placement.top_right(c, { margins = 8 }) end,
  shape = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 5)
  end,
  opacity = 0.9
}

right_first:setup({
  Separator,
  batteryarc_widget({
    show_current_level = true,
    arc_thickness = 2,
    size = 23,
    font = "CaskaydiaCove Nerd Font 9",
    margins = 55,
    timeout = 10,
  }),
  Separator,
  {
    {
      id = "usericon",
      widget = wibox.widget.imagebox,
      image = os.getenv("HOME") .. "/.icons/papirus-icon-theme-20230301/Papirus/user.png",
      resize = false,
      opacity = 1,
    },
    layout = wibox.container.place
  },

  Separator,
  layout = wibox.layout.fixed.horizontal,
  height = 40
})

--Widget
local Shutdown = require("deco.widgets.powermenu_containers.shutdown")
local Restart = require("deco.widgets.powermenu_containers.restart")
local Logout = require("deco.widgets.powermenu_containers.logout")
local Lock = require("deco.widgets.powermenu_containers.lock")



local Menu = awful.popup {
  screen = s,
  widget = wibox.container.background,
  ontop = true,
  bg = "#111111",
  visible = false,
  -- maximum_width = 200,
  forced_height = 67,
  -- forced_width = 400,
  placement = function(c)
    awful.placement.top_right(c,
      { margins = { top = 428, bottom = 5, left = 8, right = 8 } })
  end,
  shape = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 5)
  end,
  opacity = 0.9
}

Menu:setup({
  Separator_aa,
  {
    Shutdown,
    layout = wibox.container.place
  },
  Separator_aa,
  {
    Restart,
    layout = wibox.container.place
  },
  Separator_aa,
  {
    Logout,
    layout = wibox.container.place
  },
  Separator_aa,
  {
    Lock,
    layout = wibox.container.place
  },
  Separator_aa,

  layout = wibox.layout.fixed.horizontal
})

-- Define button callback function
right_first:connect_signal("button::release", function()
  Menu.visible = not Menu.visible
end)
