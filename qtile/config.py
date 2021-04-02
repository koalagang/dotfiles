from typing import List  # noqa: F401

import subprocess
from libqtile import bar, layout, widget, hook
from libqtile.config import Click, Drag, Group, Key, Screen, Match
from libqtile.lazy import lazy
#from libqtile.utils import guess_terminal

mod = "mod4"
terminal = "alacritty"

keys = [
    # Switch between windows in current stack pane
    Key([mod], "j", lazy.layout.down(),
        desc="Move focus down in stack pane"),
    Key([mod], "k", lazy.layout.up(),
        desc="Move focus up in stack pane"),
    Key([mod], "h", lazy.layout.left(),
        desc="Move focus left in stack pane"),
    Key([mod], "l", lazy.layout.right(),
        desc="Move focus right in stack pane"),

    # Move windows up or down in current stack
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(),
        desc="Move window down in current stack "),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(),
        desc="Move window up in current stack "),
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(),
        desc="Move window left in current stack "),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(),
        desc="Move window right in current stack "),

    # Manipulate windows
    Key([mod, "control"], "i", lazy.layout.grow()),
    Key([mod, "control"], "o", lazy.layout.shrink()),
    Key([mod, "control"], "n", lazy.layout.normalize()),
    Key([mod, "control"], "m", lazy.layout.maximize()),
    Key([mod, "shift"], "space", lazy.layout.flip()),

    # Toggle between different layouts
    Key([mod], "q", lazy.next_layout(), desc="Toggle previous layouts"),
    Key([mod], "Tab", lazy.prev_layout(), desc="Toggle next layouts"),
    Key([mod], "c", lazy.window.kill(), desc="Kill focused window"),

    Key([mod, "control"], "r", lazy.restart(), desc="Restart qtile"),
    Key([mod, "control"], "q", lazy.shutdown(), desc="Shutdown qtile"),
    Key([mod], "r", lazy.spawncmd(),
        desc="Spawn a command using a prompt widget"),

    Key([mod], "f", lazy.window.toggle_fullscreen()),
    Key([mod], "Return", lazy.spawn(terminal)),

    Key([mod, "control"], "j", lazy.spawn("xdotool mousemove 1910 500")),
    Key([mod, "control"], "k", lazy.spawn("xdotool mousemove 1925 500")),
    Key([mod, "control"], "h", lazy.screen.prev_group()),
    Key([mod, "control"], "l", lazy.screen.next_group()),
]

def init_group_names():
    return[ ("(1) MISC1",{'layout': 'bsp'}),
            ("(2) MISC2",{'layout': 'monadwide'}),
            ("(3) WEB",{'layout': 'monadtall'}),
            ("(4) MUSIC",{'layout': 'monadtall'}),
            ("(5) CHAT",{'layout': 'ratiotile'}),
            ("(6) GAME",{'layout': 'floating'}),
            ("(7) WATCH",{'layout': 'verticaltile'}),
            ("(8) SCHL1",{'layout': 'monadtall'}),
            ("(9) SCHL2",{'layout': 'monadtall'})]

def init_groups():
    return [Group(name, **kwargs) for name, kwargs in group_names]

if __name__ in ["config", "__main__"]:
    group_names = init_group_names()
    groups = init_groups()

for i, (name, kwargs) in enumerate(group_names, 1):
    keys.append(Key([mod], str(i), lazy.group[name].toscreen()))        # Switch to another group
    keys.append(Key([mod, "shift"], str(i), lazy.window.togroup(name))) # Send current window to another group

colours = [["#3B4252", "#3B4252"],# panel background
          ["#4B4252", "#4B4252"], # background for current screen tab
          ["#E5E9F0", "#E5E9F0"], # font color for group names
          ["#BF616A", "#BF616A"], # border line color for current tab
          ["#A7B3C9", "#A7B3C9"], # border line color for other tab and odd widgets
          ["#B48EAD", "#B48EAD"], # color for the even widgets
          ["#EB49CF", "#EB49CF"]] # window name

layout_theme = {"border_width": 2,
                "margin": 4,
                "border_focus": "EB49CF",
                "border_normal": "B48EAD"
                }

layouts = [
    #layout.Max(**layout_theme),
    layout.Bsp(**layout_theme),
    layout.MonadTall(**layout_theme),
    layout.MonadWide(**layout_theme),
    layout.VerticalTile(**layout_theme),
    layout.Floating(**layout_theme),
]

