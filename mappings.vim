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
inoremap <C-U> <C-G>u<C-U>
inoremap <C-W> <C-G>u<C-W>

" Select all and copy
map <Leader>a ggVG"+y

"Toggle max/restore current window
map <F12> :call ToggleMaxWin()<CR> 

"Switch between windows
nmap <C-K> <C-W><Up>
nmap <C-J> <C-W><Down>
nmap <C-H> <C-W><Left>
nmap <C-L> <C-W><Right>

"Resize current window
nmap <C-Up> <C-W>+
nmap <C-Down> <C-W>-
nmap <C-Left> <C-W><
nmap <C-Right> <C-W>>

"F5 to run code, & is to use local variable
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
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
        "call SaveAndExecutePython()
    elseif &filetype == 'sh'
        :!./%
    endif
endfunc

function! SaveAndExecutePython()
    " SOURCE [reusable window]: https://github.com/fatih/vim-go/blob/master/autoload/go/ui.vim

    " save and reload the current file
    silent execute "update | edit"

    " get file path of current file
    let s:current_buffer_file_path = expand("%")

    let s:output_buffer_name = "Python"
    let s:output_buffer_filetype = "output"

    " reuse existing buffer window if it exists otherwise create a new one
    if !exists("s:buf_nr") || !bufexists(s:buf_nr)
        silent execute 'botright new ' . s:output_buffer_name
        let s:buf_nr = bufnr('%')
    elseif bufwinnr(s:buf_nr) == -1
        silent execute 'botright new'
        silent execute s:buf_nr . 'buffer'
    elseif bufwinnr(s:buf_nr) != bufwinnr('%')
        silent execute bufwinnr(s:buf_nr) . 'wincmd w'
    endif

    silent execute "setlocal filetype=" . s:output_buffer_filetype
    setlocal bufhidden=delete
    setlocal buftype=nofile
    setlocal noswapfile
    setlocal nobuflisted
    setlocal winfixheight
    setlocal cursorline " make it easy to distinguish
    setlocal nonumber
    setlocal norelativenumber
    setlocal showbreak=""

    " clear the buffer
    setlocal noreadonly
    setlocal modifiable
    %delete _

    " add the console output
    silent execute ".!python " . shellescape(s:current_buffer_file_path, 1)

    " resize window to content length
    " Note: This is annoying because if you print a lot of lines then your code buffer is forced to a height of one line every time you run this function.
    "       However without this line the buffer starts off as a default size and if you resize the buffer then it keeps that custom size after repeated runs of this function.
    "       But if you close the output buffer then it returns to using the default size when its recreated
    "execute 'resize' . line('$')

    " make the buffer non modifiable
    setlocal readonly
    setlocal nomodifiable
endfunction

"buffer switch 
nmap <C-N> :bn<CR>
nmap <C-P> :bp<CR>
nmap <F3> :b#<CR>

"Nvim Terminal key map
tnoremap <Esc> <C-\><C-N>

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
