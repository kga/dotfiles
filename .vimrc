syntax enable

set runtimepath+=$HOME/.vim/hatena

if &term =~ "xterm-256color"
    " set t_Co=16
    " set t_Sf=dm
    " set t_Sb=dm
    "colorscheme slate
    "colorscheme desert256
    "colorscheme xoria256
    "colorscheme 256_asu1dark
    colorscheme inkpot
    "colorscheme desert

    " 補完候補の色づけ for vim7
"    hi Pmenu ctermbg=8
"    hi PmenuSel ctermbg=12
"    hi PmenuSbar ctermbg=0
endif

" VIM!
set nocompatible
" BS
set backspace=indent,eol,start
" 自動改行
set textwidth=0
" バックアップしない
set nobackup
" 色んな情報を記憶
set viminfo='50,<500,s100,\"50
" ruler
set ruler
" もっと下まで
set scrolloff=10
" suffixの優先順位を低くする
set suffixes=.bak,~,.swp,.o,.info,.aux,.log,.dvi,.bbl,.blg,.brf,.cb,.ind,.idx,.ilg,.inx,.out,.toc
" 補完
"set completeopt=menu,preview,longest
" TAB
set smarttab
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

"ignore modeline
set modelines=0
"インデント
set smartindent autoindent
"検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
"検索文字列に大文字が含まれている場合は区別して検索する
set smartcase
"検索時に最後まで行ったら最初に戻る
set wrapscan
"検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
"タブの左側にカーソル表示
set list
set listchars=tab:>\ ,trail:-
"入力中のコマンドをステータスに表示する
set showcmd
"括弧入力時の対応する括弧を表示
set showmatch
"検索結果文字列のハイライトを有効にしない
set hlsearch
"ステータスラインを常に表示
set laststatus=2
"
set ambiwidth=double

set nofoldenable

" set number

"set whichwrap=b,s,h,l,<,>,[,]

