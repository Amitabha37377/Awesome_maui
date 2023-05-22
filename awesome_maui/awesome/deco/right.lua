--Awesome modules
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local _M = {}

--Separator
local Separator_small = wibox.widget.textbox("  ")
local Separator = wibox.widget.textbox("   ")
Separator.forced_height = 33

--All wiboxes of rightside
require("deco.right_1")
require("deco.right_2")
require("deco.right_3")
require("deco.right_4")

-- --All Widgets
-- local brightness_container = require("deco.widgets.brightness")
-- local volume_container = require("deco.widgets.volume")
-- local microphone_container = require("deco.widgets.microphone")
--
-- --Slider menues
-- local sliders = wibox.widget {
--   {
--     brightness_container,
--     widget = wibox.container.margin,
--     shape = gears.shape.rounded_rect,
--     margins = 10,
--   },
--   {
--     volume_container,
--     widget = wibox.container.margin,
--     shape = gears.shape.rounded_rect,
--     margins = 10
--   },
--   {
--     microphone_container,
--     widget = wibox.container.margin,
--     shape = gears.shape.rounded_rect,
--     margins = 10
--   },
--
--   widget = wibox.container.background,
--   bg = "33333380",
--   layout = wibox.layout.fixed.vertical
-- }
--
--
-- local control_slider = awful.popup {
--   screen = s,
--   widget = wibox.container.background,
--   ontop = true,
--   bg = "#111111",
--   visible = true,
--   placement = function(c) awful.placement.top_right(c, { margins = { top = 58, right = 8 } }) end,
--   shape = function(cr, width, height)
--     gears.shape.rounded_rect(cr, width, height, 5)
--   end,
--   opacity = 0.9
-- }
--
-- control_slider:setup({
--   -- brightness_container,
--   sliders,
--   -- volume_container,
--   layout = wibox.layout.fixed.vertical
-- })
--
--
--
--
