config.load_autoconfig(False)

c.tabs.position = "right"
c.tabs.title.format = ""
c.tabs.favicons.scale = 2
c.tabs.padding = {
        "top": 15,
        "bottom": 15,
        "left": 0,
        "right": 10
} 
c.tabs.width = 53
c.tabs.indicator.width = 2
c.tabs.indicator.padding = {
        "top": 0,
        "bottom": 0,
        "left": 3,
        "right": 5
}

c.statusbar.show = 'always'

c.colors.tabs.bar.bg = '#000000'
c.colors.tabs.selected.even.bg = '#00b000'
c.colors.tabs.selected.odd.bg = '#00b000'
c.colors.tabs.even.bg = '#000000'
c.colors.tabs.odd.bg = '#000000'

c.colors.contextmenu.menu.bg = '#000000'
c.colors.contextmenu.menu.fg = '#00b000'

c.colors.completion.item.selected.bg = '#00b000'
c.colors.completion.item.selected.border.top = '#00b000'
c.colors.completion.item.selected.border.bottom = '#00b000'
c.colors.completion.match.fg = '#50ff50'

c.colors.completion.category.bg = '#000000'
c.colors.completion.category.border.top = '#00b000'
c.colors.completion.category.border.bottom = '#00b000'
c.colors.completion.category.fg = '#00b000'

c.colors.completion.even.bg = '#000000'
c.colors.completion.odd.bg = '#000000'
c.colors.completion.fg = '#00b000'

c.colors.hints.fg = '#009000'
c.colors.hints.match.fg = '#00ff00'
c.colors.hints.bg = '#000000'
c.hints.padding = {
        "top": 2,
        "bottom": 2,
        "left": 2,
        "right": 2
}
c.hints.radius = 0
c.hints.border = '1px solid #00f000'

c.url.start_pages = [
        'https://discord.com/channels/@me',
        'https://start.duckduckgo.com/?q=DuckDuckGo+AI+Chat&ia=chat&duckai=1'
        ]

config.bind('<Escape>', 'mode-leave ;; jseval -q document.activeElement.blur()', mode='insert')
config.bind(';m', 'hint links spawn mpv {hint-url}')
