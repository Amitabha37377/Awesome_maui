--Global Modules
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")

--Separator
local Separator = wibox.widget.textbox("   ")
local Separator2 = wibox.widget.textbox("   ")
local Separator_small = wibox.widget.textbox("     ")
Separator.forced_height = 120
Separator.forced_width = 20
Separator_small.forced_height = 33


----------------------------------
--Buttons-------------------------
----------------------------------

--Open all Menu Buttons
Toggle_menu = wibox.widget {
  widget = wibox.widget.imagebox,
  image = os.getenv("HOME") .. "/.icons/papirus-icon-theme-20230301/Papirus/menu.png",
  resize = true,
  opacity = 1,
}

--Open Dashboard button
Toggle_dashboard = wibox.widget {
  widget = wibox.widget.imagebox,
  image = os.getenv("HOME") .. "/.icons/papirus-icon-theme-20230301/Papirus/bluetooth.png",
  resize = true,
  opacity = 1,
}

--Systray Widget
local my_round_systray = wibox.widget {
  {
    wibox.widget.systray(),
    left   = 10,
    top    = 0,
    bottom = 0,
    right  = 10,
    widget = wibox.container.margin,
  },
  bg         = "#111111",
  shape      = gears.shape.rounded_rect,
  shape_clip = true,
  widget     = wibox.container.background,
}


-----------------------------
--Popup Box------------------
-----------------------------

local right_fifth = awful.popup {
  screen = s,
  widget = wibox.container.background,
  ontop = false,
  bg = "#111111",
  visible = true,
  -- maximum_width = 200,
  maximum_height = 33,
  maximum_width = 300,
  placement = function(c)
    awful.placement.top_right(c,
      { margins = { top = 8, bottom = 8, left = 8, right = 386 } })
  end,

  shape = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 5)
  end,
  opacity = 0.9
}

right_fifth:setup({
  -- Separator,

  my_round_systray,
  -- Separator,
  -- {
  --   Toggle_dashboard,
  --   layout = wibox.container.place
  -- },
  -- Separator2,
  {
    Toggle_menu,
    layout = wibox.container.place
  },

  Separator2,
  layout = wibox.layout.fixed.horizontal,
  height = 40
})


--------------------------------
--Adding all popup box ---------
--------------------------------

local first = require("deco.widgets.control_center")
local second = require("deco.right_3")
local third = require("deco.right_2")
local fourth = require("deco.right_1")

------------------------------------------
--Repositioning the popup boxes-----------
------------------------------------------
second.placement = function(c)
  awful.placement.top_right(c,
    { margins = { top = 228, bottom = 5, left = 8, right = 8 } })
end

third.placement = function(c)
  awful.placement.top_right(c,
    { margins = { top = 418, bottom = 5, left = 8, right = 8 } })
end

fourth.placement = function(c)
  awful.placement.top_right(c,
    { margins = { top = 598, bottom = 5, left = 8, right = 8 } })
end


Toggle_menu:connect_signal("button::release", function()
  first.visible = not first.visible
  second.visible = not second.visible
  third.visible = not third.visible
  fourth.visible = not fourth.visible
end)
