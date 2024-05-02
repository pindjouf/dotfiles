# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

from libqtile import bar, layout, qtile, widget
from libqtile.config import Click, Drag, Group, Key, Match, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal
#from qtile_extras import widget as extraWidgets
#from qtile_extras.widget.decorations import RectDecoration
#from qtile_extras.popup.templates.mpris2 import COMPACT_LAYOUT, DEFAULT_LAYOUT
#from qtile_extras.popup.toolkit import (
#    PopupRelativeLayout,
#    PopupImage,
#    PopupText
#)
import subprocess, re # dealing with os & regex for parsing info from os
import os
import socket

if qtile.core.name == "x11":
    term = "urxvt"
elif qtile.core.name == "wayland":
    term = "foot"

mod = "mod4"
terminal = guess_terminal()

keys = [
    # A list of available commands that can be bound to keys can be found
    # at https://docs.qtile.org/en/latest/manual/config/lazy.html
    # Switch between windows
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    # Move windows between left/right columns or move up/down in current stack.
    # Moving out of range in Columns layout will create new column.
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    # Grow windows. If current window is on the edge of screen and direction
    # will be to screen edge - window would shrink.
    Key([mod, "control"], "left", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "right", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "down", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "up", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key(
        [mod, "shift"],
        "Return",
        lazy.layout.toggle_split(),
        desc="Toggle between split and unsplit sides of stack",
    ),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "w", lazy.window.kill(), desc="Kill focused window"),
    Key([mod],"f", lazy.window.toggle_fullscreen(),desc="Toggle fullscreen on the focused window",),
    Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle floating on the focused window"),
    Key([mod, "control"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    Key([mod], "p", lazy.spawn("firefox"), desc="Spawn your browser"),
    Key([mod], "o", lazy.spawn("obsidian"), desc="Spawn obsidian"),
    Key([mod], "i", lazy.spawn("vscodium"), desc="Spawn vscodium"),
    Key([mod], "u", lazy.spawn("rofi -show drun"), desc="Spawn your app browser"),
    Key([mod], "d", lazy.spawn("discord"), desc="Spawn discord"),
    Key([mod], "g", lazy.spawn("grim"), desc="Spawn discord"),
    Key([mod], "s", lazy.spawn("swaylock \
	--screenshots \
	--clock \
	--indicator \
	--indicator-radius 100 \
	--indicator-thickness 7 \
	--effect-blur 7x5 \
	--effect-vignette 0.5:0.5 \
	--ring-color d79921 \
	--key-hl-color 458588 \
	--line-color 00000000 \
	--inside-color 00000088 \
	--separator-color 00000000 \
	--grace 2 \
	--fade-in 0.2"), desc="Lock your screen"),
    Key([], "XF86AudioLowerVolume", lazy.spawn("amixer sset Master 5%-"), desc="Lower Volume by 5%"),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("amixer sset Master 5%+"), desc="Raise Volume by 5%"),
    Key([], "XF86AudioMute", lazy.spawn("amixer sset Master 1+ toggle"), desc="Mute/Unmute Volume"),
    Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl set +10%")),
    Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl set 10%-")),
    Key([mod], "XF86MonBrightnessUp", lazy.spawn("brightnessctl set +1%")),
    Key([mod], "XF86MonBrightnessDown", lazy.spawn("brightnessctl set 1%-")),
    Key([], "XF86KbdBrightnessUp", lazy.spawn("brightnessctl --device='smc::kbd_backlight' set +10")),
    Key([], "XF86KbdBrightnessDown", lazy.spawn("brightnessctl --device='smc::kbd_backlight' set 10-")),
    # and the play/pause keys to playerctl like this:
    # Key([], "XF86AudioPlay", lazy.spawn("playerctl play-pause"), desc="Play/Pause player"),
    # Key([], "XF86AudioNext", lazy.spawn("playerctl next"), desc="Skip to next"),
    # Key([], "XF86AudioPrev", lazy.spawn("playerctl previous"), desc="Skip to previous"), 
]

# Add key bindings to switch VTs in Wayland.
# We can't check qtile.core.name in default config as it is loaded before qtile is started
# We therefore defer the check until the key binding is run by using .when(func=...)
for vt in range(1, 8):
    keys.append(
        Key(
            ["control", "mod1"],
            f"f{vt}",
            lazy.core.change_vt(vt).when(func=lambda: qtile.core.name == "wayland"),
            desc=f"Switch to VT{vt}",
        )
    )

groups = []

# CREATE A LIST CONTAINING GROUP NAMES
group_names = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
]

# CREATE A LIST CONTAINING GROUP LABELS
group_labels = [
    "●",
    "●",
    "●",
    "●",
    "●",
    "●",
    "●",
]

# CREATE A LIST DEFINING LAYOUTS FOR EACH GROUP
group_layouts = [
    "monadtall",
    "monadtall",
    "monadtall",
    "monadtall",
    "monadtall",
    "monadtall",
    "monadtall",
]

