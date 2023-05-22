local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local Separator = wibox.widget.textbox("     ")

------------------------
--Buttons
------------------------

local bg_color = "#222222"
local font = "CaskaydiaCove Nerd Font 14"

local wifi_button = wibox.widget({
  {
    {
      {
        widget = wibox.widget.imagebox,
        image = os.getenv("HOME") .. "/.icons/papirus-icon-theme-20230301/Papirus/wifi-icon-3782.png",
        resize = true,
        forced_height = 40,
        forced_width = 180,
      },
      {
        text = " WiFi",
        font = font,
        align = "center",
        valign = "center",
        widget = wibox.widget.textbox,
      },
      layout = wibox.layout.fixed.horizontal,
    },
    widget = wibox.container.margin,
    margins = 5,
  },
  bg = bg_color,
  shape = gears.shape.rounded_rect,
  widget = wibox.container.background,
})

return wifi_button
