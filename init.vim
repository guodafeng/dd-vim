" # DD neovim configuration
"
" File: init.vim
" Author: Danilo Dellaquila
" Date: Fri, 07 Apr 2017 18:02:53 +0200
"
" This is file is part of the personal neovim configuration of
" Danilo Dellaquila.
"

" ## Generic Settings
"
"
"in windows it is source this vim file in ~/AppData/Local/nvim/init.vim
"
" Set vim directory path
let $VIMPATH=$HOME."/.config/nvim/dd-vim"

" set different cursor in insert/normalmode
let &t_SI = "\<esc>[5 q"
let &t_SR = "\<esc>[5 q"
let &t_EI = "\<esc>[2 q"

" set file coding to display chinese
set encoding=utf-8
" used for chinese encoding when need
set fileencodings=utf-8,iso-8859-1,utf-16le,gucs-bom,bk,big5,gb18030,utf-16,latin1
"set fileencodings=utf-8

" Disable backup
set nobackup

" Do not automatically load files changed outside of Vim
set noautoread

" Enable autowrite
"set autowriteall

" Set some search options
set noincsearch
set ignorecase
set smartcase
" Map <C-L> to clear highlight
nnoremap <silent> <C-L> :nohlsearch<CR><C-L>

" Increase history
if &history < 1000
  set history=1000
endif

" Don't consider octal numbers that have leading zeros for padding,
" so that such numbers are incremented and decremented as expected.
set nrformats-=octal

" ## Vim UI
"
" Terminator colors
"set termguicolors

" Line numbers
set number

" Set statusline, always show it with ruler
set statusline=%F%m%r%h%w\ [%{&ff}]\ [%Y]\ [ASCII=\%03.3b\ HEX=\%02.2B]\ [POS=%04l,%04v\ %p%%\ %L]
set laststatus=2
set ruler

" Minimal number of screen lines/column to keep
if !&scrolloff
  set scrolloff=1
endif
if !&sidescrolloff
  set sidescrolloff=5
endif
set display+=lastline

" Background
set background=dark

" Color Scheme

" Enable true-color in a terminal emulator that DOES support 24-bit color,
" see https://github.com/joshdick/onedark.vim#installation
if (has("termguicolors"))
    set termguicolors
endif
" ... keep it disable for Terminator
"if ! empty("g:$TERMINATOR_UUID")
    "set notermguicolors
"endif
colorscheme desert

" ## Programming and Formatting
"
" Set maximum width of text line
set textwidth=72

" Automatic Indentation
" set smartindent " remove this line as it caused comment indent problem
  set nosmartindent
  set autoindent

" Tabs settings
"set noexpandtab (better for Golang code, this is the default in neovim)
set expandtab
set tabstop=4
set smarttab
set shiftwidth=4
set shiftround

" Set folding method and leave all folds open
set fdm=indent
set foldlevel=99

" Syntax Highlighting
if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

" ## Key Mappings
"
source $VIMPATH/mappings.vim

" Time out on :mappings and key codes
set ttimeout
set ttimeoutlen=100

" ## Plugins
"
source $VIMPATH/plugins.vim

" ## File Types
"
" enable filetype detection:
filetype on
filetype plugin on
filetype indent on " file type based indentation

" Set filetype for known extesions
augroup filetypedetect
autocmd BufNewFile,BufRead *.ledger set filetype=ledger
autocmd BufNewFile,BufRead *.adoc set filetype=asciidoc
augroup END

" Set indentation
autocmd FileType yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2
autocmd Filetype javascript setlocal tabstop=2 softtabstop=2 shiftwidth=2

"python env required by YCM ....
"let g:python3_host_prog='/usr/bin/python3'
let g:python3_host_prog='C:\Users\yunfeng\AppData\Local\Programs\Python\Python36-32\python.exe'
let g:python_host_prog='C:\Users\yunfeng\AppData\Local\Programs\Python\Python36-32\python.exe'
let g:ycm_global_ycm_extra_conf = '/home/yunfeng/.config/nvim/plugged/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py'

"C++ build
:set makeprg=g++\ -std=c++14\ %

"font size adjust key mapping
let s:fontsize = 12
function! AdjustFontSize(amount)
  let s:fontsize = s:fontsize+a:amount
  :execute "GuiFont! Consolas:h" . s:fontsize
endfunction
" In normal mode, pressing numpad's+ increases the font
noremap <kPlus> :call AdjustFontSize(1)<CR>
noremap <kMinus> :call AdjustFontSize(-1)<CR>

" In insert mode, pressing ctrl + numpad's+ increases the font
inoremap <C-kPlus> <Esc>:call AdjustFontSize(1)<CR>a
inoremap <C-kMinus> <Esc>:call AdjustFontSize(-1)<CR>a

source $VIMPATH/maxwindow.vim
