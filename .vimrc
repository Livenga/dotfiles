if 0 | endif

if &compatible
  set nocompatible
endif

set runtimepath+=~/.vim/bundle/neobundle.vim/
call neobundle#begin(expand('~/.vim/bundle/'))

NeoBundleFetch 'Shougo/neobundle.vim'
"NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neocomplete'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/vimproc.vim'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'Shougo/Vinarise'

"NeoBundle 'emmetio/emmet'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'vim-scripts/vimball'
NeoBundle 'vim-scripts/manpageview'
NeoBundle 'vim-syntastic/syntastic'

NeoBundle 'udalov/kotlin-vim'
NeoBundle 'fatih/vim-go'
NeoBundle 'derekwyatt/vim-scala'

NeoBundle 'leafgarland/typescript-vim'

NeoBundle 'tomasr/molokai'
NeoBundle 'vim-scripts/Wombat'
NeoBundle 'vim-scripts/pyte'

"NeoBundle 'artur-shaik/vim-javacomplete2'

NeoBundleLazy  'vim-scripts/javacomplete', {
      \  'autoload': {'filetype': ['java']}
      \}


call neobundle#end()

filetype plugin indent on

NeoBundleCheck

set number
set backspace=indent,eol,start
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
syntax on
colorscheme molokai
"colorscheme pyte
set t_Co=256

if has('mouse')
  set mouse=a
endif

" Keybind
nnoremap <F2> : VimFiler<CR>
nnoremap <F3> : VimShell<CR>
nnoremap <C-h><C-h> : foldclose<Cr>
nnoremap <C-l><C-l> : foldopen<Cr>
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


" NeoComplete
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#sources#dictionary#dictionaries = {
      \ 'default' : '',
      \ 'vimshell' : $HOME.'/.vimshell_hist',
      \ 'scheme' : $HOME.'/.gosh_completions',
      \ 'javascript' : $HOME . '/.vim/dict/javascript.dict'
      \ }
if !exists('g:neocomplete#keyword_patterns')
  let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? "\<C-y>" : "\<CR>"
endfunction
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"

autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType java setlocal omnifunc=javacomplete#Complete
autocmd FileType java setlocal completefunc=javacomplete#CompleteParamsInfo
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType cs setlocal omnifunc=OmniSharp#Complete

if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.cs = '[^.]\.\%(\u\{2,}])\?'
let g:neocomplete#sources#omni#input_patterns.cs = '.*[^=\);]'
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
let g:neocomplete#sources#omni#input_patterns.go = '\h\w\.\w*'

if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
"let g:neocomplete#force_omni_input_patterns.java = '\k\.\k*'
"let g:neocomplete#force_omni_input_patterns.java = '\%(\h\w*\|)\)\.\w*'

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
