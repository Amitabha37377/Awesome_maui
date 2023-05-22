local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local deco = {
  taglist = require("deco.taglist"),
  tasklist = require("deco.tasklist")
}
local taglist_buttons = deco.taglist()
local tasklist_buttons = deco.tasklist()

local _M = {}

--Separator
local Separator_large = wibox.widget.textbox("     ")
local Separator = wibox.widget.textbox("   ")
Separator.forced_height = 67
-- Separator_small.forced_height = 57


------------------------------------
--Widgets--
------------------------------------


-----------------------------------
--Tasklist PopupBox widget
-----------------------------------

-- Define button widget
-- local button1 = awful.widget.button({
--   image = os.getenv("HOME") .. "/.icons/papirus-icon-theme-20230301/Papirus/icon.png",
--   widget = wibox.widget.imagebox,
--   resize = false,
-- }
-- )
local button1 = wibox.widget {
  {
    {
      widget = wibox.widget.imagebox,
      image = os.getenv("HOME") .. "/.icons/papirus-icon-theme-20230301/Papirus/48x48/apps/appimagekit-dockstation.svg",
      resize = false,
      opacity = 1,
    },
    left   = 3,
    right  = 3,
    top    = 3,
    bottom = 3,
    widget = wibox.container.margin
  },
  bg = "#111111",
  shape = gears.shape.rounded_rect,
  widget = wibox.container.background,
  forced_height = 53,
  forced_width = 53,
}


-- Define popup widget
local popup = awful.popup({
  widget = awful.widget.tasklist({
    screen = screen[1],
    filter = awful.widget.tasklist.filter.allscreen,
    buttons = tasklist_buttons,
    margins = {
      top = 10,
      bottom = 10,
      left = 10,
      right = 10,
    },
    style = {
      shape = gears.shape.rounded_rect,
    },
    layout = {
      margins = 5,
      spacing = 5,
      forced_num_rows = 2,
      layout = wibox.layout.grid.horizontal,
    },
    widget_template = {
      {
        {
          id = "clienticon",
          widget = awful.widget.clienticon,
          margins = 4,
          resize = false,
        },
        margins = 4,
        widget = wibox.container.margin,
      },
      id = "background_role",
      forced_width = 58,
      forced_height = 58,
      widget = wibox.container.background,
      create_callback = function(self, c, index, objects) --luacheck: no unused
        self:get_children_by_id("clienticon")[1].client = c
      end,
    },
  }),
  bg = "#111111",
  border_color = "#111111",
  border_width = 10,
  ontop = true,
  -- placement    = awful.placement.bottom_left + awful.placement.no_offscreen,
  placement = function(c)
    local screen_geometry = awful.screen.focused().geometry
    return awful.placement.bottom(c, { margins = { bottom = 85, right = 800 } })
  end,
  geometry = { x = 10, y = -10 },
  shape = gears.shape.rounded_rect,
  visible = false,
})

-- Define button callback function
button1:connect_signal("button::release", function()
  popup.visible = not popup.visible
end)

--------------------------------------
--Imagebox Widget
--------------------------------------
local bg_color = "#111111"
local onclick_color = "#2a2c61"
local hover_color = "#02031f"

