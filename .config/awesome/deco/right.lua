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
require("deco.right_5")
