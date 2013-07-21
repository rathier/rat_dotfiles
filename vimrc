" File: .vimrc von Rainer Thierfelder

" vundle start " {{{
filetype off
set runtimepath+=~/.vim/bundle/vundle/
call vundle#rc()
" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

Bundle 'tpope/vim-git'
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-powerline'
Bundle 'scrooloose/nerdtree'
Bundle 'acustodioo/vim-tmux'
Bundle 'altercation/vim-colors-solarized'
Bundle 'vim-scripts/Lucius'
Bundle 'MarcWeber/vim-addon-mw-utils'
Bundle 'tomtom/tlib_vim.git'
Bundle 'snipmate-snippets'
Bundle 'garbas/vim-snipmate'
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
set shiftwidth=2
set tabstop=8
set softtabstop=2
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
set background=light
let g:Powerline_symbols='unicode'
let g:lucius_style='light'
set background=light

if has("syntax")
  syntax on
  colorscheme lucius
endif

if has("gui_running")
    set guifont="Courier 10 Pitch 10"
"    colorscheme solarized
endif
" }}}

source $VIMRUNTIME/ftplugin/man.vim

" explorer benutzt ab vim7 netrw
let g:netrw_altv = 1

" fuer twiki.vim "{{{
let g:Twiki_FoldAtHeadings=1
let g:Twiki_Functions=1
let g:Twiki_Mapings=1
let g:Twiki_SourceHTMLSyntax=0
" end twiki.vim " }}}


"eigene Highlightdefinitionen
"alle Tabs als ERROR markieren:
match errorMsg /[\t]/
"gueltige IPs als TODO markieren:
"match todo /\(\(25[0-5]\|2[0-4][0-9]\|[01]\?[0-9][0-9]\?\)\.\)\{3\}\(25[0-5]\|2[0-4][0-9]\|[01]\?[0-9][0-9]\?\)/
"ungueltige IPs als ERROR markieren:
match errorMsg /\(2[5][6-9]\|2[6-9][0-9]\|[3-9][0-9][0-9]\)[.]
               \[0-9]\{1,3\}[.][0-9]\{1,3\}[.][0-9]\{1,3\}\|
               \[0-9]\{1,3\}[.]\(2[5][6-9]\|2[6-9][0-9]\|
               \[3-9][0-9][0-9]\)[.][0-9]\{1,3\}[.][0-9]
               \\{1,3\}\|[0-9]\{1,3\}[.][0-9]\{1,3\}[.]\(2[5]
               \[6-9]\|2[6-9][0-9]|[3-9][0-9][0-9]\)[.][0-9]\{1,3\}
               \\|[0-9]\{1,3\}[.][0-9]\{1,3\}[.][0-9]\{1,3\}[.]
               \\(2[5][6-9]\|2[6-9][0-9]\|[3-9][0-9][0-9]\)/
" IP-Match-Test
" gueltig:
" 253.234.126.254
" 53.72.140.188
" 255.255.255.255
" 53.72.188.240
" ungueltig:
" 265.256.255.255
" 299.299.299.300
" 192.-168.234.24


"abkuerzungen {{{
iab dts <C-R>=strftime("%F")<CR>
"iab lcts <C-R>=strftime("%a %b %d %T %Z %Y")<CR>
iab lcts <C-R>=strftime("%c %Z")<CR>
" }}}