if has("autocmd")
    filetype plugin indent on

    " filetype毎の設定
    autocmd FileType html set indentexpr=
    autocmd FileType xhtml set omnifunc=htmlcomplete#CompleteTags indentexpr=
    autocmd FileType css set omnifunc=csscomplete#CompleteCSS
    autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
    autocmd FileType tex nnoremap <silent> ,p :!platex %<CR>
    "autocmd FileType tex nnoremap <silent> <Space>r :!rake &>/dev/null &<CR>
    autocmd FileType tex set fenc=euc-jp
    autocmd FileType plaintex nmap <silent> ,p :!platex %<CR>
    autocmd FileType plaintex set fenc=euc-jp
    autocmd FileType yaml set expandtab ts=2 sw=2 enc=utf-8 fenc=utf-8

    autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
    autocmd FileType javascript setlocal nocindent
    autocmd FileType c set omnifunc=ccomplete#Complete expandtab ts=2 sw=2
    autocmd FileType python set omnifunc=pythoncomplete#Complete
    autocmd FileType php set omnifunc=phpcomplete#CompletePHP

    autocmd FileType svn set fenc=utf-8
    autocmd BufNewFile,BufRead *.tt2 set ft=tt2
    autocmd BufNewFile,BufRead *.tt set ft=tt2
    autocmd BufNewFile,BufRead *.as set ft=actionscript
    " cofs's fsync
    autocmd BufNewFile,BufRead /c/* set nofsync
    autocmd BufNewFile,BufRead /d/* set nofsync
endif

func! GetB()
    let c = matchstr(getline('.'), '.', col('.') - 1)
    let c = iconv(c, &enc, &fenc)
    return String2Hex(c)
endfunc

func! Nr2Hex(nr)
    let n = a:nr
    let r = ""
    while n
        let r = '0123456789ABCDEF'[n % 16] . r
        let n = n / 16
    endwhile
    return r
endfunc

func! String2Hex(str)
    let out = ''
    let ix = 0
    while ix < strlen(a:str)
        let out = out . Nr2Hex(char2nr(a:str[ix]))
        let ix = ix + 1
    endwhile
    return out
endfunc


"ステータスラインに文字コードと改行文字を表示する
if winwidth(0) >= 120
    set statusline=%<[%n]%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%y\ %F%=[%{GetB()}]\ %l,%c%V%8P
else
    set statusline=%<[%n]%m%r%h%w%{'['.(&fenc!=''?&fenc:&enc).':'.&ff.']'}%y\ %f%=[%{GetB()}]\ %l,%c%V%8P
endif

" コマンドライン補間をシェルっぽく
set wildmode=list:longest,full
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 外部のエディタで編集中のファイルが変更されたら自動で読み直す
set autoread

set termencoding=utf-8
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,iso-2022-jp,euc-jp,cp932,utf-16,utf-16le

" set tags
" if has("autochdir")
"     set autochdir
"     set tags=tags;
" endif

" 辞書ファイルからの単語補間
set complete+=k

" yeでそのカーソル位置にある単語をレジスタに追加
nmap ye :let @"=expand("<cword>")<CR>

autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | silent! exe '!echo -n "kv:%\\"' | endif
" autocmd VimLeave * silent! exe '!echo -n "k`basename $PWD`\\"'

" shebangがあるならchmod +x
" autocmd BufWritePost * if getline(1) =~ "^#!" | exe "silent !chmod +x %" | endif

" command mode 時 tcsh風のキーバインドに
cmap <C-a> <Home>
cmap <C-f> <Right>
cmap <C-b> <Left>
cmap <C-d> <Delete>
cmap <Esc>b <S-Left>
cmap <Esc>f <S-Right>

"表示行単位で行移動する
nmap j gj
nmap k gk
vmap j gj
vmap k gk

" 前回終了したカーソル行に移動
autocmd BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif

",e でそのコマンドを実行
nnoremap ,e :call ShebangExecute()<CR>
function! ShebangExecute()
    let m = matchlist(getline(1), '#!\(.*\)')
    if(len(m) > 2)
        execute '!'. m[1] . ' %'
    else
        execute '!' &ft ' %'
    endif
endfunction

" FuzzyFinder
let g:fuf_modesDisable = []
let g:fuf_ignoreCase = 1
let g:fuf_enumeratingLimit = 30
let g:fuf_mrufile_maxItem = 1000
nnoremap <silent> fb :FufBuffer<CR>
nnoremap <silent> fm :FufMruFile<CR>
nnoremap <silent> ff :FufFile<CR>
nnoremap <silent> fF :FufFile <C-r>=expand('%:~:.')[:-1-len(expand('%:~:.:t'))]<CR><CR>

" いろいろ囲むよ
function! Quote(quote)
    normal mz
    exe 's/\(\k*\%#\k*\)/' . a:quote . '\1' . a:quote . '/'
    normal `zl
endfunction

function! UnQuote()
    normal mz
    "  exe 's/["' . "'" . ']\(\k*\%#\k*\)[' . "'" . '"]/\1/'
    exe 's/\(["' . "'" . ']\)\(\k*\%#\k*\)\1/\2/'
    normal `z
endfunction

nnoremap <silent> ,q" :call Quote('"')<CR>
nnoremap <silent> ,q' :call Quote("'")<CR>
nnoremap <silent> ,qd :call UnQuote()<CR>

" 現在行をhighlight
" set updatetime=1
" autocmd CursorHold * :match Search /^.*\%#.*$

" code2html
let html_use_css = 1

" ペースト時にautoindentを無効に
"set paste

" 16色
" set t_Co=16
" set t_Sf=dm
" set t_Sb=dm


" 検索後、真ん中にフォーカスをあわせる
"nmap n nzz
"nmap N Nzz
"nmap * *zz
"nmap # #zz
"nmap g* g*zz
"nmap g# g#zz

" encoding
nmap ,U :set encoding=utf-8<CR>
nmap ,E :set encoding=euc-jp<CR>
nmap ,S :set encoding=cp932<CR>

nmap <silent> eu :set fenc=utf-8<CR>
nmap <silent> es :set fenc=cp932<CR>
nmap <silent> ee :set fenc=euc-jp<CR>

vnoremap <silent> <Space>a :Align =><CR>
nnoremap <silent> <Space>/ :nohlsearch<CR>

"let g:AutoComplPop_NotEnableAtStartup = 1
"" Use neocomplcache.
"let g:NeoComplCache_EnableAtStartup = 1
"" Use smartcase.
"let g:NeoComplCache_SmartCase = 1
"" Use previous keyword completion.
"let g:NeoComplCache_PreviousKeywordCompletion = 1
"" Try keyword completion.
"let g:NeoComplCache_TryKeywordCompletion = 1
"" Try default completion.
"let g:NeoComplCache_TryDefaultCompletion = 1
"" Use preview window.
"let g:NeoComplCache_EnableInfo = 1
"" Delete keyword when rank is 0.
"let g:NeoComplCache_DeleteRank0 = 0
"" Use camel case completion.
"let g:NeoComplCache_EnableCamelCaseCompletion = 1
"" Set minimum syntax keyword length.
"let g:NeoComplCache_MinSyntaxLength = 3
"" Set skip input time.
"let g:NeoComplCache_SkipInputTime = '0.1'

command! -nargs=1 -complete=file Rename f <args>|call delete(expand('#'))

set exrc
