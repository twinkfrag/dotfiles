set guifont=Consolas:h14:cSHIFTJIS
set guifontwide=MS_Gothic:h14
set lines=40
set columns=120
set guioptions-=T
colorscheme hybrid
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=#222211 ctermbg=black
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=#111122 ctermbg=darkgray

" Kaoriya版GVIMの上書き対策
autocmd FileType text setlocal textwidth=0