Item1 = wibox.widget {

  {
    {
      widget = wibox.widget.imagebox,
      image = os.getenv("HOME") .. "/.icons/papirus-icon-theme-20230301/Papirus/48x48/apps/launch.svg",
      resize = false,
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

Item1:connect_signal("button::press", function(_, _, _, button)
  if button == 1 then
    awful.spawn.with_shell("rofi -show drun")
  end
end)

Item2 = wibox.widget {
  {
    {
      widget = wibox.widget.imagebox,
      image = os.getenv("HOME") .. "/.icons/papirus-icon-theme-20230301/Papirus/48x48/apps/firefox.svg",
      resize = false,
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

Item2:connect_signal("button::press", function(_, _, _, button)
  if button == 1 then
    awful.spawn.with_shell("firefox")
  end
end)


Item3 = wibox.widget {
  {
    {
      widget = wibox.widget.imagebox,
      image = os.getenv("HOME") .. "/.icons/papirus-icon-theme-20230301/Papirus/48x48/apps/kitty.svg",
      resize = false,
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

Item3:connect_signal("button::press", function(_, _, _, button)
  if button == 1 then
    awful.spawn.with_shell("kitty")
  end
end)


Item4 = wibox.widget {
  {
    {
      widget = wibox.widget.imagebox,
      image = os.getenv("HOME") .. "/.icons/papirus-icon-theme-20230301/Papirus//48x48/apps/telegram.svg",
      resize = false,
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

Item4:connect_signal("button::press", function(_, _, _, button)
  if button == 1 then
    awful.spawn.with_shell("telegram-desktop")
  end
end)


Item5 = wibox.widget {
  {
    {
      widget = wibox.widget.imagebox,
      image = os.getenv("HOME") .. "/.icons/papirus-icon-theme-20230301/Papirus/48x48/apps/Thunar.svg",
      resize = false,
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

Item5:connect_signal("button::press", function(_, _, _, button)
  if button == 1 then
    awful.spawn.with_shell("thunar")
  end
end)


Item6 = wibox.widget {
  {
    {
      widget = wibox.widget.imagebox,
      image = os.getenv("HOME") .. "/.icons/papirus-icon-theme-20230301/Papirus/48x48/apps/code.svg",
      resize = false,
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

Item6:connect_signal("button::press", function(_, _, _, button)
  if button == 1 then
    awful.spawn.with_shell("code")
  end
end)


Item7 = wibox.widget {
  {
    {
      widget = wibox.widget.imagebox,
      image = os.getenv("HOME") .. "/.icons/papirus-icon-theme-20230301/Papirus/48x48/apps/gimp.svg",
      resize = false,
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

Item7:connect_signal("button::press", function(_, _, _, button)
  if button == 1 then
    awful.spawn.with_shell("gimp")
  end
end)


Item8 = wibox.widget {
  {
    {
      widget = wibox.widget.imagebox,
      image = os.getenv("HOME") .. "/.icons/papirus-icon-theme-20230301/Papirus/48x48/apps/vokoscreenNG.svg",
      resize = false,
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

Item8:connect_signal("button::press", function(_, _, _, button)
  if button == 1 then
    awful.spawn.with_shell("vokoscreenNG")
  end
end)


Item9 = wibox.widget {
  {
    {
      widget = wibox.widget.imagebox,
      image = os.getenv("HOME") .. "/.icons/papirus-icon-theme-20230301/Papirus/48x48/apps/kdeconnect.svg",
      resize = false,
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

Item9:connect_signal("button::press", function(_, _, _, button)
  if button == 1 then
    awful.spawn.with_shell("kdeconnect")
  end
end)


Item10 = wibox.widget {
  {
    {
      widget = wibox.widget.imagebox,
      image = os.getenv("HOME") .. "/.icons/papirus-icon-theme-20230301/Papirus/48x48/apps/keepassxc.svg",
      resize = false,
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

Item10:connect_signal("button::press", function(_, _, _, button)
  if button == 1 then
    awful.spawn.with_shell("keepassxc")
  end
end)

Sep = wibox.widget {
  widget = wibox.widget.imagebox,
  image = os.getenv("HOME") .. "/.icons/papirus-icon-theme-20230301/Papirus/vertical-line-icon-21.png",
  resize = false,
  opacity = 1,
}

----------------------------------
--Layout Switcher
----------------------------------
mylayoutbox = awful.widget.layoutbox()
mylayoutbox:buttons(gears.table.join(
  awful.button({}, 1, function()
    awful.layout.inc(1)
  end),
  awful.button({}, 3, function()
    awful.layout.inc(-1)
  end),
  awful.button({}, 4, function()
    awful.layout.inc(1)
  end),
  awful.button({}, 5, function()
    awful.layout.inc(-1)
  end)
))

mylayoutbox.forced_height = 45

local layoutbox = wibox.widget {
  {
    mylayoutbox,
    left   = 5,
    right  = 5,
    top    = 5,
    bottom = 5,
    widget = wibox.container.margin

  },
  bg = bg_color,
  shape = gears.shape.rounded_rect,
  widget = wibox.container.background,
  forced_height = 53,
  forced_width = 53,

}

-----------------------------------
--Main Dock Wibox
-----------------------------------
local dock = awful.popup {
  screen = s,
  widget = wibox.container.background,
  ontop = true,
  bg = "#111111aa",
  visible = true,
  -- maximum_width = 200,
  maximum_height = 67,
  -- maximum_width = 900,
  placement = function(c)
    awful.placement.bottom(c,
      { margins = { top = 8, bottom = 5, left = 8, right = 90 } })
  end,
  shape = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 5)
  end,
  opacity = 0.9
}

dock:struts {
  bottom = 69
}

dock:setup({
  Separator,
  {
    button1,
    layout = wibox.container.place
  },
  Separator,
  {
    Item1,
    layout = wibox.container.place
  },
  Separator,
  {
    Item2,
    layout = wibox.container.place
  },
  Separator,
  {
    Item3,
    layout = wibox.container.place
  },
  Separator,
  {
    Item4,
    layout = wibox.container.place
  },
  Separator,
  {
    Item5,
    layout = wibox.container.place
  },
  Separator,
  {
    Item6,
    layout = wibox.container.place
  },
  Separator,
  {
    Item7,
    layout = wibox.container.place
  },
  Separator,
  {
    Item8,
    layout = wibox.container.place
  },
  Separator,
  {
    Item9,
    layout = wibox.container.place
  },
  Separator,
  {
    Item10,
    layout = wibox.container.place
  },

  Separator,
  {
    layoutbox,
    layout = wibox.container.place,
  },
  Separator,
  layout = wibox.layout.fixed.horizontal,

})

----------------------------------------------
--Mouse hover and onclick effect
----------------------------------------------
--Item 1
Item1:connect_signal("mouse::enter", function()
  Item1.bg = hover_color
end)

Item1:connect_signal("mouse::leave", function()
  Item1.bg = bg_color
end)

Item1:connect_signal("button::press", function()
  Item1.bg = onclick_color
end)

Item1:connect_signal("button::release", function()
  Item1.bg = hover_color
end)


--Item 2
Item2:connect_signal("mouse::enter", function()
  Item2.bg = hover_color
end)

Item2:connect_signal("mouse::leave", function()
  Item2.bg = bg_color
end)

Item2:connect_signal("button::press", function()
  Item2.bg = onclick_color
end)

Item2:connect_signal("button::release", function()
  Item2.bg = hover_color
end)


--Item 3
Item3:connect_signal("mouse::enter", function()
  Item3.bg = hover_color
end)

Item3:connect_signal("mouse::leave", function()
  Item3.bg = bg_color
end)

Item3:connect_signal("button::press", function()
  Item3.bg = onclick_color
end)

Item3:connect_signal("button::release", function()
  Item3.bg = hover_color
end)


--Item 4
Item4:connect_signal("mouse::enter", function()
  Item4.bg = hover_color
end)

Item4:connect_signal("mouse::leave", function()
  Item4.bg = bg_color
end)

Item4:connect_signal("button::press", function()
  Item4.bg = onclick_color
end)

Item4:connect_signal("button::release", function()
  Item4.bg = hover_color
end)




--Item 5
Item5:connect_signal("mouse::enter", function()
  Item5.bg = hover_color
end)

Item5:connect_signal("mouse::leave", function()
  Item5.bg = bg_color
end)

Item5:connect_signal("button::press", function()
  Item5.bg = onclick_color
end)

Item5:connect_signal("button::release", function()
  Item5.bg = hover_color
end)




--Item 6
Item6:connect_signal("mouse::enter", function()
  Item6.bg = hover_color
end)

Item6:connect_signal("mouse::leave", function()
  Item6.bg = bg_color
end)

Item6:connect_signal("button::press", function()
  Item6.bg = onclick_color
end)

Item6:connect_signal("button::release", function()
  Item6.bg = hover_color
end)




--Item 7
Item7:connect_signal("mouse::enter", function()
  Item7.bg = hover_color
end)

Item7:connect_signal("mouse::leave", function()
  Item7.bg = bg_color
end)

Item7:connect_signal("button::press", function()
  Item7.bg = onclick_color
end)

Item7:connect_signal("button::release", function()
  Item7.bg = hover_color
end)




--Item 8
Item8:connect_signal("mouse::enter", function()
  Item8.bg = hover_color
end)

Item8:connect_signal("mouse::leave", function()
  Item8.bg = bg_color
end)

Item8:connect_signal("button::press", function()
  Item8.bg = onclick_color
end)

Item8:connect_signal("button::release", function()
  Item8.bg = hover_color
end)


--Item 9
Item9:connect_signal("mouse::enter", function()
  Item9.bg = hover_color
end)

Item9:connect_signal("mouse::leave", function()
  Item9.bg = bg_color
end)

Item9:connect_signal("button::press", function()
  Item9.bg = onclick_color
end)

Item9:connect_signal("button::release", function()
  Item9.bg = hover_color
end)




--Item 10
Item10:connect_signal("mouse::enter", function()
  Item10.bg = hover_color
end)

Item10:connect_signal("mouse::leave", function()
  Item10.bg = bg_color
end)

Item10:connect_signal("button::press", function()
  Item10.bg = onclick_color
end)

Item10:connect_signal("button::release", function()
  Item10.bg = hover_color
end)




--Item button1
button1:connect_signal("mouse::enter", function()
  button1.bg = hover_color
end)

button1:connect_signal("mouse::leave", function()
  button1.bg = bg_color
end)

button1:connect_signal("button1::press", function()
  button1.bg = onclick_color
end)

button1:connect_signal("button1::release", function()
  button1.bg = hover_color
end)
