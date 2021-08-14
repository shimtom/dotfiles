" Appearance

" カラースキーマ設定
colorscheme one
set background=dark
let g:airline_theme='one'

" タイトルの表示/非表示
set title
" カーソル座標の表示/非表示
set ruler
" カーソル行の強調
set cursorline
" カーソル列の強調
set nocursorcolumn
" カラムラインを引く
" set colorcolumn=80
" ステータス行を表示(0:全く表示しない, 1:ウィンドウが２つ以上あるときだけ表示, 2:常に表示)
set laststatus=2
" メッセージ表示欄の行数.
set cmdheight=2

" タブを常に表示
set showtabline=2

" スクロールバーを消す
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L
set guioptions-=b

"ステータスライン左側
" set statusline=[%n]
" set statusline+=%{matchstr(hostname(),'\\w\\+')}@
" set statusline+=%<%F
" set statusline+=%m
" set statusline+=%r
" set statusline+=%hs
" set statusline+=%w
" set statusline+=[%{&fileformat}]
"set statusline+=[%{has('multi_byte')&&\&fileencoding!=''?&fileencoding:&}]
" set statusline+=%y
"
" set statusline+=%=

" ステータスライン右側
" set statusline+=%{exists('*SkkGetModeStr')?SkkGetModeStr():''}
" set statusline+=[%{col('.')-1}=ASCII=%B,HEX=%c]
" set statusline+=[C=%c/%{col('$')-1}]
" set statusline+=[L=%l/L]
"set statusline+=[WC=%{exists('*WordCount')?WordCount():[]}]
" set statusline+=[%p%%]
