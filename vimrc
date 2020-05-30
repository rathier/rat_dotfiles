" File: .vimrc von Rainer Thierfelder

" vundle start " {{{
filetype off
set runtimepath+=~/.vim/bundle/Vundle.vim/
call vundle#rc()
" let Vundle manage Vundle
" required!
Bundle 'VundleVim/Vundle.vim'

Bundle 'tpope/vim-git'
Bundle 'tpope/vim-fugitive'
" Bundle 'scrooloose/nerdtree'
Bundle 'tmux-plugins/vim-tmux'
Bundle 'altercation/vim-colors-solarized'
Bundle 'vim-scripts/Lucius'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim'
Bundle 'honza/vim-snippets'
Bundle 'garbas/vim-snipmate'
Bundle 'Shougo/unite.vim'
Bundle 'vim-airline/vim-airline'
Bundle 'vim-airline/vim-airline-themes'
Bundle 'tpope/vim-sleuth'
Bundle 'tpope/vim-surround'
Bundle 'scrooloose/syntastic'
Bundle 'wimstefan/Lightning'
Bundle 'vimwiki/vimwiki'
Bundle 'Lokaltog/vim-easymotion'
"Bundle 'dogrover/vim-pentadactyl'
"Bundle 'SirVer/ultisnips'

" non github repos
"Bundle 'git://git.wincent.com/command-t.git'
" ...

filetype plugin indent on     " required!

" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles

" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..
"vundle end " }}}

" settings {{{
set hlsearch      " gefundene teffer markieren
set ruler         " cursorposition anzeigen
set showcmd       " incopleted command will be displayed
set showmode      " modus in Statuszeile anzeigen
set incsearch     " show matches on the fly
set nocompatible  " nicht kompatibel zum vi
set number        " Zeilennummerierung einschalten
set cursorline    " aktuelle Zeile hervorheben
set t_Co=256      " 256 colors terminal
set shiftwidth=4
set tabstop=8
set softtabstop=4
set expandtab
set mouse=""
set modeline
set modelines=4
set wildmode=list:longest,list:full
set wildmenu
"UTF-Codes: http://en.wikipedia.org/wiki/Unicode_symbols
"http://en.wikipedia.org/wiki/Unicode_Geometric_Shapes
"▷ u35b7
"http://en.wikipedia.org/wiki/Dingbat
"➟ u279f
"✄ u2704
"✧ u2727
"⤦ u2926
set listchars=eol:¬,tab:>-,trail:☠,extends:>,precedes:<
set list
set encoding=utf-8
" statuszeile
" von http://www.derekwyatt.org/vim/the-vimrc-file/better-settings
"set stl=%f\ %m\ %r\ Line:\ %l/%L[%p%%]\ Col:\ %c\ Buf:\ #%n\ [%b][0x%B]
"set statusline=%F%m%r%h%w\ [fileformat=%{&ff}]\ [ASCII=\%03.3b]\ [HEX=\%02.2B]\ [POS=%l,%v]\ [%p%%]\ [LEN=%L]\ [BUF=%n]
" ^ macht jetzt vim-powerline
set laststatus=2
set foldenable
set foldmethod=marker
let g:lucius_style='dark'
set background=dark
set relativenumber

if has("syntax")
  syntax on
  colorscheme lucius
endif

if has("gui_running")
"    set guifont="Courier 10 Pitch 10"
    set guifont=Inconsolata\ 10
    set guioptions-=m
    set guioptions-=b
    set guioptions-=T
    set guioptions-=l
    set guioptions-=L
    set guioptions-=r
    set guioptions-=R
    set guioptions+=c
endif
" }}}

if exists("&colorcolumn")
  set colorcolumn=80
endif

if has("autocmd")
  autocmd BufWritePost .vimrc nested source $MYVIMRC
  autocmd BufWritePost rat_dotfiles/vimrc nested source $MYVIMRC
endif
"
"
" unite-config {{{
call unite#filters#matcher_default#use(['matcher_fuzzy'])
" /unite-config }}}
" airline-configuration {{{
if !exists('g:airline_symbols')
  let g:airline_symbols = {}
endif
let g:airline_left_sep = '▶'
let g:airline_right_sep = '◀'
let g:airline_theme = 'lucius'
" let g:airline_paste_symbol = 'Þ'
let g:airline_symbols.paste = 'Þ'
" /airline-configuration }}}
" mappings {{{
let mapleader=","
nmap <leader>v :tabnew $MYVIMRC<CR>
nmap <leader>sv :source $MYVIMRC<CR>
nmap <leader>p :set paste!<CR>
" nmap <F9> :call RATPingHost("<cword>")<CR>
" unite-mappings {{{2
nnoremap <leader>b :<C-u>Unite buffer<CR>
nnoremap <leader>f :<C-u>Unite -start-insert file<CR>
nnoremap <leader>r :<C-u>Unite -start-insert file_rec<CR>
" /unite-mappings }}}2
" deactivate arrow-keys in insert mode
no <down> <Nop>
no <left> <Nop>
no <right> <Nop>
no <up> <Nop>
ino <down> <Nop>
ino <left> <Nop>
ino <right> <Nop>
ino <up> <Nop>
" /mappings }}}
" snipmate-config {{{
let g:snips_author="Rainer Thierfelder"
let g:snips_email="r.thierfelder@science-computing.de"
let g:snips_github=""
" /snipmate-config }}}

" fuer latex-suite, wegen grep-Problemen:
set grepprg=grep\ -nH\ $*

"fuer spellchecking
"set spell
"set spelllang=de
"highlight SpellErrors ctermfg=Red guifg=Yellow cterm=underline

" zum testen:
" set thesaurus="home/thierf/tmp/thesaurus.txt"

" explorer benutzt ab vim7 netrw
let g:netrw_altv = 1

" fuer twiki.vim "{{{
let g:Twiki_FoldAtHeadings=1
let g:Twiki_Functions=1
let g:Twiki_Mapings=1
let g:Twiki_SourceHTMLSyntax=0
" end twiki.vim " }}}


"eigene Highlightdefinitionen

"abkuerzungen {{{
iab dts <C-R>=strftime("%F")<CR>
iab lcts <C-R>=strftime("%c %Z")<CR>
" }}}
