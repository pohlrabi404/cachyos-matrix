let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/dotfiles/pohlrabi/.config
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +4 nvim/init.lua
badd +9 ~/dotfiles/pohlrabi/.config/nvim/lua/install/mini.lua
badd +1 ~/dotfiles/pohlrabi/.config/nvim/lua/lazy.lua
badd +1 ~/wiki/knowledge/index.md
badd +26 ~/dotfiles/pohlrabi/.config/nvim/lua/install/telescope.lua
badd +208 sway/config
badd +71 rebos/imports/system.toml
badd +17 ~/dotfiles/pohlrabi/.config/nvim/lua/settings/keybinds.lua
badd +30 waybar/config
badd +70 qutebrowser/config.py
badd +5 ~/dotfiles/pohlrabi/.config/mpv/mpv.conf
badd +79 mpv/input.conf
badd +7 ~/wiki/knowledge/journal/2024-10-13.md
badd +124 qutebrowser/greasemonkey/ad.js
badd +657 mpv/tech-overview.txt
badd +93 mpv/mplayer-input.conf
badd +37 ~/dotfiles/pohlrabi/.config/nvim/lua/settings/options.lua
badd +4 nvim/lazy-lock.json
badd +1 ~/dotfiles/pohlrabi/.config/nvim/lua/install/init
badd +1 ~/dotfiles/pohlrabi/.config/nvim/lua/settings/theme.lua
badd +52 ~/dotfiles/pohlrabi/.config/nvim/lua/install/installs.lua
badd +32 nvim/lua/configs/lazy.lua
badd +37 ~/dotfiles/pohlrabi/.config/nvim/lua/plugins/obsidian.lua
badd +1 ~/vaults/wiki/1729081227-USPT.md
badd +20 ~/dotfiles/pohlrabi/.config/nvim/lua/plugins/mini.lua
badd +18 ~/dotfiles/pohlrabi/.config/nvim/lua/plugins/theme.lua
badd +5 ~/dotfiles/pohlrabi/.config/nvim/lua/plugins/telescope.lua
badd +18 nvim/lua/auto-plugins.lua
badd +33 nvim/lua/plugins/completions.lua
badd +2 man://local(n)
badd +47 qutebrowser/greasemonkey/yt-adblock.js
argglobal
%argdel
edit ~/dotfiles/pohlrabi/.config/mpv/mpv.conf
argglobal
balt sway/config
setlocal fdm=manual
setlocal fde=0
setlocal fmr={{{,}}}
setlocal fdi=#
setlocal fdl=0
setlocal fml=1
setlocal fdn=20
setlocal fen
silent! normal! zE
let &fdl = &fdl
let s:l = 17 - ((14 * winheight(0) + 20) / 41)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 17
normal! 0
tabnext 1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
nohlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
