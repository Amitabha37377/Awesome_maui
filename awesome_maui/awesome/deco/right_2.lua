--Awesome modules
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local bling = require("bling")

-- local deco = {
--   wallpaper = require("deco.wallpaper"),
-- }

--Separator
local Separator_small = wibox.widget.textbox("  ")
local Separator = wibox.widget.textbox("   ")
local Sep_Music = wibox.widget.textbox("        ")
local button_sep = wibox.widget.textbox("        ")
local button_sep2 = wibox.widget.textbox("        ")

Separator.forced_height = 33
button_sep.forced_width = 100
button_sep2.forced_width = 18
button_sep2.forced_height = 10


local _M = {}

local right_second = awful.popup {
  screen = s,
  widget = wibox.container.background,
  ontop = true,
  bg = "#111111",
  visible = true,
  maximum_width = 200,
  placement = function(c)
    awful.placement.top_right(c,
      { margins = { top = 8, bottom = 8, left = 8, right = 90 } })
  end,
  shape = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 5)
  end,
  opacity = 0.9
}

right_second:setup({
  Separator,
  {
    {
      id = "play",
      widget = wibox.widget.imagebox,
      image = os.getenv("HOME") .. "/.icons/papirus-icon-theme-20230301/Papirus/headphone.png",
      resize = false,
      opacity = 1,
    },
    layout = wibox.container.place
  },


  Separator_small,
  {
    {
      id = "play2",
      widget = wibox.widget.imagebox,
      image = os.getenv("HOME") .. "/.icons/papirus-icon-theme-20230301/Papirus/play.png",
      resize = false,
      opacity = 1,
    },
    layout = wibox.container.place
  },

  Separator,
  layout = wibox.layout.fixed.horizontal,
})

-- local music_widget = require("deco.widgets.musicplayer")

--Music Player Widget
local art = wibox.widget {
  image = os.getenv("HOME") .. "/.icons/papirus-icon-theme-20230301/Papirus/128x128/apps/mp3splt-gtk.svg",

  resize = true,
  forced_height = 80,
  forced_width = 120,
  widget = wibox.widget.imagebox,
  valign = center,
}

local name_widget = wibox.widget {
  markup = 'No players',
  align = 'center',
  valign = 'center',
  widget = wibox.widget.textbox,
  font = "CaskaydiaCove Nerd Font 14",
  forced_width = 200,
}

local title_widget = wibox.widget {
  markup = 'Nothing Playing',
  align = 'center',
  valign = 'center',
  widget = wibox.widget.textbox,
  font = "CaskaydiaCove Nerd Font 14",
  forced_width = 241,
  forced_height = 40,
}

local artist_widget = wibox.widget {
  markup = 'Unknown artist',
  align = 'center',
  valign = 'center',
  widget = wibox.widget.textbox,
  font = "CaskaydiaCove Nerd Font 14",
  forced_width = 241,
  forced_height = 35,
}

-- Get Song Info
local playerctl = bling.signal.playerctl.lib()
playerctl:connect_signal("metadata",
  function(_, title, artist, album_path, album, new, player_name)
    -- Set art widget
    art:set_image(gears.surface.load_uncached(album_path))

    -- Set player name, title and artist widgets
    name_widget:set_markup_silently(player_name)
    title_widget:set_markup_silently(title)
    artist_widget:set_markup_silently(artist)
  end)


-----------------
--Buttons-------
-----------------
local bg_color = "#11111180"

Pause = wibox.widget {
  {
    {
      widget = wibox.widget.imagebox,
      image = os.getenv("HOME") .. "/.icons/papirus-icon-theme-20230301/Papirus/musicplayer/play-button.png",
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
  forced_height = 40,
  forced_width = 40,

}
Pause:buttons(gears.table.join(
  awful.button({}, 1, function()
    playerctl:play_pause()
  end)
))


Next = wibox.widget {
  {
    {
      widget = wibox.widget.imagebox,
      image = os.getenv("HOME") .. "/.icons/papirus-icon-theme-20230301/Papirus/musicplayer/next-button.png",
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
  forced_height = 40,
  forced_width = 40,

}
Next:buttons(gears.table.join(
  awful.button({}, 1, function()
    playerctl:next()
  end)
))


Previous = wibox.widget {
  {
    {
      widget = wibox.widget.imagebox,
      image = os.getenv("HOME") .. "/.icons/papirus-icon-theme-20230301/Papirus/musicplayer/previous.png",
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
  forced_height = 40,
  forced_width = 40,

}
Previous:buttons(gears.table.join(
  awful.button({}, 1, function()
    playerctl:previous()
  end)
))


Loop = wibox.widget {
  {
    {
      widget = wibox.widget.imagebox,
      image = os.getenv("HOME") .. "/.icons/papirus-icon-theme-20230301/Papirus/musicplayer/loop-arrow.png",
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
  forced_height = 40,
  forced_width = 40,

}
Loop:buttons(gears.table.join(
  awful.button({}, 1, function()
    -- playerctl:loop()
  end)
))







local music_player = awful.popup {
  screen = s,
  widget = wibox.container.background,
  ontop = true,
  bg = "#111111",
  visible = false,
  placement = function(c) awful.placement.top_right(c, { margins = { top = 248, right = 8 } }) end,
  shape = function(cr, width, height)
    gears.shape.rounded_rect(cr, width, height, 5)
  end,
  opacity = 0.9
}

music_player:setup({
  button_sep2,
  {
    Separator,
    {
      {
        art,
        layout = wibox.container.place
      },
      widget = wibox.container.margin,
      margins = 10,
    },
    Separator,
    {
      {
        title_widget,
        artist_widget,
        layout = wibox.layout.fixed.vertical
      },
      widget = wibox.container.margin,
      margins = 6,
    },
    Separator,
    layout = wibox.layout.fixed.horizontal,
  },
  -- button_sep2,
  {
    button_sep2,
    button_sep2,
    button_sep2,
    button_sep2,
    button_sep2,
    Previous,
    button_sep2,
    Pause,
    button_sep2,
    Next,
    button_sep2,
    button_sep2,
    Loop,
    layout = wibox.layout.fixed.horizontal
  },
  button_sep2,
  button_sep2,
  layout = wibox.layout.fixed.vertical
})

-- Define button callback function
right_second:connect_signal("button::release", function()
  music_player.visible = not music_player.visible
end)
