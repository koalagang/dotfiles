from typing import List  # noqa: F401

import subprocess
from libqtile import bar, layout, widget, hook, qtile
from libqtile.config import Click, Drag, Group, Key, Screen, Match
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

mod = "mod4"
terminal = guess_terminal()

#---Qtile specific bindings (see my sxhkdrc for wm-agnostic bindings)

keys = [
    # Switch between windows in current stack pane
    Key([mod], "j", lazy.layout.down()),
    Key([mod], "k", lazy.layout.up()),
    Key([mod], "h", lazy.layout.left()),
    Key([mod], "l", lazy.layout.right()),

    # Move windows up or down in current stack
    Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
    Key([mod, "shift"], "h", lazy.layout.shuffle_left()),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right()),

    # Manipulate windows
    Key([mod, "control"], "i", lazy.layout.grow()),
    Key([mod, "control"], "o", lazy.layout.shrink()),
    Key([mod, "control"], "n", lazy.layout.normalize()),
    Key([mod, "control"], "m", lazy.layout.maximize()),
    Key([mod, "shift"], "space", lazy.layout.flip()),

    # Toggle between different layouts
    Key([mod], "q", lazy.next_layout()),
    Key([mod], "Tab", lazy.prev_layout()),

    # Restart or shutdown qtile
    Key([mod, "control"], "r", lazy.restart()),
    Key([mod, "control"], "q", lazy.shutdown()),

    # Move between workspaces
    Key([mod, "control"], "l", lazy.screen.next_group()),
    Key([mod, "control"], "h", lazy.screen.prev_group()),

    # Enter fullscreen mode
    Key([mod], "f", lazy.window.toggle_fullscreen()),

    # Move focus between monitors
    Key([mod, "control"], "j", lazy.to_screen(0)),
    Key([mod, "control"], "k", lazy.to_screen(1)),

    # Kill client
    Key([mod, "control"], "c", lazy.window.kill()),
]

#---Groups/workspaces

group_names = [("MISC",{'layout': 'monadtall'}),
            ("WEB",{'layout': 'monadtall'}),
            ("WATCH",{'layout': 'monadtall'}),
            ("MUSIC",{'layout': 'monadtall'}),
            ("GAME",{'layout': 'floating'}),
            ("CHAT",{'layout': 'monadtall'}),
            ("DEV",{'layout': 'monadwide'}),
            ("STUDY",{'layout': 'monadtall'})]

groups = [Group(name, **kwargs) for name, kwargs in group_names]

# Uses numbers 1 to 8 for workspaces
for i, (name, kwargs) in enumerate(group_names, 1):
    keys.append(Key([mod], str(i), lazy.group[name].toscreen()))        # Switch to another group
    keys.append(Key([mod, "shift"], str(i), lazy.window.togroup(name))) # Send current window to another group

layout_theme = {"border_width": 2,
                "margin": 4,
                "border_focus": "EB49CF",
                "border_normal": "B48EAD"
                }

layouts = [
    layout.MonadTall(**layout_theme),
    layout.MonadWide(**layout_theme),
    layout.Floating(**layout_theme),
]

#---Widgets and the panel

colours = [["#3B4252", "#3B4252"], # panel background
          ["#E5E9F0", "#E5E9F0"],  # font colour for group names
          ["#A7B3C9", "#A7B3C9"],  # colour for even widgets
          ["#B48EAD", "#B48EAD"]]  # colour for odd widgets

widget_defaults = dict(
    font='Ubuntu Bold',
    fontsize=12,
    padding=3,
)
extension_defaults = widget_defaults.copy()

