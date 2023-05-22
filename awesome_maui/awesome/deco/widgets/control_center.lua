local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local Separator = wibox.widget.textbox("     ")

-- Define button widget
local button_control = awful.widget.button({
  image = os.getenv("HOME") .. "/.icons/papirus-icon-theme-20230301/Papirus/applications-system.png",
  widget = wibox.widget.imagebox,
})




local volume_slider = wibox.widget({
  widget = wibox.widget.slider,
  bar_shape = gears.shape.rounded_rect,
  bar_height = 10,
  bar_color = "#b7b2f1",
  handle_shape = gears.shape.circle,
  handle_color = "#ffffff",
  handle_width = 30,
  handle_border_width = 1,
  handle_border_color = "#aaaaaa",
  minimum = 0,
  maximum = 100,
  value = 50,
})

-- Define a timer to update the volume slider value every second
local update_volume_slider = function()
  awful.spawn.easy_async("amixer sget Master", function(stdout)
    local volume = tonumber(string.match(stdout, "(%d?%d?%d)%%"))
    volume_slider.value = volume
  end)
end

local volume_slider_timer = gears.timer({
  timeout = 1,
  call_now = true,
  autostart = true,
  callback = update_volume_slider,
})

local brightness_slider = wibox.widget({
  widget = wibox.widget.slider,
  bar_shape = gears.shape.rounded_rect,
  bar_height = 10,
  bar_color = "#b7b2f1",
  handle_shape = gears.shape.circle,
  handle_color = "#ffffff",
  handle_width = 30,
  handle_border_width = 1,
  handle_border_color = "#aaaaaa",
  minimum = 5,
  maximum = 100,
  value = tonumber(io.popen("light -G"):read("*all")),
})

local user_widget = wibox.widget({
  {
    image = os.getenv("HOME") .. "/.icons/papirus-icon-theme-20230301/Papirus/iconUser.png",
    widget = wibox.widget.imagebox,
  },
  {
    text = " Amitabha       ",
    font = "CaskaydiaCove Nerd Font 17",
    widget = wibox.widget.textbox,
    bg = "#000022",
  },
  nil,
  layout = wibox.layout.fixed.horizontal,
})

-- Define colors for on and off states
local on_color = "#5294E2"
local off_color = "#FFFFFF30"

-- Define font settings for text
local font = "CaskaydiaCove Nerd Font 13"
local text_color = "#000000"

-- WiFi button widget

local wifi_text = wibox.widget.textbox()

local wifi_script = [[
  sh -c "nmcli -t -f active,ssid dev wifi | egrep '^yes:' | cut -d\' -f2 | awk -F: '$1=="yes"{print substr($0,5)}'"
]]

awful.widget.watch(wifi_script, 5, function(widget, stdout)
  local wifi_name = stdout:gsub("^%s*(.-)%s*$", "%1")
  if wifi_name ~= "" then
    wifi_text:set_text("Wifi (Off)")
  else
    wifi_text:set_text("" .. tostring(wifi_name) .. "")
  end
end)

local wifi_button = wibox.widget({
  {
    {
      {
        widget = wibox.widget.imagebox,
        image = os.getenv("HOME") .. "/.icons/papirus-icon-theme-20230301/Papirus/wifi-icon-3782.png",
        resize = true,
        -- forced_height = 20,
        -- forced_width = 20,
      },
      {
        text = " WiFi",
        font = font,
        align = "center",
        valign = "center",
        widget = wibox.widget.textbox,
      },
      wifi_text,
      layout = wibox.layout.fixed.horizontal,
    },
    widget = wibox.container.margin,
    margins = 5,
  },
  bg = off_color,
  shape = gears.shape.rounded_rect,
  widget = wibox.container.background,
})

