"set nobackup
"set noundofile

if has('windows')
  set directory=%LocalAppData%/vim
  set undodir=%LocalAppData%/vim
  set backupdir=%LocalAppData%/vim
endif

set nf="" "おれは、8進数をやめるぞー！
set fileencoding=utf-8
set fileformat=dos
set statusline=%F%m%r%h%w\%=[%{&ff}]\ [%Y]\ [%{&fenc}]\ [POS=%03v]\ [LEN=%L]

set nocompatible
set autochdir

if has('vim_starting')
  set runtimepath+=$VIM/vimfiles/vim/bundle/neobundle.vim
  call neobundle#begin(expand('$VIM/vimfiles/vim/bundle'))

  NeoBundleFetch 'Shougo/neobundle.vim'

  NeoBundle 'Shougo/neocomplete.vim'
  NeoBundle 'Shougo/neosnippet.vim'
  NeoBundle 'Shougo/neosnippet-snippets'

  NeoBundle 'Shougo/unite.vim'
  NeoBundle 'Shougo/vimshell.vim'

  NeoBundle 'thinca/vim-quickrun'
  NeoBundle 'scrooloose/nerdtree'
  NeoBundle 'Townk/vim-autoclose'
  NeoBundle 'kannokanno/previm'
  NeoBundle 'tyru/open-browser.vim'

  NeoBundle 'OrangeT/vim-csharp'
  
  NeoBundle 'nathanaelkane/vim-indent-guides'
  NeoBundle 'w0ng/vim-hybrid'

  NeoBundle 'taku25/vim-visualstudio'
  NeoBundle 'sophacles/vim-processing'
  call neobundle#end()
  NeoBundleCheck
endif
filetype plugin indent on

let g:neocomplete#enable_at_startup = 1
" NeoSnippet Settings
imap <C-k>  <Plug>(neosnippet_expand_or_jump)
smap <C-k>  <Plug>(neosnippet_expand_or_jump)
xmap <C-k>  <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
\ "\<Plug>(neosnippet_expand_or_jump)"
\: "\<TAB>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif

" NeoSnippet Settings End

" NeoComplete Settings
"Note: This option must set it in .vimrc(_vimrc).  NOT IN .gvimrc(_gvimrc)!
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define dictionary.
let g:neocomplete#sources#dictionary#dictionaries = {
  \ 'default' : '',
  \ 'vimshell' : $HOME.'/.vimshell_hist',
  \ 'scheme' : $HOME.'/.gosh_completions'
    \ }

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplete#enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplete#enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'

" NeoComplete Settings End

" vim-indent-guides
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_start_level=1
let g:indent_guides_auto_colors=1
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#222211 ctermbg=black
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#111122 ctermbg=darkgray
let g:indent_guides_guide_size = 1
" vim-indent-guides End

set noexpandtab
set tabstop=4
set shiftwidth=4
set autoindent
set smartindent
set textwidth=0

" Kaoriya版GVIMの上書き対策
autocmd FileType text setlocal textwidth=0

set list
set listchars=tab:>-,trail:-,nbsp:%

colorscheme hybrid

set number
set relativenumber

" vim-quickrun settings
let g:quickrun_config = {
\  "cs"  : {
\    "command"  : "csc"
\  },
\  "c"    : {
\    "command"  : "cl"
\  },
\  "cpp"  : {
\    "command"  : "cl",
\    "cmdopt"  : "/EHsc"
\  },
\  "java/utf8"  : {
\    "command"  : "java",
\    "exec"    : ['javac -J-Dfile.encoding=UTF8 %o %s', '%c -Dfile.encoding=UTF8 %s:t:r %a']
\  },
\  "java"  : {
\    "command"  : "java",
\    "cmdopt"  : "-encoding utf8",
\    "exec"    : ["javac %o %s", "%c %s:t:r %a"],
\    "hook/output_encode/enable"  : 1,
\    "hook/output_encode/encoding"  : "shift-jis",
\  },
\  "java/cp932"  : {
\    "cmdopt"  : "-encoding cp932",
\    "command"  : "java",
\    "exec"    : ["javac %o %s", "%c %s:t:r %a"],
\    "hook/output_encode/enable"  : 1,
\    "hook/output_encode/encoding"  : "shift-jis",
\  },
\  "tex"  : {
\    "command"  : "latexmk",
\    "cmdopt"  : "-pv",
\    "outputter" : "error",
\  },
\  "_"    : {
\    "command"  : "powershell"
\  }
\}

