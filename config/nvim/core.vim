" Core Setting

" viとの互換性を優先しない
set nocompatible
" バッファが編集中でもその他のファイルを開けるようにする
set hidden
" 数字を10進数として扱う
set nrformats-=octal
" 全角文字を半角n文字として扱う
set ambiwidth=
" カーソルの移動制限をなくす
set whichwrap=b,s,[,],<,>
" backspaceを空白,行末,行頭でも使えるようにする
set backspace=indent,eol,start
" マウス操作を有効にする
set mouse=a
"文字コードをUFT-8に設定
set fenc=utf-8
" バックアップファイルを作成しない
set nobackup
" スワップファイルを作成しない
set noswapfile
" ビープ音を可視化する
set visualbell
" ビジュアルベルの表示内容
set t_vb=
" エラーメッセージ表示時にビープを鳴らさない
set noerrorbells
" 履歴に保存しておくコマンドの数
set history=2000
" undo可能な変更の最大値
set undolevels=1000
" 外部での変更を反映
set autoread
" クリップボードの共有
set clipboard=unnamedplus
" コマンドラインモードでTABキーによるファイル名補完を有効にする
set wildmenu
" ファイル名補完の挙動を設定する.
set wildmode=list:longest,full
" 内部文字コード設定
set encoding=utf-8
" ファイル書き込み時の文字コード設定
set fileencoding=utf-8
" ファイル読み込み時の文字コード設定
set fileencodings=utf-8,iso-2022-jp,cp932,euc-jp
" ターミナルの文字コードを内部文字コードと同一に設定
set termencoding=
" 改行文字を`\n`に設定
set fileformat=unix
" 改行文字の自動判別設定
set fileformats=unix,dos,mac
" vim終了時に保存の確認を行う
set confirm
" ウィンドウの最後の行をできる限りまで表示
set display=lastline
" Vimのテキスト整形の挙動を設定
set formatoptions-=c
" 置換の時、gを指定しなくても同一行で複数回置換が行われる
set gdefault
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch
" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>
" ヘルプ画面を画面いっぱいに表示
set helpheight=999
"マクロなどの途中経過を描写しない
set lazyredraw
" 変換候補で一度に表示される数を設定する
set pumheight=10
" Windows環境でフォルダの区切り文字を`\`の代わりにスラッシュ`/`にする
set shellslash
" 高速ターミナル接続を行う
set ttyfast
"Swapを作るまでの時間m秒
set updatetime=0
" 矩形選択とノーマルモードで行末より後ろにカーソルを置ける
set virtualedit=onemore,block
" マウス形状を設定
set mouseshape=i:arrow
" 画面の左右の端でスクロールが発生した場合,何文字ずつスクロールするか
set sidescroll=1



""エンコードを指定して再読み込みm
menu User.Encode.reload.EUC :e ++enc=euc-jp<CR>
menu User.Encode.reload.ISO :e ++enc=iso-2022-jp<CR>
menu User.Encode.reload.SJIS :e ++enc=cp932<CR>
menu User.Encode.reload.UTF :e ++enc=utf-8<CR>

"保存エンコードを指定
menu User.Encode.convert.EUC :set fenc=euc-jp<CR>
menu User.Encode.convert.ISO :set fenc=iso-2022-jp<CR>
menu User.Encode.convert.SJIS :set fenc=cp932<CR>
menu User.Encode.convert.UTF :set fenc=utf-8<CR>

"フォーマットを指定して再読み込み
menu User.Format.Dos :e ++ff=dos<CR>
menu User.Format.Mac :e ++ff=mac<CR>
menu User.Format.Unix :e ++ff=unix<CR>

"TABをSPACEに変換する
menu User.Global.Space :set expandtab<CR>:retab<CR>
"空白行を削除する
menu User.Global.Delete :g/^$/d<CR>
