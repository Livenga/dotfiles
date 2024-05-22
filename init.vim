set encoding=utf-8
set nocompatible

let s:dein_base = '~/.cache/dein'
let s:dein_src = '~/.cache/dein/repos/github.com/Shougo/dein.vim'

execute 'set runtimepath+=' . s:dein_src

call dein#begin(s:dein_base)
call dein#add(s:dein_src)

" Your plugins go here:
"call dein#add('Shougo/neosnippet.vim')
"call dein#add('Shougo/neosnippet-snippets')

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
