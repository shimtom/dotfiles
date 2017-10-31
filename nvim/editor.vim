
" Editor
let g:indentLine_enabled = 1
let g:indentLine_char = '│'


" 対応する括弧を強調表示
set showmatch
" 括弧のマッチ時間を設定
set matchtime=1
" 行番号を表示する
set number
" 一つ前の行に基づき自動でインデントを設定
set autoindent
" シンタックスに基づき自動でインデントを設定
set smartindent
" 不可視文字を表示
set list
" 不可視文字設定
set listchars=tab:»\ ,eol:¬,extends:❯,precedes:❮,nbsp:%
" タブを半角スペースで挿入
set expandtab
" 行頭のタブサイズを`shiftwidth`,行頭以外のタブサイズを`tabstop`にする
set smarttab
" vimが自動で生成するtab幅
set shiftwidth=4
" タブ幅
set tabstop=4
" `tabstop`で設定された値をタブ幅として使用する
set softtabstop=0
" 最終行より下に何文字スクロールするか.
set scrolloff=8
" 画面の左右の端でカーソル先の視界を何桁確保するか
set sidescrolloff=16
" 自動折り返し
set wrap
" 折り返し部分のインデントを合わせる
set linebreak
" 折り返し文字数
set textwidth=100
