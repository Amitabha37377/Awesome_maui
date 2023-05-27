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
local taglist_buttons = deco.taglist()
local tasklist_buttons = deco.tasklist()

local _M = {}

--Separator
local Separator = wibox.widget.textbox("       ")
local Separator_small = wibox.widget.textbox("     ")
Separator.forced_height = 33
Separator_small.forced_height = 33

--Calendar Widget
local calendar_widget = require("deco.widgets.calendar")

------------------------------------------
--All Widgets
------------------------------------------

--textclock widget
mytextclock = wibox.widget.textclock('<span color="#ffffffdd" font="CaskaydiaCove Nerd Font 14"> %b %d, %H:%M </span>',
  10)

--calendar-widget
local cw = calendar_widget({
  theme = "outrun",
  placement = "under_mouse",
  start_sunday = true,
  radius = 8,
  previous_month_button = 1,
  next_month_button = 3,
})
mytextclock:connect_signal("button::press", function(_, _, _, button)
  if button == 1 then
    cw.toggle()
  end
end)

--Tagkist cum tasklist widget
awful.screen.connect_for_each_screen(function(s)
  local fancy_taglist = require("fancy_taglist")
  mytaglist = fancy_taglist.new({
    screen = s,
    taglist = { buttons = taglist_buttons },
    tasklist = { buttons = tasklist_buttons },
    -- taglist_buttons  = mytagbuttons,
    -- tasklist_buttons = tasklist_buttons,
    filter = awful.widget.taglist.filter.all,
  })
end)



local left_tags = awful.popup {
  screen = s,
  widget = wibox.container.background,
  ontop = false,
  bg = "#222222",
  visible = true,
  -- maximum_width = 200,
  placement = function(c) awful.placement.top_left(c, { margins = 8 }) end,
  shape = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 5)
  end,
  opacity = 0.9
}

local top_left = awful.popup {
  screen = s,
  widget = wibox.container.background,
  ontop = false,
  bg = "#111111",
  visible = true,
  maximum_width = 200,
  placement = function(c)
    awful.placement.top_left(c,
      { margins = { top = 8, bottom = 8, right = 8, left = left_tags.width + 15 } })
  end,

  -- placement = function(c)
  --   awful.placement.top(c,
  --     { margins = { top = 8, bottom = 8, --[[ right = 8, left = left_tags.width + 15 ]] } })
  -- end,


  shape = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 5)
  end,
  opacity = 0.9
}

top_left:struts {
  top = 40
}



left_tags:setup({
  mytaglist,
  layout = wibox.layout.fixed.horizontal
})

top_left:setup({
  Separator_small,
  mytextclock,
  Separator_small,
  layout = wibox.layout.fixed.horizontal,
  height = 40
})
