if 0 | endif

if &compatible
  set nocompatible
endif

set runtimepath+=~/.vim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'

NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/vimproc'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/Vinarise'

NeoBundle 'mattn/emmet-vim'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'vim-scripts/vimball'
NeoBundle 'vim-scripts/manpageviewer'
"NeoBundle 'vim-syntastic/syntastic'

NeoBundle 'scrooloose/nerdtree'
NeoBundle 'udalov/kotlin-vim'
NeoBundle 'fatih/vim-go'
NeoBundle 'derekwyatt/vim-scala'

NeoBundle 'leafgarland/typescript-vim'

NeoBundle 'tomasr/molokai'
NeoBundle 'vim-scripts/Wombat'
NeoBundle 'vim-scripts/pyte'

"NeoBundle 'OmniSharp/omnisharp-vim'


call neobundle#end()

filetype plugin indent on
NeoBundleCheck

set number
"set backspace=indent,eol,start
set cursorline
set cursorcolumn
set cmdheight=2
set laststatus=2

set noswapfile
set nobackup

set autoindent
set cindent
set expandtab
set tabstop=2
set shiftwidth=2
set foldmethod=marker
set foldmarker=```,'''

set t_Co=256

if has('mouse')
  set mouse=a
endif
syntax on
colorscheme molokai
"colorscheme pyte


" Keybind
nnoremap <F2> :VimFiler<CR>
nnoremap <F3> :VimShell<CR>
nnoremap <C-h><C-h> :foldclose<Cr>
nnoremap <C-l><C-l> :foldopen<Cr>
nnoremap <C-n> :NERDTree<Cr>
"nnoremap <C-h> : foldclose<Cr>
"nnoremap <C-l> : foldopen<Cr>

autocmd! BufRead,BufNewFile *ts set filetype=typescript
autocmd! FileType tex  set foldmarker=```,'''
autocmd! FileType go   set foldmarker=```,'''
autocmd! FileType java set foldmarker=```,'''


" GoLang
let g:go_highlight_functions = 1
let g:go_highlight_methods = 1
let g:go_highlight_structs = 1

""" vimball
let g:vimball_home = "/home/live/.vim/vimball"
"""
let g:manpageview_winopen="vsplit="


" VimFiler
let g:vimfiler_as_default_explorer  = 1
let g:vimfiler_safe_mode_by_default = 0


" OmniSharp
let g:syntastic_cs_checkers = ['syntax', 'semantic', 'issues']
let g:OmniSharp_start_server = 1


"
"autocmd QuickFixCmdPost [^1]* nested cwindow
"autocmd QuickFixCmdPost    1* nested lwindow
let g:typescript_compiler_binary  = 'tsc'
"let g:typescript_compiler_options = '--target ES2015'
let g:typescript_compiler_options = '--removeComments'

" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplcache.
let g:neocomplcache_enable_at_startup = 1
" Use smartcase.
let g:neocomplcache_enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplcache_min_syntax_length = 3
let g:neocomplcache_lock_buffer_name_pattern = '\*ku\*'

" Enable heavy features.
" Use camel case completion.
"let g:neocomplcache_enable_camel_case_completion = 1
" Use underbar completion.
"let g:neocomplcache_enable_underbar_completion = 1

" Define dictionary.
let g:neocomplcache_dictionary_filetype_lists = {
      \ 'default' : '',
      \ 'vimshell' : $HOME.'/.vimshell_hist',
      \ 'scheme' : $HOME.'/.gosh_completions'
      \ }

" Define keyword.
if !exists('g:neocomplcache_keyword_patterns')
  let g:neocomplcache_keyword_patterns = {}
endif
let g:neocomplcache_keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplcache#smart_close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplcache#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplcache#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplcache#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplcache#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplcache#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplcache#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplcache_enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplcache_enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplcache_enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplcache_enable_auto_select = 1
"let g:neocomplcache_disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplcache_force_omni_patterns')
  let g:neocomplcache_force_omni_patterns = {}
endif
let g:neocomplcache_force_omni_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
let g:neocomplcache_force_omni_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplcache_force_omni_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplcache_force_omni_patterns.perl = '\h\w*->\h\w*\|\h\w*::'



let s:is_debug = 1

function! s:strremoval(s_src, s_split)
  return join(split(a:s_src, a:s_split), '')
endfunction

function! s:shift_left(value, shift_size)
  if (type(a:value) != v:t_number)
        \ || (type(a:shift_size) != v:t_number)
    throw '引数に整数型以外が入力されています.'
  endif

  return a:value * float2nr(pow(2, a:shift_size))
endfunction

function! s:shift_right(value, shift_size)
  if (type(a:value) != v:t_number)
        \ || (type(a:shift_size) != v:t_number)
    throw '引数に整数型以外が入力されています.'
  endif

  let filter = s:shift_left(1, a:shift_size) - 1
  return and(a:value, invert(filter)) / (filter + 1)
endfunction

function! s:value_to_hex(...)
  if a:0 < 1
    echo '引数を指定してください.'
    return
  endif

  " 基数の取得
  if a:1[0] == '0'
    if a:1[1] == 'b'
      let base = 2
    elseif a:1[1] == 'x'
      let base = 16
    else
      let base = 8
    endif
  else 
    let base = 10
  endif

  let n_value = str2nr(a:1, base)

  if(a:0 == 1)
    let n_shift = 0
  else
    " シフトサイズの基数は必ず 10
    let n_shift = str2nr(a:2, 10)
  endif

  " 16進数の大, 小文字指定
  if a:0 > 2 &&
        \ ((str2nr(a:3, 10) == 1) || (a:3 ==# 'true'))
    let format = '0x%08X'
  else
    let format = '0x%08x'
  endif

  try
    let s_hex = printf(format, s:shift_left(n_value, n_shift))

    if s:is_debug == 1
      echo s_hex
    endif

    let pos = getcurpos()
    execute ':normal i' . s_hex
  catch /.*/
    echo v:exception
  endtry
endfunction

command! -nargs=+ ValueToHex call s:value_to_hex(<f-args>)

if s:is_debug == 1
  function! s:getCursorPosition()
    echo getcurpos()
  endfunction

  command! -nargs=0 GetCursorPosition call s:getCursorPosition()
  nnoremap <C-c> :GetCursorPosition<Cr>
endif


autocmd! bufenter * 
      \ if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | 
      \ q |
      \ endif
