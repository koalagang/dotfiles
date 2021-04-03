#  \##|   |
###\\ |   |
#   \\|   \'---'/   Dante (@koalagang)
#    \   _'.'O'.'   https://github.com/koalagang
#     | :___   \
#     |  _| :  |    "I don't only block adverts on the browser level. Instead I use my local host file - see: https://www.youtube.com/watch?v=VPfpCVW7ZvM"
#     | :__,___/
#     |   |
#     |   |
#     |   |
#     |   |
# NOTE: config.py is intended for advanced users who are comfortable
# with manually migrating the config file on qutebrowser upgrades. If
# you prefer, you can also configure qutebrowser using the
# :set/:bind/:config-* commands without having to write a config.py
# file.
#
# Documentation:
#   qute://help/configuring.html
#   qute://help/settings.html

config.load_autoconfig(False)

# Keybindings for normal mode
config.bind('M', 'hint links spawn mpv {hint-url}') # generally I just watch videos in mpv via pipe-viewer, not a browser
config.bind('Y', 'hint links spawn alacritty -e youtube-dl {hint-url}')
config.bind('ss', 'config-cycle statusbar.show always never;; config-cycle tabs.show always never')
config.bind('T', 'config-cycle tabs.show always never')
config.bind('d', 'scroll-page 0 1')
config.bind('u', 'scroll-page 0 -1')
config.bind('j', 'scroll-page 0 0.1')
config.bind('k', 'scroll-page 0 -0.1')
config.bind('h', 'back')
config.bind('l', 'forward')
config.bind('D', 'bookmark-add')
config.bind('L', 'search')
config.bind('R', 'spawn --userscript readability') # readermode
config.bind('pr', 'open https://outline.com/{url}') # another readmore mode (with pictures)

# Aliases
c.aliases = {'q': 'quit', 'Q': 'quit'} # it's nice to have these (although you should use ZQ or ZZ)
c.aliases = {'read': 'spawn --userscript readability'}

#---Limits & Delays
c.completion.height = 200
c.completion.shrink = True
c.completion.scrollbar.width = 10
c.content.cache.maximum_pages = 50
c.keyhint.delay = 0
c.messages.timeout = 5000
c.tabs.show_switching_delay = 1500

#---Appearance & Functionality
c.url.searchengines = {'DEFAULT': 'https://duckduckgo.com/?q={}', 'w': 'http://en.wikipedia.org/w/index.php?search={}', 'aw': 'https://wiki.archlinux.org/?search={}', 'c': "https://www.collinsdictionary.com/dictionary/english/{}", 'gh': 'https://github.com/search?q={}', 'sp': 'https://www.startpage.com/do/dsearch?query={}'}
c.search.ignore_case = "always"
c.statusbar.show = "in-mode"
c.tabs.close_mouse_button = "right"
c.tabs.last_close = "close"
c.tabs.show = "switching"
c.tabs.mode_on_change = "restore"
c.statusbar.widgets = ['url', 'keypress', 'progress']
c.input.insert_mode.auto_load = True
c.scrolling.smooth = True
c.input.spatial_navigation = True
#c.downloads.remove_finished = -1
#config.set('fileselect.multiple_files.command', 'alacritty', '-e','vifm','--choosefiles=()')
#config.set('fileselect.single_file.command', 'alacritty', '-e','vifm','--choosefile=()')
#c.tabs.title.format =
c.window.hide_decoration = True
c.url.start_pages = "about:blank"
c.url.default_page = "about:blank"
c.colors.webpage.preferred_color_scheme = "dark"
# Dracula Theme
import dracula.draw
config.load_autoconfig()
dracula.draw.blood(c, {
    'spacing': {
        'vertical': 6,
        'horizontal': 8
    }
})

#---Privacy & Security
# In ~/.config/qutebrowser/block-hosts I have added YouTube so that I only watch it via a dedicated application - this removes exposure to the YouTube algorithm
c.content.blocking.enabled = True # I have this turned on but also -  see line 6 of this config
c.content.javascript.enabled  = True
c.content.headers.do_not_track = True
config.set('content.cookies.accept', 'no-3rdparty', 'devtools://*')
config.set('content.cookies.accept', 'no-3rdparty', 'chrome-devtools://*')
c.content.private_browsing = True
c.new_instance_open_target = "private-window"
c.downloads.location.prompt = False
c.downloads.location.directory = "~/Downloads"
c.content.geolocation = False
c.content.media.audio_capture = False
c.content.media.video_capture = False
c.content.media.audio_video_capture = False
c.content.notifications = False
c.content.autoplay = False
c.content.canvas_reading = False
c.content.dns_prefetch = False
c.content.headers.referer = "same-domain"
c.content.mouse_lock = False
#c.content.proxy =
#c.content.proxy_dns_requests =
c.content.webgl = False
c.content.webrtc_ip_handling_policy = "default-public-interface-only"
#c.ssl_strict = "ask"
#c.content.unknown_url_scheme_policy = "allow-from-user-interaction"
c.content.headers.accept_language = "en-US,en;q=0.5"
c.content.headers.custom = {"accept": "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8"}
# Random user-agent string for every launch
import random
uas = random.randint(1,8)
if uas == 1:
    config.set('content.headers.user_agent', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/74.0.3729.169 Safari/537.36')
elif uas == 2:
    config.set('content.headers.user_agent', 'Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.121 Safari/537.36')
elif uas == 3:
    config.set('content.headers.user_agent', 'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1; .NET CLR 1.1.4322)')
elif uas == 4:
    config.set('content.headers.user_agent', 'Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; SV1)')
elif uas == 5:
    config.set('content.headers.user_agent', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/60.0.3112.113 Safari/537.36')
elif uas == 6:
    config.set('content.headers.user_agent', 'Mozilla/5.0 (Windows NT 6.1; WOW64; Trident/7.0; rv:11.0) like Gecko')
elif uas == 7:
    config.set('content.headers.user_agent', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.140 Safari/537.36 Edge/17.17134')
elif uas == 8:
    config.set('content.headers.user_agent', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/64.0.3282.140 Safari/537.36 Edge/18.17763')

# Load images automatically in web pages.
# Type: Bool
config.set('content.images', True, 'chrome-devtools://*')
config.set('content.images', True, 'devtools://*')

# Enable JavaScript.
# Type: Bool
config.set('content.javascript.enabled', True, 'chrome-devtools://*')
config.set('content.javascript.enabled', True, 'devtools://*')
config.set('content.javascript.enabled', True, 'chrome://*/*')
config.set('content.javascript.enabled', True, 'qute://*/*')