-- Bluetooth button widget
local bluetooth_button = wibox.widget({
  {
    {
      {
        widget = wibox.widget.imagebox,
        image = os.getenv("HOME") .. "/.icons/papirus-icon-theme-20230301/Papirus/64x64/apps/blueradio.svg",
        resize = true,
        -- forced_height = 20,
        -- forced_width = 20,
      },
      {
        text = "Bluetooth",
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
  bg = off_color,
  shape = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 10)
  end,
  widget = wibox.container.background,
})

-- Toggle WiFi on/off
wifi_button:connect_signal("button::press", function()
  wifi_on = not wifi_on
  if wifi_on then
    wifi_button:set_bg("#5294E2")
    wifi_button.children[1].image = "/path/to/wifi-on.png"
    os.execute("nmcli radio wifi on")
  else
    wifi_button:set_bg("#ffffff30")
    wifi_button.children[1].image = "/path/to/wifi-off.png"
    os.execute("nmcli radio wifi off")
  end
end)

-- Toggle Bluetooth on/off

bluetooth_button:connect_signal("button::press", function()
  bluetooth_on = not bluetooth_on
  if bluetooth_on then
    bluetooth_button:set_bg("#5294E2")
    bluetooth_button.children[1].image = "/path/to/bluetooth-on.png"
  else
    bluetooth_button:set_bg("#ffffff30")
    bluetooth_button.children[1].image = "/path/to/bluetooth-off.png"
  end
end)

-- ScreenShot button widget
local Screenshot_button = wibox.widget({
  {
    {
      {
        widget = wibox.widget.imagebox,
        image = os.getenv("HOME") .. "/.icons/papirus-icon-theme-20230301/Papirus/64x64/devices/camera.svg",
        resize = true,
        -- forced_height = 20,
        -- forced_width = 20,
      },
      {
        text = " ScreenShot",
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
  bg = off_color,
  shape = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 10)
  end,
  widget = wibox.container.background,
})

Screenshot_button:connect_signal("button::press", function()
  awful.spawn("spectacle")
end)

local battery_text = wibox.widget.textbox()

local battery_script = [[
  sh -c "acpi | cut -d' ' -f4 | tr -d ','"
]]

-- Battery widget
local Appearance = wibox.widget({
  {
    {
      {
        widget = wibox.widget.imagebox,
        image = os.getenv("HOME") .. "/.icons/papirus-icon-theme-20230301/Papirus/64x64/apps/lximage.svg",
        resize = true,
        -- forced_height = 20,
        -- forced_width = 20,
      },
      {
        text = " Change Theme",
        font = font,
        align = "center",
        valign = "center",
        widget = wibox.widget.textbox,
      },
      -- battery_text,
      layout = wibox.layout.fixed.horizontal,
    },
    widget = wibox.container.margin,
    margins = 5,
  },
  bg = off_color,
  shape = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 10)
  end,
  widget = wibox.container.background,
})

Appearance:connect_signal("button::press", function()
  awful.spawn("lxappearance")
end)

-- Set the font of the battery text widget

local popup2 = awful.popup({
  widget = {
    {
      -- {
      -- 	{
      -- 		{
      -- 			user_widget,
      -- 			widget = wibox.container.background,
      -- 			shape = gears.shape.rounded_rect,
      -- 			forced_width = 340,
      -- 			forced_height = 70,
      -- 			bg = "#729fcf",
      -- 			fg = "#000000",
      -- 		},
      -- 		widget = wibox.container.margin,
      -- 		margins = 8,
      -- 		forced_width = 340,
      -- 		forced_height = 70,
      -- 	},
      -- 	{
      -- 		{
      -- 			logout_menu_widget({
      -- 				font = "JetBrainsMono Nerd Font 13",
      -- 				onlock = function()
      -- 					awful.spawn.with_shell("i3lock-fancy")
      -- 				end,
      -- 			}),
      -- 			widget = wibox.container.background,
      -- 			shape = gears.shape.rounded_rect,
      -- 			forced_width = 60,
      -- 			forced_height = 70,
      -- 			bg = "#729fcf",
      -- 			fg = "#000000",
      -- 		},
      -- 		widget = wibox.container.margin,
      -- 		margins = 8,
      -- 		forced_width = 60,
      -- 		forced_height = 70,
      -- 	},
      -- 	layout = wibox.layout.fixed.horizontal,
      -- 	forced_width = 400,
      -- 	forced_height = 70,
      -- },
      -- {
      -- 	{
      -- 		id = "screenshot",
      -- 		widget = wibox.widget.imagebox,
      -- 		image = os.getenv("HOME")
      -- 				.. "/.icons/papirus-icon-theme-20230301/Papirus/64x64/devices/audio-headset.svg",
      -- 		resize = true,
      -- 		opacity = 0,
      -- 	},
      -- 	forced_height = 20,
      -- 	forced_width = 400,
      -- 	layout = wibox.layout.fixed.horizontal,
      -- },
      -- {
      -- 	{
      -- 		widget = wibox.widget.imagebox,
      -- 		image = os.getenv("HOME") .. "/.icons/papirus-icon-theme-20230301/Papirus/audio2.png",
      -- 		resize = true,
      -- 		opacity = 1,
      -- 	},
      -- 	{
      -- 		volume_slider,
      -- 		widget = wibox.container.margin,
      -- 		margins = 10,
      -- 		forced_width = 350,
      -- 		forced_height = 60,
      -- 	},
      -- 	layout = wibox.layout.fixed.horizontal,
      -- 	forced_width = 400,
      -- 	forced_height = 60,
      -- },
      -- {
      -- 	{
      -- 		id = "screenshot",
      -- 		widget = wibox.widget.imagebox,
      -- 		image = os.getenv("HOME")
      -- 				.. "/.icons/papirus-icon-theme-20230301/Papirus/64x64/devices/audio-headset.svg",
      -- 		resize = true,
      -- 		opacity = 0,
      -- 	},
      -- 	forced_height = 20,
      -- 	forced_width = 400,
      -- 	layout = wibox.layout.fixed.horizontal,
      -- },
      -- {
      -- 	{
      -- 		id = "brightness",
      -- 		widget = wibox.widget.imagebox,
      -- 		image = os.getenv("HOME") .. "/.icons/papirus-icon-theme-20230301/Papirus/brightness2.png",
      -- 		resize = true,
      -- 		opacity = 1,
      -- 	},
      -- 	{
      -- 		brightness_slider,
      -- 		widget = wibox.container.margin,
      -- 		margins = 10,
      -- 		forced_width = 350,
      -- 		forced_height = 60,
      -- 	},
      -- 	layout = wibox.layout.fixed.horizontal,
      -- 	forced_width = 400,
      -- 	forced_height = 60,
      -- },
      -- {
      -- 	{
      -- 		id = "screenshot",
      -- 		widget = wibox.widget.imagebox,
      -- 		image = os.getenv("HOME")
      -- 				.. "/.icons/papirus-icon-theme-20230301/Papirus/64x64/devices/audio-headset.svg",
      -- 		resize = true,
      -- 		opacity = 0,
      -- 	},
      -- 	forced_height = 20,
      -- 	forced_width = 400,
      -- 	layout = wibox.layout.fixed.horizontal,
      -- },
      {
        {
          {
            wifi_button,
            widget = wibox.container.background,
            shape = gears.shape.rounded_rect,
            forced_width = 180,
            forced_height = 70,
            bg = "#222222",
            fg = "#000000",
          },
          widget = wibox.container.margin,
          margins = 8,
          forced_width = 200,
          forced_height = 70,
        },
        {
          {
            bluetooth_button,
            widget = wibox.container.background,
            shape = gears.shape.rounded_rect,
            forced_width = 180,
            forced_height = 70,
            bg = "#222222",
            fg = "#000000",
          },
          widget = wibox.container.margin,
          margins = 8,
          forced_width = 200,
          forced_height = 70,
        },
        layout = wibox.layout.fixed.horizontal,
        forced_width = 380,
        forced_height = 70,
      },
      {
        {
          {
            Appearance,
            widget = wibox.container.background,
            shape = gears.shape.rounded_rect,
            forced_width = 180,
            forced_height = 70,
            bg = "#222222",
            fg = "#000000",
          },
          widget = wibox.container.margin,
          margins = 8,
          forced_width = 200,
          forced_height = 70,
        },
        {
          {
            Screenshot_button,
            widget = wibox.container.background,
            shape = gears.shape.rounded_rect,
            forced_width = 180,
            forced_height = 70,
            bg = "#222222",
            fg = "#000000",
          },
          widget = wibox.container.margin,
          margins = 8,
          forced_width = 200,
          forced_height = 70,
        },
        layout = wibox.layout.fixed.horizontal,
        forced_width = 400,
        forced_height = 70,
      },
      layout = wibox.layout.fixed.vertical,
    },
    margins = 10,
    widget = wibox.container.margin,
  },
  bg = "#111111cc",
  border_color = "#00000099",
  border_width = 0,
  ontop = true,
  placement = function(c)
    local screen_geometry = awful.screen.focused().geometry
    return awful.placement.top_right(c, { margins = { right = 10, top = 58 } })
  end,
  shape = gears.shape.rounded_rect,
  visible = false,
  forced_width = 400,
  forced_height = 200,
})

-- Add signal to set the brightness using light
brightness_slider:connect_signal("property::value", function(slider)
  local brightness_level = math.floor(slider.value / 100 * 100)
  awful.spawn.easy_async("light -S " .. brightness_level, function()
  end)
end)

-- Add signal to set the Volume using amixer
volume_slider:connect_signal("property::value", function(slider)
  local volume_level = math.floor(slider.value / 100 * 65537)
  awful.spawn.easy_async("amixer set Master" .. volume_level, function()
  end)
end)

-- -- Define button callback function
-- button_control:connect_signal("button::release", function()
-- 	popup2.visible = not popup2.visible
-- end)

return popup2
