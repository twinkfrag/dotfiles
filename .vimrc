if filereadable(expand('~/.vim-tiny.vimrc'))
  source ~/.vim-tiny.vimrc
endif

set noundofile
if has('linux')
  if isdirectory('/var/tmp/vim')
    set directory=/var/tmp/vim
    set backupdir=/var/tmp/vim
  else
    call mkdir('/tmp/vim', 'p')
    set directory=/tmp/vim
    set backupdir=/tmp/vim
  endif
elseif has('windows')
  call mkdir('%LocalAppData%/vim', 'p')
  set directory=%LocalAppData%/vim
  set backupdir=%LocalAppData%/vim
endif


" NeoBundle is obsolete

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
set textwidth=0

"set list
"set listchars=tab:>-,trail:-,nbsp:%,extends:»,precedes:«
"hi NonText    ctermbg=black ctermfg=17
"hi SpecialKey ctermbg=black ctermfg=17
"" SpecialKey, needed for cursorline
"autocmd ColorScheme * htmlhighlightskip link MySpecialKey SpecialKey
"autocmd VimEnter,WinEnter * let w:m_sp = matchadd("MySpecialKey", '\(\t\| \+$\)')

"colorscheme hybrid

" vim-quickrun settings
let g:quickrun_config = {
\  "cs"  : {
\    "command"  : "csc"
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

