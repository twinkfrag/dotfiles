" file
set nf="" "don't octet"
set fileencoding=utf-8

" visual
set number
set cursorline
set virtualedit=onemore
set smartindent
set visualbell
set showmatch
set laststatus=2
set statusline=%F%m%r%h%w\%=[%{&ff}]\ [%Y]\ [%{&fenc}]\ [POS=%03v,%03l/%03L]
syntax enable

" search
set hlsearch
set ignorecase
set smartcase
set incsearch
set wrapscan
nmap <Esc><Esc> :nohlsearch<CR><Esc>

" UI
"set mouse=a
"set ttymouse=xterm2
set belloff=all
set autochdir

augroup vimrc-auto-mkdir
  autocmd!
  autocmd BufWritePre * call s:auto_mkdir(expand('<afile>:p:h'), v:cmdbang)
  
  function! s:auto_mkdir(dir, force)
    if !isdirectory(a:dir) && (a:force || input(printf('"%s" does not exist. Create? [y/N]', a:dir)) =~? '^y\%[es]$')
      call mkdir(iconv(a:dir, &encoding, &termencoding), 'p')
    endif
  endfunction
augroup END
