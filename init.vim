set encoding=utf-8
set nocompatible

let s:dein_base = '~/.cache/dein'
let s:dein_src = '~/.cache/dein/repos/github.com/Shougo/dein.vim'

execute 'set runtimepath+=' . s:dein_src

call dein#begin(s:dein_base)
call dein#add(s:dein_src)

" Shougo VimScripts
call dein#add('Shougo/deol.nvim')

"
call dein#add('neoclide/coc.nvim', {
            \ 'rev': 'release'
            \ })

call dein#add('itchyny/lightline.vim')
call dein#add('mattn/emmet-vim')
call dein#add('preservim/nerdtree')
call dein#add('vim-syntastic/syntastic')
call dein#add('OrangeT/vim-csharp', {
            \ 'on_ft': [ 'cs' ]
            \ })

" colorscheme
call dein#add('tomasr/molokai')

" Finish Dein initialization (required)
call dein#end()

if has('filetype')
  filetype indent plugin on
endif

if has('syntax')
  syntax on
endif
if dein#check_install()
 call dein#install()
endif


set number
set cursorline
set cursorcolumn

set autoindent
set cindent
set expandtab
set shiftwidth=4
set tabstop=4

set nobackup
set nowritebackup
set noswapfile

set t_Co=256
colorscheme molokai

set updatetime=300
set signcolumn=yes


let g:python3_host_prog = '/usr/bin/python3'


let mapleader = "\<Space>"
tnoremap <ESC> <C-\><C-n>
nnoremap <Leader>w :w<Cr>
nnoremap <Leader>q :q<Cr>
nnoremap <Leader>df :call deol#start(#{ split: 'floating'})<Cr>

nnoremap <Leader>n :NERDTreeFocus<Cr>


function! Deol()
    call deol#start(#{})
endfunction
command! -nargs=0 Deol :call Deol()

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 
            \ && exists('b:NERDTree') && b:NERDTree.isTabTree()
            \ | quit | endif


function! ShowDocument()
    if CocAction('hasProvider', 'hover')
        call CocActionAsync('doHover')
    else
        call feedkeys('K', 'in')
    endif
endfunction

nnoremap <silent> K :call ShowDocument()<Cr>

autocmd CursorHold * silent call CocActionAsync('highlight')
nnoremap <Leader>rn <Plug>(coc-rename)
nnoremap <Leader>gd <Plug>(coc-definition)
nnoremap <Leader>gr <Plug>(coc-references)

let g:syntastic_c_checkers = [ 'gcc', 'clangd' ]
let g:syntastic_cs_checkers = [ 'code_checker' ]



" 16進数変換
function! s:to_hex(value, ...)
    if a:0 > 0
        let shift_size = str2nr(a:1, 10)
    else
        let shift_size = 0
    endif

    if strlen(a:value) > 1
        if type(a:value) != 1
            throw ''
        endif

        if a:value[0] == '0'
            if a:value[1] == 'x'
                " 16進数
                let value = str2nr(a:value, 16)
            elseif a:value[1] == 'b'
                " 2進数
                let value = str2nr(a:value, 2)
            else
                " 8進数
                let value = str2nr(a:value, 8)
            endif
        else
            " 10進数
            let value = str2nr(a:value, 10)
        endif
    else
        let value = str2nr(a:value, 10)
    endif

    let result = printf('0x%08x', float2nr(value * pow(2, shift_size)))

    let pos    = getpos('.')
    let column = pos[2]
    let row    = pos[1]

    " 文字列の挿入
    execute "normal! i" .. result .. "\<ESC>"
endfunction


" コマンド定義
command! -nargs=+ ToHex call s:to_hex(<f-args>)
