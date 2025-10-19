
"set nocompatible

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","
let g:mapleader = ","

" Enable filetype plugins
filetype plugin on
filetype indent on

" Enable syntax highlighting
syntax on

" Look / Behavior
"set guifont=Courier_new:h10:cANSI
colorscheme jellybeans
set bg=dark
set smartcase
set smarttab
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smartindent
set autoindent
set number
set cmdheight=1
set nowrap
"set wrap linebreak
set colorcolumn=80
set ruler
set shiftround " sr
set cindent " cin
set copyindent " ci
set preserveindent "pi
set hlsearch
set cursorline
set cursorcolumn     "hilight the column of the cursor
"set relativenumber number
" No annoying sound on errors
set noerrorbells
set novisualbell
set showmatch
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowb
set noswapfile
" How many tenths of a second to blink when matching brackets
set mat=2
set incsearch
"set wildignorecase
set wildmenu
setglobal wildmode=full
setglobal wildignore+=tags,.*.un~,*.pyc
" Ignore files
set wildignore=*.o,*~,*.pyc,*.swp
" Set to auto read when a file is changed from the outside
"set autoread
highlight MatchParen ctermbg=2

set t_Co=256

" Mappings
" Edit vimrc ,ev
nnoremap <silent> <Leader>ev :tabnew<CR>:e ~/.config/vim/vimrc.vim<CR>
nnoremap <silent> <Leader>et :tabnew<CR>:e ~/.tmux.conf<CR>
nnoremap <silent> <Leader>ea :tabnew<CR>:e ~/.config/alacritty/alacritty.yml<CR>

nnoremap <silent> <Leader>s :tabe<CR>:Ex<CR>
nnoremap <silent> <Leader>f :tabe %<CR>:Ex<CR>

nnoremap <silent> <Leader>b :bd<CR>

nnoremap <silent> <Leader>q :qa<CR>
nnoremap <silent> <Leader>w :w<CR>

" ctags
map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR>
map <Leader><C-\> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>

" These make it so going to the next match in a search will center the buffer
" on the line the match is found in
map N Nzz
map n nzz

" Diffmode mappings
nnoremap <expr> <C-J> &diff ? 'do]czz' : '<C-J>'
nnoremap <expr> <C-K> &diff ? 'do[czz' : '<C-K>'

" Auto commands
" Remove any trailing whitespace that is in the file
" autocmd BufRead,BufWrite * if ! &bin | silent! %s/\s\+$//ge | endif

" lets
let g:netrw_banner=0

" globals
setglobal pastetoggle=<F2>
setglobal infercase

"______________________________RESEARCH_____________________________"
set backspace=2
set enc=utf8
set nohidden

" add cwd to path? or clear path?
" nnoremap <silent <Leader>a :set path+=''<CR>

"au GUIEnter * simalt ~x
autocmd FileType c,cpp,cs,java,arduino setlocal commentstring=//\ %s
autocmd FileType desktop              setlocal commentstring=#\ %s
autocmd FileType sql                  setlocal commentstring=--\ %s
autocmd FileType xdefaults            setlocal commentstring=!%s
autocmd FileType git,gitcommit        setlocal foldmethod=syntax foldlevel=1

" Toggle hl off when entering insert mode ...
autocmd InsertEnter * :setlocal nohlsearch
" ... Toggle back on when leaving
autocmd InsertLeave * :setlocal hlsearch

autocmd FileType json set nocursorcolumn
"au! BufWritePost * Neomake

" Trim Whitespaces
function! TrimWhitespace()
    let l:save = winsaveview()
    %s/\\\@<!\s\+$//e
    call winrestview(l:save)
endfunction

nmap <leader>w :call TrimWhitespace()<CR>

" When opening a window put it right or below the current one
set splitright
set splitbelow
"______________________________ARCHIVE______________________________"
"if has("gui_running")
"   "set fullscreen
"   set transparency=10
"endif
"
"set lisp " enable lisp mode
"
" Show whitespace
"set list listchars=tab:»·,trail:·
"set lispwords+=type-case,define-type,module+,local,if
"
"Move a line of text using ALT+[jk]
"nmap <M-j> mz:m+<cr>`z
"nmap <M-k> mz:m-2<cr>`z
"vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
"vmap <M-k> :m'>-2<cr>`<my`>mzgv`yo`z
"
" Add known extensions for xyntax coloring
" au BufNewFile,BufRead *.ebs set filetype=vb
"
" set mouse=a " enable mouse support in console

