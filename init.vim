call plug#begin('~/.config/nvim/plugged')

Plug 'Lokaltog/vim-powerline'
Plug 'chriskempson/base16-vim'
Plug 'danro/rename.vim'
Plug 'godlygeek/tabular'
Plug 'guns/vim-clojure-static'
Plug 'isRuslan/vim-es6'
Plug 'jeffkreeftmeijer/vim-numbertoggle'
Plug 'kana/vim-textobj-user'
Plug 'kchmck/vim-coffee-script'
Plug 'kien/ctrlp.vim'
Plug 'mileszs/ack.vim'
Plug 'nelstrom/vim-textobj-rubyblock'
Plug 'othree/html5.vim'
Plug 'pangloss/vim-javascript'
Plug 'renderedtext/vim-bdd'
Plug 'scrooloose/syntastic'
Plug 'tpope/vim-classpath'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-cucumber'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-fireplace'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-markdown'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'vim-ruby/vim-ruby'

call plug#end()

runtime macros/matchit.vim          " Enables % to cycle through `if/else/endif`, recognizing Ruby blocks, etc.

set number
set ruler                              " Show the cursor position all the time
set cursorline                         " Highlight the line of the cursor
set showcmd                            " Show partial commands below the status line
set shell=bash                         " Avoids munging PATH under zsh
let g:is_bash=1                        " Default shell syntax
set scrolloff=3                        " Have some context around the current line always
                                       " on screen
set noerrorbells visualbell t_vb=      " Disable bell
set hidden                             " Allow backgrounding buffers without writing
                                       " them, and remember marks/undo for backgrounded
                                       " buffers
set backupdir=~/.config/neovim/_backup " where to put backup files.
set directory=~/.config/neovim/_temp   " where to put swap files.

" Whitespace
set nowrap                        " don't wrap lines
set tabstop=2                     " a tab is two spaces
set shiftwidth=2                  " an autoindent (with <<) is two spaces
set expandtab                     " use spaces, not tabs

" Searching
set ignorecase                    " searches are case insensitive...
set smartcase                     " ... unless they contain at least one capital letter

function s:setupWrappingAndSpellcheck()
  set wrap
  set wrapmargin=2
  set textwidth=80
  set spell
endfunction

if has("autocmd")
  " Delete empty space from the end of lines on every save
  au BufWritePre * :%s/\s\+$//e

  " Make sure all markdown files have the correct filetype set and setup
  " wrapping and spell check
  au BufRead,BufNewFile *.{md,md.erb,markdown,mdown,mkd,mkdn,txt} setf markdown | call s:setupWrappingAndSpellcheck()

  " Spellcheck
  au BufRead,BufNewFile *.feature setlocal spell

  " Treat JSON files like JavaScript
  au BufNewFile,BufRead *.json set ft=javascript

  " Remember last location in file, but not for commit messages.
  " see :help last-position-jump
  au BufReadPost * if &filetype !~ '^git\c' && line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g`\"" | endif

  " Clojure
  au BufRead,BufNewFile *.{cljs,boot} setlocal filetype=clojure

  " Git
  au Filetype gitcommit setlocal spell textwidth=72
endif

" clear the search buffer when hitting return
:nnoremap <CR> :nohlsearch<cr>

let mapleader=" "

" paste lines from unnamed register and fix indentation
nmap <leader>p pV`]=
nmap <leader>P PV`]=

inoremap jj <Esc>

map <leader>ga :CtrlP app<cr>
map <leader>gv :CtrlP app/views<cr>
map <leader>gc :CtrlP app/controllers<cr>
map <leader>gm :CtrlP app/models<cr>
map <leader>gh :CtrlP app/helpers<cr>
map <leader>gf :CtrlP features<cr>
map <leader>gs :CtrlP spec<cr>
map <leader>gt :CtrlP test<cr>
map <leader>gl :CtrlP lib<cr>
map <leader>f :CtrlP ./<cr>
map <leader>b :CtrlPBuffer<cr>
map <leader>gd :e db/schema.rb<cr>
map <leader>gr :e config/routes.rb<cr>
map <leader>s :A<CR>
map <leader>v :AV<CR>

" ignore temp files
set wildignore+=tmp/**
set wildignore+=*/vendor/*

nnoremap <leader><leader> <c-^>

command! KillWhitespace :normal :%s/ *$//g<cr><c-o><cr>

" easier navigation between split windows
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" map Ctrl+S to :w
noremap <silent> <C-S>  :update<CR>
vnoremap <silent> <C-S> <C-C>:update<CR>
inoremap <silent> <C-S> <C-O>:update<CR>

if has("statusline") && !&cp
  " Start the status line
  set statusline=%f\ %m\ %r

  " Add fugitive
  set statusline+=%{fugitive#statusline()}

  " Finish the statusline
  set statusline+=Line:%l/%L[%p%%]
  set statusline+=Col:%v
  set statusline+=Buf:#%n
  set statusline+=[%b][0x%B]
endif

" Ack
let g:ackprg="ack-grep -H --nocolor --nogroup --column"
nmap <leader>a :Ack ""<Left>
nmap <leader>A :Ack <C-r><C-w><CR>

" Color scheme
let base16colorspace=256
set background=dark
colorscheme base16-mocha