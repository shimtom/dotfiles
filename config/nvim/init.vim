if 0 | endif

" dein
if &compatible
    set nocompatible
endif

set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim
let s:dein_dir = expand('~/.cache/dein')

if dein#load_state(s:dein_dir)
    call dein#begin(s:dein_dir)

    call dein#load_toml('~/.config/nvim/plugins/dein.toml',        {'lazy': 0})
    call dein#load_toml('~/.config/nvim/plugins/dein_theme.toml',  {'lazy': 0})
    call dein#load_toml('~/.config/nvim/plugins/dein_lazy.toml',   {'lazy': 1})
    call dein#load_toml('~/.config/nvim/plugins/dein_python.toml', {'lazy': 1})

    call dein#end()
    call dein#save_state()
endif

filetype plugin indent on
syntax enable

" install plugins on startup.
if dein#check_install()
  call dein#install()
endif

if (has("termguicolors"))
 set termguicolors
endif

" 関数設定
" 最後のカーソル位置を復元
" if has("autocmd")
"     autocmd BufReadPost *
"     \ if line("'\"") > 0 && line ("'\"") <= line("$") |
"     \   exe "normal! g'\"" |
"     \ endif
" endif

runtime! core.vim
runtime! editor.vim
runtime! appearance.vim
