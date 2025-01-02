from qutebrowser.config.configfiles import ConfigAPI  # noqa: F401
from qutebrowser.config.config import ConfigContainer  # noqa: F401
config: ConfigAPI = config  # noqa: F821 pylint: disable=E0602,C0103
c: ConfigContainer = c  # noqa: F821 pylint: disable=E0602,C0103
config.load_autoconfig(False)

c.tabs.position = "right"
c.tabs.title.format = ""
c.tabs.favicons.scale = 2
c.tabs.padding = {
        "top": 15,
        "bottom": 15,
        "left": 10,
        "right": 15
} 
c.tabs.width = 53
c.tabs.indicator.width = 0

c.statusbar.show = 'always'

c1 = "#d6cff8"
c2 = "#7e6ac1"
c3 = "#4e31a4"

c.colors.tabs.bar.bg = '#000000'
c.colors.tabs.selected.even.bg = c2
c.colors.tabs.selected.odd.bg = c2 
c.colors.tabs.even.bg = '#000000'
c.colors.tabs.odd.bg = '#000000'

c.colors.contextmenu.menu.bg = '#000000'
c.colors.contextmenu.menu.fg = c2 

c.colors.completion.item.selected.bg = c2 
c.colors.completion.item.selected.border.top = c2 
c.colors.completion.item.selected.border.bottom = c2 
c.colors.completion.match.fg = c1

c.colors.completion.category.bg = '#000000'
c.colors.completion.category.border.top = c2 
c.colors.completion.category.border.bottom = c2 
c.colors.completion.category.fg = c2 

c.colors.completion.even.bg = '#000000'
c.colors.completion.odd.bg = '#000000'
c.colors.completion.fg = c3 

c.colors.webpage.preferred_color_scheme = "dark"
c.colors.webpage.darkmode.policy.images = "smart-simple"
c.colors.webpage.darkmode.enabled = True

c.colors.hints.fg = '#4e31a4'
c.colors.hints.match.fg = '#7e6ac1'
c.colors.hints.bg = '#000000'
c.hints.padding = {
        "top": 2,
        "bottom": 2,
        "left": 2,
        "right": 2
}
c.hints.radius = 0
c.hints.border = '1px solid ' + c2

c.url.start_pages = [
        'https://discord.com/channels/@me',
        'https://chat.deepseek.com/'
        ]
c.url.searchengines = {
        'DEFAULT': 'https://duckduckgo.com/?q={}',
        '!yt': 'https://www.youtube.com/results?search_query={}',
}

config.bind('<Escape>', 'mode-leave ;; jseval -q document.activeElement.blur()', mode='insert')
config.bind(';f', 'hint links spawn --detach mpv {hint-url}')

config.set("input.mode_override", "passthrough", "https://colab.research.google.com")
config.set("input.mode_override", "passthrough", "https://www.kaggle.com")
