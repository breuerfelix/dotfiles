c.zoom.default = 120
c.qt.highdpi = False

c.scrolling.smooth = False
#c.search.ignore_case = True

c.url.default_page = 'https://github.com/breuerfelix'
c.url.searchengines['DEFAULT'] = 'https://www.google.com/search?q={}'

config.bind('<Ctrl-j>', 'tab-next', mode = 'normal')
config.bind('<Ctrl-k>', 'tab-prev', mode = 'normal')
config.bind('J', 'scroll-page 0 0.1', mode = 'normal')
config.bind('K', 'scroll-page 0 -0.1', mode = 'normal')