widget_defaults = dict(
    font='sans',
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()

screens = [
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(
                font = "Ubuntu Bold",
                fontsize = 12,
                padding_y = 5,
                padding_x = 5,
                active = colours[2],
                inactive = colours [2],
                highlight_method = "block",
                this_current_screen_border = colours[5],
                this_screen_border = colours[4],
                foreground = colours[2],
                background = colours[0],
                    ),
                widget.Prompt(
                font = "Ubuntu",
                fontsize = 12,
                foreground = colours[2],
                background = colours[5]
                    ),
                widget.WindowName(
                font = "Ubuntu",
                fontsize = 12,
                foreground = colours[5],
                background = colours[0],
                    ),
                widget.KeyboardLayout(
                font = "Ubuntu",
                fontsize = 12,
                foreground = colours[2],
                background = colours[0],
                configured_keyboards = ['us','uk'],
                    ),
                widget.TextBox(
                text=' ◀',
                foreground = colours[5],
                background = colours[0],
                padding = -4,
                fontsize = 32,
                    ),
                widget.CurrentLayoutIcon(
                foreground = colours[0],
                background = colours[5],
                padding = 0,
                scale = 0.7
                    ),
                widget.CurrentLayout(
                font = "Ubuntu Bold",
                fontsize = 12,
                padding_y = 5,
                padding_x = 5,
                foreground = colours[2],
                background = colours[5],
                padding = 10,
                    ),
                widget.TextBox(
                text='◀',
                foreground = colours[4],
                background = colours[5],
                padding = -4,
                fontsize = 32,
                    ),
                widget.CheckUpdates(
                font = "Ubuntu Bold",
                fontsize = 12,
                padding_y = 5,
                padding_x = 5,
                foreground = colours[2],
                background = colours[4],
                padding = 10,
                colour_have_updates = colours[3],
                colour_no_updates = colours[2],
                display_format = '{updates} packages are out-of-date',
                no_update_string = 'Your system is update-to-date!',
                execute = 'alacritty -e paru -Syu --noconfirm',
                distro = "Arch_checkupdates",
                update_interval = 300,
                    ),
                widget.TextBox(
                text='◀',
                foreground = colours[5],
                background = colours[4],
                padding = -4,
                fontsize = 32,
                    ),
                widget.TextBox(
                text =  " 🌡",
                padding = 2,
                foreground = colours[2],
                background = colours[5],
                fontsize = 11
                    ),
                widget.ThermalSensor(
                font = "Ubuntu Bold",
                fontsize = 12,
                padding_y = 5,
                padding_x = 5,
                foreground = colours[2],
                background = colours[5],
                    ),
                widget.TextBox(
                text='◀',
                foreground = colours[4],
                background = colours[5],
                padding = -4,
                fontsize = 32,
                    ),
                widget.CPU(
                 font = "Ubuntu Bold",
                fontsize = 12,
                padding_y = 5,
                padding_x = 5,
                foreground = colours[2],
                background = colours[4],
                    ),
                widget.TextBox(
                text='◀',
                foreground = colours[5],
                background = colours[4],
                padding = -4,
                fontsize = 32,
                    ),
                widget.Memory(
                font = "Ubuntu Bold",
                fontsize = 12,
                padding_y = 5,
                padding_x = 5,
                foreground = colours[2],
                background = colours[5],
                    ),
                widget.TextBox(
                text='◀',
                foreground = colours[4],
                background = colours[5],
                padding = -4,
                fontsize = 32,
                    ),
                widget.TextBox(
                text = "Vol:",
                font = "Ubuntu Bold",
                foreground = colours[2],
                background = colours[4],
                    ),
                widget.Volume(
                font = "Ubuntu Bold",
                foreground = colours[2],
                background = colours[4],
                    ),
                widget.TextBox(
                text='◀',
                foreground = colours[5],
                background = colours[4],
                padding = -4,
                fontsize = 32,
                    ),
                widget.TextBox(
                text=' ◀',
                foreground = colours[4],
                background = colours[5],
                padding = -4,
                fontsize = 32,
                    ),
                widget.Clock(
                format='%A %b %d %H:%M',
                font = "Ubuntu Bold",
                fontsize = 13,
                foreground = colours[2],
                background = colours[4],
                    ),
            ], 24),
    ),
    Screen(
        top=bar.Bar(
            [
                widget.GroupBox(
                font = "Ubuntu Bold",
                fontsize = 12,
                padding_y = 5,
                padding_x = 5,
                active = colours[2],
                inactive = colours [2],
                highlight_method = "block",
                this_current_screen_border = colours[5],
                this_screen_border = colours[4],
                foreground = colours[2],
                background = colours[0],
                    ),
                widget.Prompt(
                font = "Ubuntu",
                fontsize = 12,
                foreground = colours[2],
                background = colours[5]
                    ),
                widget.WindowName(
                font = "Ubuntu",
                fontsize = 12,
                foreground = colours[5],
                background = colours[0],
                    ),
                widget.KeyboardLayout(
                font = "Ubuntu",
                fontsize = 12,
                foreground = colours[2],
                background = colours[0],
                configured_keyboards = ['us','uk'],
                    ),
                widget.TextBox(
                text=' ◀',
                foreground = colours[5],
                background = colours[0],
                padding = -4,
                fontsize = 32,
                    ),
                widget.CurrentLayoutIcon(
                foreground = colours[0],
                background = colours[5],
                padding = 0,
                scale = 0.7
                    ),
                widget.CurrentLayout(
                font = "Ubuntu Bold",
                fontsize = 12,
                padding_y = 5,
                padding_x = 5,
                foreground = colours[2],
                background = colours[5],
                padding = 10,
                    ),
                widget.TextBox(
                text='◀',
                foreground = colours[4],
                background = colours[5],
                padding = -4,
                fontsize = 32,
                    ),
                widget.CheckUpdates(
                font = "Ubuntu Bold",
                fontsize = 12,
                padding_y = 5,
                padding_x = 5,
                foreground = colours[2],
                background = colours[4],
                padding = 10,
                colour_have_updates = colours[3],
                colour_no_updates = colours[2],
                display_format = '{updates} packages are out-of-date',
                no_update_string = 'Your system is update-to-date!',
                execute = 'alacritty -e paru -Syu --noconfirm',
                update_interval = 300,
                    ),
                widget.TextBox(
                text='◀',
                foreground = colours[5],
                background = colours[4],
                padding = -4,
                fontsize = 32,
                    ),
                widget.TextBox(
                text =  " 🌡",
                padding = 2,
                foreground = colours[2],
                background = colours[5],
                fontsize = 11
                    ),
                widget.ThermalSensor(
                font = "Ubuntu Bold",
                fontsize = 12,
                padding_y = 5,
                padding_x = 5,
                foreground = colours[2],
                background = colours[5],
                    ),
                widget.TextBox(
                text='◀',
                foreground = colours[4],
                background = colours[5],
                padding = -4,
                fontsize = 32,
                    ),
                widget.CPU(
                 font = "Ubuntu Bold",
                fontsize = 12,
                padding_y = 5,
                padding_x = 5,
                foreground = colours[2],
                background = colours[4],
                    ),
                widget.TextBox(
                text='◀',
                foreground = colours[5],
                background = colours[4],
                padding = -4,
                fontsize = 32,
                    ),
                widget.Memory(
                font = "Ubuntu Bold",
                fontsize = 12,
                padding_y = 5,
                padding_x = 5,
                foreground = colours[2],
                background = colours[5],
                    ),
                widget.TextBox(
                text='◀',
                foreground = colours[4],
                background = colours[5],
                padding = -4,
                fontsize = 32,
                    ),
                widget.TextBox(
                text = "Vol:",
                font = "Ubuntu Bold",
                foreground = colours[2],
                background = colours[4],
                    ),
                widget.Volume(
                font = "Ubuntu Bold",
                foreground = colours[2],
                background = colours[4],
                    ),
                widget.TextBox(
                text='◀',
                foreground = colours[5],
                background = colours[4],
                padding = -4,
                fontsize = 32,
                    ),
                widget.Systray(
                font = "Ubuntu Bold",
                foreground = colours[2],
                background = colours[5],
                    ),
                widget.TextBox(
                text=' ◀',
                foreground = colours[4],
                background = colours[5],
                padding = -4,
                fontsize = 32,
                    ),
                widget.Clock(
                format='%A %b %d %H:%M',
                font = "Ubuntu Bold",
                fontsize = 13,
                foreground = colours[2],
                background = colours[4],
                    )
            ], 24),
    ),
]

# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: List
main = None  # WARNING: this is deprecated and will be removed soon
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    # Run the utility of `xprop` to see the wm class and name of an X client.
    {'wmclass': 'confirm'},
    {'wmclass': 'dialog'},
    {'wmclass': 'download'},
    {'wmclass': 'error'},
    {'wmclass': 'file_progress'},
    {'wmclass': 'notification'},
    {'wmclass': 'splash'},
    {'wmclass': 'toolbar'},
    {'wmclass': 'confirmreset'},  # gitk
    {'wmclass': 'makebranch'},  # gitk
    {'wmclass': 'maketag'},  # gitk
    {'wname': 'branchdialog'},  # gitk
    {'wname': 'pinentry'},  # GPG key password entry
    {'wmclass': 'ssh-askpass'},  # ssh-askpass
    {'wmclass': 'gimp'},
    {'wmclass': 'virtualbox'},
    {'wmclass': 'bleachbit'},
    {'wmclass': 'megasync'},
    {'wmclass': 'dragon-drag-and-drop'},
])
auto_fullscreen = True
focus_on_window_activation = "smart"

@hook.subscribe.startup_once
def autostart():
    processes = [
        ['lxsession'],
        ['picom', '--experimental-backend'],
        ['xrandr', '--output', 'HDMI-0', '--mode', '1920x1080', '--output', 'HDMI-1-1', '--mode', '1920x1080', '--right-of', 'HDMI-0'],
        ['nitrogen', '--restore'],
        ['redshift', '-O', '2500K'],
        ['nvidia-settings', '--assign', 'CurrentMetaMode="nvidia-auto-select', '+0+0', '{', 'ForceFullCompositionPipeline', '=', 'On', '}"'],
        ['sxhkd'],
        ['dunst'],
        ['unclutter', '--timeout', '1'],
        ['xset', 'r', 'rate', '300', '40'],
        ['setxkbmap', '-layout', 'us'],
        ['nm-applet'],
        #['mpd'],
        #['mpDris2'],
    ]
    for p in processes:
        subprocess.Popen(p)

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, GitHub issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"