# CREATE A DGROUP OBJECT FOR EACH GROUP
for i in range(len(group_names)):
    groups.append(
        Group(
            name=group_names[i],
            layout=group_layouts[i].lower(),
            label=group_labels[i],
        )
    )

# ADDITIONAL KEYBINDINGS FOR NAVIGATION WITHIN GROUPS
for i in groups:
    keys.extend(
        [
            # CHANGE WORKSPACES - MOVE TO GROUP
            Key([mod], i.name, lazy.group[i.name].toscreen()),
            # MOVE TO NEXT GROUP
            Key([mod], "Tab", lazy.screen.next_group()),
            Key(["mod1", "shift"], "Tab", lazy.screen.prev_group()),
            # MOVE TO PREVIOUS GROUP
            Key([mod, "shift"], "Tab", lazy.screen.prev_group()),
            Key(["mod1"], "Tab", lazy.screen.next_group()),
            # MOVE WINDOW TO SELECTED WORKSPACE 1-i AND STAY ON WORKSPACE
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name)),
            # MOVE WINDOW TO SELECTED WORKSPACE 1-i AND FOLLOW
            Key(
                [mod, "shift"],
                i.name,
                lazy.window.togroup(i.name),
                lazy.group[i.name].toscreen(),
            ),
        ]
    )

layout_theme = {
    "border_width": 4,
    "margin": 15,
    "border_focus": "d79921",
    "border_normal": "1e1e1e"
}

layouts = [
    # layout.Columns(**layout_theme),
    # layout.Max(),
    # Try more layouts by unleashing below layouts.
    # layout.Stack(**layout_theme),
    # layout.Bsp(**layout_theme),
    # layout.Matrix(),
    layout.MonadTall(**layout_theme),
    # layout.MonadWide(**layout_theme),
    # layout.RatioTile(**layout_theme),
    # layout.Tile(**layout_theme),
    # layout.TreeTab(**layout_theme),
    # layout.VerticalTile(),
    # layout.Zoomy(**layout_theme),
]

widget_defaults = dict(
    font="Gohufont Bold",
    fontsize=18,
    padding=4,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        wallpaper = '~/.config/wallpaper/street.png',
        top=bar.Bar(
            [
                # widget.Image(filename='/home/pindjouf/.config/icons/archlinux-icon.svg', margin=-1),
                widget.Spacer(length=10),
                widget.GroupBox(highlight_method='text', active='#ebdbb2', this_current_screen_border='#d79921', fontsize=27, padding=2),
                widget.Spacer(length=10),
                widget.Prompt(foreground='#ebdbb2'),
                widget.Spacer(),
                widget.Clock(format="%A, %d %b %R", foreground='#ebdbb2', fontshadow='#1d2021'),
                widget.Spacer(),
                # widget.Chord(
                #    chords_colors={
                #        "launch": ("#ff0000", "#ffffff"),
                #    },
                #    name_transform=lambda name: name.upper(),
                # ),
                widget.Pomodoro(color_active='#b8bb26', color_break='#fabd2f' , color_inactive='#fb4934'),
                widget.Sep(),
                widget.StatusNotifier(icon_size=24),
                widget.Sep(),
                widget.Wttr(location={'Brussels': 'Home'}, format=1, foreground='#ebdbb2'),
                widget.Sep(),
                widget.CryptoTicker(crypto="BTC", symbol='', currency="EUR", format='{symbol}', foreground='#FF9900'),
                widget.CryptoTicker(crypto="BTC", symbol='€', currency="EUR", format='{amount:,.2f}{symbol}', foreground='#ebdbb2', fontshadow='#1d2021'),
                widget.Sep(),
                widget.BatteryIcon(battery=0, theme_path='/usr/share/icons/Paper/'),
                widget.Volume(theme_path='/usr/share/icons/Paper/', padding=3),
                # widget.TextBox(fmt=' ', fontsize=14),
                # widget.TextBox(fmt='', fontsize=18),
                widget.Sep(),
                widget.QuickExit(default_text='⏻', foreground='#ebdbb2'),
            ],
            24,
            background="#00000000",
            margin=8
            # border_width=[2, 0, 2, 0],  # Draw top and bottom borders
            # border_color=["ff00ff", "000000", "ff00ff", "000000"]  # Borders are magenta
        ),
        # You can uncomment this variable if you see that on X11 floating resize/moving is laggy
        # By default we handle these events delayed to already improve performance, however your system might still be struggling
        # This variable is set to None (no cap) by default, but you can set it to 60 to indicate that you limit it to 60 events per second
        x11_drag_polling_rate = None,
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True 
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

from libqtile.backend.wayland import InputConfig
# When using the Wayland backend, this can be used to configure input devices.
wl_input_rules = {
        "type:touchpad": InputConfig(
        tap=True,
        scroll_method='two_finger',
        natural_scroll=False,
        accel_profile='flat',
        pointer_accel=1,
        dwt=True
        )

}

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
