" # DD neovim configuration
"
" File: mappings.vim
" Author: Danilo Dellaquila
" Date: Fri, 07 Apr 2017 21:26:16 +0200
"
" This is file is part of the personal Vim configuration of
" Danilo Dellaquila.
"

" ## Key Reference Table
" :help key-notation to check more
"
"   <BS>           Backspace
"   <Tab>          Tab
"   <CR>           Enter
"   <Enter>        Enter
"   <Return>       Enter
"   <Esc>          Escape
"   <Space>        Space
"   <Up>           Up arrow
"   <Down>         Down arrow
"   <Left>         Left arrow
"   <Right>        Right arrow
"   <F1> - <F12>   Function keys 1 to 12
"   #1, #2..#9,#0  Function keys F1 to F9, F10
"   <Insert>       Insert
"   <Del>          Delete
"   <Home>         Home
"   <End>          End
"   <PageUp>       page-up
"   <PageDown>     page-down
"   <ALT>

" Map Leader key
let mapleader = ","

" Copy the current file path to register a
map <Leader>p :let @a=expand("%")<CR>
map <Leader>P :let @a=expand("%:h")<CR>

" Insert the current date
map <Leader>d :read !date --rfc-3339=date<CR>kJ$
map <Leader>D :read !date -R<CR>kJ

" Reformat text
map <Leader>f gq}
map <Leader>F gqG

" Save file even if I forgot to start vim using sudo
cmap w!! w !sudo tee % > /dev/null

" Use <C-Up>/<C-Down> to swap lines
map <C-Up> dd<Up>P
map <C-Down> ddp

" Line Indentation
map <Leader>i kJi<Return><ESC>j

" Recover from accidental Ctrl-U/Ctrl-W deletions,
" see http://vim.wikia.com/wiki/Recover_from_accidental_Ctrl-U
" it seems to not useful for me, gavin
"inoremap <C-U> <C-G>u<C-U>
"inoremap <C-W> <C-G>u<C-W>

" Select all and copy
map <Leader>a ggVG"+y

"Toggle max/restore current window
map <F12> :call ToggleMaxWin()<CR> 

"Switch between windows
inoremap <c-h> <C-\><C-N><C-w>h
inoremap <c-j> <C-\><C-N><C-w>j
inoremap <c-k> <C-\><C-N><C-w>k
inoremap <c-l> <C-\><C-N><C-w>l
"vim in terminal cannot use alt as it will open the termianl menu
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l


"Resize current window
nmap <C-Up> <C-W>+
nmap <C-Down> <C-W>-
nmap <C-Left> <C-W><
nmap <C-Right> <C-W>>

"using kk to escape insertmode
imap kk <Esc>

command! -complete=file -nargs=+ Shell call s:runshellcommand(<q-args>)
function! s:runshellcommand(cmdline)
  botright new
  setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nowrap
  call setline(1,a:cmdline)
  call setline(2,substitute(a:cmdline,'.','=','g'))
  execute 'silent $read !'.escape(a:cmdline,'%#')
  setlocal nomodifiable
  1
endfunction
map <F6> :up \| Shell python3 %<cr><c-w>

"F5 to run code, & is to use local variable
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "update"
    if &filetype == 'c'
        exec "!g++ % -o %<"
        exec "! ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "! ./%<"
    elseif &filetype == 'java' 
        exec "!javac %" 
        exec "!java %<"
    elseif &filetype == 'python'
        exec "!python3 %"
    elseif &filetype == 'sh'
        :!./%
    endif
endfunc

"buffer switch 
nmap <C-N> :bn<CR>
nmap <C-P> :bp<CR>
nmap <F3> :up \| b#<CR>
"close current buffer without close window
map <leader>q :b#<bar>sp<bar>b#<bar>bd<CR>


vmap <C-C> "+y
nmap <S-Insert> "+p
imap <S-Insert> <Esc>"+pa


" Classical Copy/Cut/Paste
"
" I do not use these mappings, but I leave them here in case
" you feel more comfortable with them.
"
""<Ctrl-X> -- cut (goto visual mode and cut)
"
"imap <C-X> <C-O>vgG
"vmap <C-X> "*x<Esc>i
"imap <S-Del> <C-O>vgG
"vmap <S-Del> "*x<Esc>i
"
""<Ctrl-C> -- copy (goto visual mode and copy)
"
"imap <C-C> <C-O>vgG
"vmap <C-C> "+y<Esc>i
"imap <C-Insert> <C-O>vgG
"vmap <C-Insert> "*y<Esc>i
"
""<Ctrl-V> -- paste
"
"nm \\paste\\ "=@*.'xy'<CR>gPFx"_2x:echo<CR>
"imap <C-V> x<Esc>\\paste\\"_s
"vmap <C-V> "-cx<Esc>\\paste\\"_x
"imap <S-Insert> x<Esc>\\paste\\"_s
"vmap <S-Insert> "-cx<Esc>\\paste\\"_x
"
""<Ctrl-A> -- copy all
"
"imap <C-A> <C-O>gg<C-O>gH<C-O>G<Esc>
"vmap <C-A> <Esc>gggH<C-O>G<Esc>i