def init_widgets_list():
    widgets_list = [
                widget.GroupBox(
                fontsize = 12,
                padding_y = 5,
                padding_x = 5,
                active = colours[1],
                inactive = colours [1],
                highlight_method = "block",
                this_current_screen_border = colours[3],
                this_screen_border = colours[2],
                foreground = colours[1],
                background = colours[0],
                    ),
                widget.WindowName(
                font = "Ubuntu",
                fontsize = 12,
                foreground = colours[3],
                background = colours[0],
                    ),
                widget.KeyboardLayout(
                font = "Ubuntu",
                fontsize = 12,
                foreground = colours[1],
                background = colours[0],
                    ),
                widget.TextBox(
                text=' ◀',
                foreground = colours[3],
                background = colours[0],
                padding = -4,
                fontsize = 32,
                    ),
                widget.CurrentLayoutIcon(
                foreground = colours[1],
                background = colours[3],
                padding = 0,
                scale = 0.7
                    ),
                widget.CurrentLayout(
                fontsize = 12,
                padding_y = 5,
                padding_x = 5,
                foreground = colours[1],
                background = colours[3],
                padding = 10,
                    ),
                widget.TextBox(
                text='◀',
                foreground = colours[2],
                background = colours[3],
                padding = -4,
                fontsize = 32,
                    ),
                widget.TextBox(
                text =  " ",
                padding = 2,
                foreground = colours[1],
                background = colours[2],
                fontsize = 25
                    ),
                widget.ThermalSensor(
                fontsize = 12,
                padding_y = 5,
                padding_x = 5,
                foreground = colours[1],
                background = colours[2],
                    ),
                widget.TextBox(
                text='◀',
                foreground = colours[3],
                background = colours[2],
                padding = -4,
                fontsize = 32,
                    ),
                widget.CPU(
                fontsize = 12,
                padding_y = 5,
                padding_x = 5,
                foreground = colours[1],
                background = colours[3],
                    ),
                widget.TextBox(
                text='◀',
                foreground = colours[2],
                background = colours[3],
                padding = -4,
                fontsize = 32,
                    ),
                widget.Memory(
                fontsize = 12,
                padding_y = 5,
                padding_x = 5,
                foreground = colours[1],
                background = colours[2],
                    ),
                widget.TextBox(
                text='◀',
                foreground = colours[3],
                background = colours[2],
                padding = -4,
                fontsize = 32,
                    ),
                widget.TextBox(
                text = "Vol:",
                foreground = colours[1],
                background = colours[3],
                padding = 0,
                    ),
                widget.Volume(
                foreground = colours[1],
                background = colours[3],
                padding = 5,
                execute = terminal + ' -e bpytop',
                    ),


                widget.TextBox(
                text='◀',
                foreground = colours[2],
                background = colours[3],
                padding = -4,
                fontsize = 32,
                    ),
                widget.Systray(
                foreground = colours[1],
                background = colours[2],
                    ),
                widget.TextBox(
                text='◀',
                foreground = colours[2],
                background = colours[3],
                padding = -4,
                fontsize = 32,
                    ),
                widget.CheckUpdates(
                fontsize = 12,
                padding_y = 5,
                padding_x = 5,
                foreground = colours[1],
                background = colours[2],
                padding = 10,
                display_format = '{updates} packages are out-of-date',
                no_update_string = 'Your system is update-to-date!',
                execute = terminal + ' -e paru -Syu --noconfirm',
                distro = "Arch_checkupdates",
                update_interval = 300,
                    ),


                widget.TextBox(
                text=' ◀',
                foreground = colours[3],
                background = colours[2],
                padding = -4,
                fontsize = 32,
                    ),
                widget.Clock(
                format='%A %b %d %H:%M',
                fontsize = 13,
                foreground = colours[1],
                background = colours[3],
                    ),
                ]
    return widgets_list

def init_widgets_screen1():
    widgets_screen1 = init_widgets_list()
    del widgets_screen1[16:18]
    return widgets_screen1

def init_widgets_screen2():
    widgets_screen2 = init_widgets_list()
    del widgets_screen2[18:20]
    return widgets_screen2

def init_screens():
    return [Screen(top=bar.Bar(widgets=init_widgets_screen1(), opacity=1.0, size=20)),
            Screen(top=bar.Bar(widgets=init_widgets_screen2(), opacity=1.0, size=20))]

if __name__ in ["config", "__main__"]:
    widgets_list = init_widgets_list()
    screens = init_screens()
    widgets_screen1 = init_widgets_screen1()
    widgets_screen2 = init_widgets_screen2()

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
    {'wmclass': 'virtualbox'},
    {'wmclass': 'dragon-drag-and-drop'},
    {'wmclass': 'gimp'},
    {'wmclass': 'display'}, # ImageMagick GUI
    # Gaming
    {'wmclass': 'zenity'},
    {'wmclass': 'Steam'},
    {'wmclass': 'Steam - Fatal Error'},
    {'wmclass': 'lutris'},
    {'wmclass': 'System preferences'},
    {'wmclass': 'Progress'},
    {'wmclass': 'wineboot.exe'},
    {'wmclass': 'control.exe'},
    {'wmclass': 'unitycrashhandler64.exe'},
])

auto_fullscreen = True
focus_on_window_activation = "smart"

# Makes java apps work properly
wmname = "LG3D"
