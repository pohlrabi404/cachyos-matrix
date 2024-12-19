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
badd +0 rebos/managers/system.toml
badd +22 nvim/lua/settings/keybinds.lua
badd +2 nvim/lua/settings/options.lua
badd +1 nvim/lua/plugins/obsidian.lua
badd +74 nvim/lua/plugins/wiki.lua
badd +34 nvim/lua/install/installs.lua
badd +218 sway/config
badd +2 nvim/lua/plugins/auto-save.lua
badd +10 nvim/lua/plugins/telescope.lua
badd +2 qutebrowser/quickmarks
badd +73 qutebrowser/config.py
badd +1 mpv/scripts/pause-indicator.lua
badd +28 mpv/scripts/youtube-upnext.lua
badd +1456 ~/dotfiles/pohlrabi/.config/mpv/scripts/playlistmanager.lua
badd +4 mpv/mpv.conf
badd +23 mpv/scripts/ytsub.lua
badd +16 waybar/config
badd +1 ~/Downloads/2024-11-24-kumagaya-news-text.txt
argglobal
%argdel
edit rebos/managers/system.toml
argglobal
balt rebos/managers/system.toml
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
let s:l = 6 - ((5 * winheight(0) + 23) / 46)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 6
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
