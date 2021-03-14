syntax enable               " Enables syntax highlighing

set noswapfile              " Disable swap files
set nowrap                  " Display long lines as just one line
set encoding=utf-8          " The encoding displayed
set pumheight=10            " Makes popup menu smaller
set fileencoding=utf-8      " The encoding written to file
set iskeyword+=-          	" treat dash separated words as a word text object
set t_Co=256                " Support 256 colors
set conceallevel=0          " So that I can see `` in markdown files
set tabstop=4               " Insert 4 spaces for a tab
set shiftwidth=4            " Change the number of space characters inserted for indentation
set smarttab                " Makes tabbing smarter
set expandtab               " Converts tabs to spaces
set smartindent             " Makes indenting smart
set autoindent              " Auto indent
set number                  " Line numbers
set relativenumber          " Line numbers relative to current line
set background=dark         " Darker background
set showtabline=2           " Always show tab line
set noshowmode              " Hide -- INSERT -- and all
set timeoutlen=500          " By default timeoutlen is 1000 ms
set clipboard=unnamedplus   " Copy paste between vim and everything else
set autochdir               " Stay in directory of edited file
set incsearch               " Search while typing
set hlsearch                " Highlight search
set scrolloff=2             " Always keep 2 lines above and below cursor
set mouse=r

let mapleader = " "

" Escape is too far
inoremap kj <Esc>
" vnoremap kj <Esc>

" Easily edit and source vimrc
nnoremap <leader>e :vsplit $MYVIMRC<cr>
nnoremap <leader>s :source $MYVIMRC<cr>

" Disable arrow keys
noremap <Up> <Nop>
noremap <Down> <Nop>
noremap <Left> <Nop>
noremap <Right> <Nop>

" Move lines up and down easily
nnoremap <C-j> :m .+1<CR>==
nnoremap <C-k> :m .-2<CR>==
inoremap <C-j> <Esc>:m .+1<CR>==gi
inoremap <C-k> <Esc>:m .-2<CR>==gi
vnoremap <C-j> :m '>+1<CR>gv=gv
vnoremap <C-k> :m '<-2<CR>gv=gv

" Vue basic empty template
" function! s:vue_template()
"     normal i<template><CR><CR></template><CR><CR>
"     normal <script><CR><CR></script><CR><CR>
"     normal <style lang="scss" module><CR><CR></style><CR><CR>
" endfunction
" noremap po call s:vue_template()

" Change cursor in insert mode
if has("autocmd")
   au VimEnter,InsertLeave * silent execute '!echo -ne "\e[2 q"' | redraw!
   au InsertEnter,InsertChange *
     \ if v:insertmode == 'i' | 
     \   silent execute '!echo -ne "\e[6 q"' | redraw! |
     \ elseif v:insertmode == 'r' |
     \   silent execute '!echo -ne "\e[4 q"' | redraw! |
     \ endif
   au VimLeave * silent execute '!echo -ne "\e[ q"' | redraw!
endif

" auto-install vim-plug if doesn't have
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" Vim-plug plugins
call plug#begin('~/.vim/plugged')

    " Better Syntax Support
    Plug 'sheerun/vim-polyglot'

    " Commentary util, comment with gc, gcc
    Plug 'tpope/vim-commentary'

    " Indicates git changes
    Plug 'mhinz/vim-signify'    

    " Vertical lines to show indents
    Plug 'Yggdroot/indentLine'

    " Surround commands (`ys` add surrounds, `cs` change surround, `ds` delete surround
    Plug 'tpope/vim-surround'

    " Get current git branch with gitbranch#name()
    Plug 'itchyny/vim-gitbranch'

    " ALE
    Plug 'dense-analysis/ale'

    " Cheat.sh cheatsheets
    Plug 'dbeniamine/cheat.sh-vim'

    " Golang plugin
    Plug 'fatih/vim-go'

    " Testing plugin
    Plug 'junegunn/vader.vim'

    " ColorSchemes

        " Wal random colorscheme generator, using pywal
        Plug 'dylanaraps/wal.vim'

        " Dracula color scheme
        Plug 'dracula/vim',{'as':'dracula'}    

        " Awesome hotdog
        Plug 'tckmn/hotdog.vim'

        " Shades of Purple
        Plug 'Rigellute/shades-of-purple.vim'

call plug#end()

" Status line
set laststatus=2
set statusline+=%{gitbranch#name()}
set statusline+=%h%m%r%=%l/%L

" Config ALE
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_insert_leave = 1
let g:ale_lint_on_enter = 1
let g:ale_lint_on_save = 1
let g:ale_list_window_size = 5

let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

let g:ale_linter_aliases = {'vue': ['vue', 'javascript', 'scss', 'css']}
let g:ale_linters = {'vue': ['eslint', 'vls']}
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'python': ['flake8'],
\   'vue': ['eslint', 'stylelint'],
\   'css': ['stylelint'],
\   'scss': ['stylelint'],
\}

let g:ale_fixers = {
\   'javascript': ['eslint'],
\   'python': ['autopep8'],
\   'vue': ['eslint', 'stylelint'],
\   'css': ['stylelint'],
\   'scss': ['stylelint'],
\}

nmap <leader>l :ALEFix<CR>
nmap gk <Plug>(ale_previous_wrap)
nmap gj <Plug>(ale_next_wrap)

" Colorscheme

" let g:dracula_italic = 0
" colorscheme dracula

colorscheme wal

command! -narg=+ Silent
            \ execute 'silent <args>'
            \ | redraw!

" Fidgeting colorscheme random, using pywal and wal plugin
noremap <silent> <leader>kj :Silent !wal --theme random_dark &>/dev/null &<CR>

" Config vim-signify

" Change signs
let g:signify_sign_add               = '+'
let g:signify_sign_delete            = '_'
let g:signify_sign_delete_first_line = '‾'
let g:signify_sign_change            = '~'
" No numbers
let g:signify_sign_show_count = 0
let g:signify_sign_show_text = 1
" Jump through changes
nmap <leader>gj <plug>(signify-next-hunk)
nmap <leader>gk <plug>(signify-prev-hunk)
