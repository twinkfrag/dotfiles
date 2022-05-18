if filereadable(expand('~/.vim-tiny.vimrc'))
  source ~/.vim-tiny.vimrc
endif

set noundofile
if has('windows')
  if has('linux')
    call mkdir('/var/tmp/vim', 'p')
    set directory=/var/tmp/vim
    set backupdir=/var/tmp/vim
  else
    call mkdir('%LocalAppData%/vim', 'p')
    set directory=%LocalAppData%/vim
    set backupdir=%LocalAppData%/vim
  endif
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

set list
set listchars=tab:>-,trail:-,nbsp:%

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

