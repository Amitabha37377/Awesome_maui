local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local naughty = require("naughty")


--Separator
local Separator = wibox.widget.textbox("     ")
local Separator_small = wibox.widget.textbox("     ")
Separator.forced_height = 120
Separator.forced_width = 20
Separator_small.forced_height = 33

--Screenshot
Screenshot = wibox.widget {
  widget = wibox.widget.imagebox,
  image = os.getenv("HOME") .. "/.icons/papirus-icon-theme-20230301/Papirus/ss2.png",
  resize = true,
  opacity = 1,
}
Screenshot:connect_signal("button::press", function(_, _, _, button)
  if button == 1 then
    awful.spawn.with_shell(
      'scrot /tmp/screenshot.png && convert /tmp/screenshot.png -resize 20% /tmp/resized_screenshot.png && dunstify -i /tmp/resized_screenshot.png " " && cp /tmp/screenshot.png ~/Pictures/file1_`date +"%Y%m%d_%H%M%S"`.png && rm /tmp/resized_screenshot.png && rm /tmp/screenshot.png'
    )
  end
end)

--Control applet button
Button = wibox.widget {
  widget = wibox.widget.imagebox,
  image = os.getenv("HOME") .. "/.icons/papirus-icon-theme-20230301/Papirus/user.png",
  resize = false,
  opacity = 1,
}

--Systray

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


--Wibox
local right_fourth = awful.popup {
  screen = s,
  widget = wibox.container.background,
  ontop = true,
  bg = "#111111",
  visible = true,
  -- maximum_width = 200,
  maximum_height = 33,
  maximum_width = 300,
  placement = function(c)
    awful.placement.top_right(c,
      { margins = { top = 8, bottom = 8, left = 8, right = 296 } })
  end,

  shape = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 5)
  end,
  opacity = 0.9
}

right_fourth:setup({
  -- Separator,

  my_round_systray,
  -- Separator,
  {
    Screenshot,
    layout = wibox.container.place
  },
  Separator,
  {
    Button,
    layout = wibox.container.place
  },

  Separator,
  layout = wibox.layout.fixed.horizontal,
  height = 40
})

local popup2 = require("deco.widgets.control_center")

-- local control_panel = awful.popup {
--   screen = s,
--   widget = wibox.container.background,
--   ontop = true,
--   bg = "#111111",
--   visible = false,
--   placement = function(c) awful.placement.top_right(c, { margins = { top = 58, right = 8 } }) end,
--   shape = function(cr, width, height)
--     gears.shape.rounded_rect(cr, width, height, 5)
--   end,
--   opacity = 0.9
-- }
--
-- control_panel:setup({
--   -- brightness_container,
--   wifi,
--   -- volume_container,
--   layout = wibox.layout.fixed.vertical
-- })

-- Define button callback function
right_fourth:connect_signal("button::release", function()
  popup2.visible = not popup2.visible
end)
