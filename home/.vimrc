
" █░█ █ ▄▄ █ █▀▄▀█ █▀█ █▀█ █▀█ █░█ █▀▀ █▀▄  ThunderThief
" ▀▄▀ █ ░░ █ █░▀░█ █▀▀ █▀▄ █▄█ ▀▄▀ ██▄ █▄▀  vim:fileencoding=utf-8:foldmethod=marker

"""""""""""""""""""""""""""""""""""""""""""""""""
" {{{ Plugins:

" auto-install vim-plug
"if has ('nvim') || empty(glob('~/.config/nvim/autoload/plug.vim'))
"  silent !mkdir -p ~/.config/nvim && ln -s ~/.vim/autoload ~/.config/nvim/
"endif

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
  "autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" add plugins using vim-plug
call plug#begin('~/.vim/autoload/plugged')

      "Themes
      Plug 'dracula/vim', { 'as': 'dracula' }
      Plug 'arcticicestudio/nord-vim'
      Plug 'chriskempson/base16-vim'
      Plug 'rakr/vim-one'
      Plug 'jnurmine/zenburn'
      Plug 'morhetz/gruvbox'
      Plug 'mhartington/oceanic-next'
      Plug 'drewtempelmeyer/palenight.vim'
      Plug 'ayu-theme/ayu-vim'
      Plug 'kyoz/purify', { 'rtp': 'vim' }
      Plug 'joshdick/onedark.vim'

      "Plugins
      Plug 'vim-airline/vim-airline'
      "Lean & mean status/tabline for vim that's light as air.

      Plug 'vim-airline/vim-airline-themes'
      "A collection of themes for vim-airline

      Plug 'cespare/vim-toml'
      "Vim syntax for TOML.

      Plug 'mhinz/vim-startify'
      "The fancy start screen for Vim

      Plug 'preservim/nerdtree'
      "A tree explorer plugin for vim

      Plug 'ryanoasis/vim-devicons'
      "Adds icons to your plugins

      Plug 'yuttie/comfortable-motion.vim'
      "Brings physics-based smooth scrolling to the Vim/Neovim world!

      Plug 'machakann/vim-highlightedyank'
      "Make the yanked region apparent!

""      Plug 'Yggdroot/indentLine'
      "A vim plugin to display the indentation levels with thin vertical lines

      Plug 'konfekt/foldtext'
      "Fancy fold texts

      Plug 'raimondi/delimitmate'
      "Provides insert mode auto-completion of quotes, parenthesis, brackets, etc.,

      Plug 'tpope/vim-sensible'
      "Defaults everyone can agree on

      Plug 'godlygeek/tabular'
      "Vim script for text filtering and alignment

      Plug 'ntpeters/vim-better-whitespace'
      "Better whitespace highlighting for vim

      Plug 'dag/vim-fish'
      "Vim support for editing fish scripts

      Plug 'lilydjwg/colorizer'
      "A Vim plugin to colorize all text in the form #rgb, #rgba, #rrggbb, #rrgbbaa, rgb(...), rgba(...)

      Plug 'lervag/vimtex'
      "A modern Vim and Neovim filetype and syntax plugin for LaTeX files
call plug#end()

" }}}
"""""""""""""""""""""""""""""""""""""""""""""""""
" {{{ General Settings:

" Save vimrc to init.vim after every change
"autocmd BufWritePost *.vimrc !cp ~/.vimrc ~/.config/nvim/init.vim

if has ('nvim')
  colorscheme zenburn
elseif has ('gui_running')
  colorscheme nord
else
  colorscheme dracula
endif

" Defaults from NeoVim
if !has('nvim')
  set nocompatible
  syntax on
  set autoindent
  set autoread
  set backspace=indent,eol,start
  set belloff=all
  set complete-=i
  set display=lastline
  set encoding=utf-8
  set formatoptions=tcqj
  set history=10000
  set hlsearch
  set incsearch
  set laststatus=2
  set listchars=tab:>\ ,trail:-,nbsp:+
  set ruler
  set sessionoptions-=options
  set showcmd
  set sidescroll=1
  set smarttab
  set ttimeoutlen=50
  set ttyfast
  set viminfo+=!
  set wildmenu
  set background=dark
  set viewoptions=folds,options,cursor,unix,slash
endif

set hidden
set pumheight=10
set fileencoding=utf-8
set cmdheight=2
set iskeyword+=-
set mouse=a
set splitbelow
set splitright
set t_Co=256
set conceallevel=0
set tabstop=2
set shiftwidth=2
set expandtab
set smartindent
"set number relativenumber
set cursorline
set showtabline=2
set noshowmode
set updatetime=300
set timeoutlen=500
set clipboard+=unnamedplus
"set autochdir
set confirm

set ignorecase
set smartcase

set mousemodel=popup

set spell
set spelllang=en_us
set spellfile=~/.vim/spell/en.utf-8.add
set complete+=kspell
set completeopt=menuone,longest

set ffs=unix,dos,mac

if has('syntax') && !exists('g:syntax_on')
  syntax enable
endif

filetype plugin indent on
set virtualedit=onemore

highlight Comment cterm=bold,italic gui=bold,italic

set foldmethod=marker

" }}}

" {{{ Cursor settings:
let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)

"  1 -> blinking block
"  2 -> solid block
"  3 -> blinking underscore
"  4 -> solid underscore
"  5 -> blinking vertical bar
"  6 -> solid vertical bar
" }}}

" {{{ Swap and Undo Directories:

set swapfile
set undofile
set backup

if has ('nvim')
    set backupdir=$HOME/.cache/nvim/tmp/backup
    set dir=$HOME/.cache/nvim/tmp/swap
    set viewdir=$HOME/.cache/nvim/tmp/view
    set undodir=$HOME/.cache/nvim/tmp/undo
  else
    set backupdir=$HOME/.cache/vim/tmp/backup
    set dir=$HOME/.cache/vim/tmp/swap
    set viewdir=$HOME/.cache/vim/tmp/view
    set undodir=$HOME/.cache/vim/tmp/undo
endif


if !isdirectory(&backupdir) | call mkdir(&backupdir, 'p', 0700) | endif
if !isdirectory(&dir)       | call mkdir(&dir, 'p', 0700)       | endif
if !isdirectory(&viewdir)   | call mkdir(&viewdir, 'p', 0700)   | endif
if !isdirectory(&undodir)   | call mkdir(&undodir, 'p', 0700)   | endif

" Store temporary files in ~/.vim/tmp
if !has('nvim')
 set viminfo+=n~/.cache/vim/tmp/viminfo
endif

" }}}

" {{{ GUI and Terminal settings:

if has('vim') || has('termguicolors')
  set termguicolors
elseif has('nvim') || has('termguicolors')
  set termguicolors
endif

if &term == "alacritty"
  let &term = "xterm-256color"
endif

if !has ('vim') || &term == "rxvt-unicode-256color"
  set notermguicolors
  "set term=xterm-256color
endif

"gui settings
if has("gui_running")
  set guioptions-=T
  set guioptions-=e
  set t_Co=256
  set guitablabel=%M\ %t
  if has("gui_macvim")
    set guifont=agave\ Nerd\ Font\ Mono:h18
  elseif has("gui_gtk3")
    set guifont=agave\ Nerd\ Font\ Mono\ 13
    set lines=40 columns=100
  endif
  hi Normal guibg=#1c2023
  autocmd GUIEnter * set vb t_vb=
else
  autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE "for a transparent bg on terminal
endif

" }}}
"""""""""""""""""""""""""""""""""""""""""""""""""
" {{{ Plugin Settings:

"if !has('nvim')
  " Airline Settings
   "let g:airline_theme='dracula'
   let g:airline#extensions#tabline#enabled = 1
   let g:airline#extensions#tabline#formatter = 'unique_tail'
   let g:airline_disable_statusline = 0
   let g:airline#extensions#whitespace#enabled = 0
   "let g:airline_powerline_fonts = 1
   let g:airline_left_sep = "\uE0B8"
   let g:airline_right_sep = "\uE0BA"
   let g:airline_left_alt_sep = "\ue0b9"
   let g:airline_right_alt_sep = "\ue0bb"
   let g:airline#extensions#tabline#left_sep = "\ue0bc"
   let g:airline#extensions#tabline#left_alt_sep = "\ue0bd"
   let g:airline#extensions#tabline#right_sep = "\ue0be"
   let g:airline#extensions#tabline#right_alt_sep = "\ue0bf"

"endif

" NerdTree Settings
let NERDTreeShowHidden=1
let g:NERDTreeWinPos = "right"

" {{{ Startify Settings
" Custom Startify Banner
if has ('nvim')
  let g:startify_custom_header = [
     \'',
     \'   █▄░█ █▀▀ █▀█ █░█ █ █▀▄▀█',
     \'   █░▀█ ██▄ █▄█ ▀▄▀ █ █░▀░█',
     \'',
     \ ]
else
  let g:startify_custom_header = [
     \'',
     \'   █░█ █ ▄▄ █ █▀▄▀█ █▀█ █▀█ █▀█ █░█ █▀▀ █▀▄',
     \'   ▀▄▀ █ ░░ █ █░▀░█ █▀▀ █▀▄ █▄█ ▀▄▀ ██▄ █▄▀',
     \'',
     \ ]
endif

let g:startify_custom_footer = "startify#pad(['','\ue62b Configured by ThunderThief', ''])"

function! StartifyEntryFormat()
        return 'WebDevIconsGetFileTypeSymbol(absolute_path) ." ". entry_path'
    endfunction

let g:startify_files_number = 10

let g:startify_session_dir = $HOME .  '/.data/' . ( has('nvim') ? 'nvim' : 'vim' )

let g:startify_list_order = [
       \ ['   My most recently used files:'],
     \ 'files',
     \ ['   These are my sessions:'],
     \ 'sessions',
     \ ['   These are my bookmarks:'],
     \ 'bookmarks',
     \ ]

  "Add these lines to list order if needed
  "   \ ['   My most recently used files in the current directory:'],
  "   \ 'dir',

let g:startify_bookmarks = [
     \ { 'a': '~/.aliases' },
     \ { 'b': '~/.bashrc' },
     \ { 'f': '~/.config/fish/config.fish' },
     \ { 'n': '~/.config/nvim/init.vim' },
     \ { 'v': '~/.vimrc' },
     \ { 'd': '~/.config' },
     \ ]

let g:startify_enable_special = 0
let g:startify_session_autoload = 1
let g:startify_session_delete_buffers = 1
let g:startify_session_persistence = 1

" }}}

" vim-devicons settings
" loading the plugin
let g:webdevicons_enable = 1
" adding the flags to NERDTree
let g:webdevicons_enable_nerdtree = 1
" adding to vim-startify screen
let g:webdevicons_enable_startify = 1
" adding to vim-airline's tabline
let g:webdevicons_enable_airline_tabline = 1
" adding to vim-airline's statusline
let g:webdevicons_enable_airline_statusline = 1

" Comfortable  motion settings
let g:comfortable_motion_friction = 1000.0
let g:comfortable_motion_air_drag = 4.0

" IndentLine settings
let g:indentLine_enabled = 1
let g:indentLine_char = '|'
"let g:indentLine_char_list = ['|', '¦', '┆', '┊']
"let g:indentLine_leadingSpaceEnabled = 1
"let g:indentLine_leadingSpaceChar = '.'
let g:indentLine_setcolors = 1
let g:indentLine_color_gui = '#6272a4'
let g:indentLine_fileTypeExclude = [ 'startify' ]

" better-whitepace
let g:better_whitespace_guicolor='#d8dee9'
autocmd User Startified DisableWhitespace

" FoldText
" specifies for which commands a fold will be opened
set foldopen=block,hor,insert,jump,mark,percent,quickfix,search,tag,undo

" vimtex
let g:vimtex_view_method= "skim"
let g:vimtex_view_general_options = '-r @line @pdf @tex'

let g:tex_flavor='latex'
let g:vimtex_quickfix_mode= 0
set conceallevel=1
let g:tex_conceal='abdmg'
let g:vimtex_fold_enabled=1
" }}}
"""""""""""""""""""""""""""""""""""""""""""""""""
" {{{ General Keybindings:

" set leader key
let g:mapleader = "\<Space>"

"" no one is really happy until you have this shortcuts
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

" Seamlessly treat visual lines as actual lines when moving around.
noremap j gj
noremap k gk
noremap <Down> gj
noremap <Up> gk
inoremap <Down> <C-o>gj
inoremap <Up> <C-o>gk

" Better nav for omnicomplete
inoremap <expr> <c-j> ("\<C-n>")
inoremap <expr> <c-k> ("\<C-p>")

" Splits
noremap <Leader>h :<C-u>split<CR>
noremap <Leader>v :<C-u>vsplit<CR>

" Use ctrl + hjkl to resize windows
noremap <silent> <C-Left> :vertical resize +3<CR>
noremap <silent> <C-Right> :vertical resize -3<CR>
noremap <silent> <C-Up> :resize +3<CR>
noremap <silent> <C-Down> :resize -3<CR>

" I hate escape more than anything else
inoremap jk <Esc>
inoremap kj <Esc>

" Easy CAPS
inoremap <c-u> <ESC>viwUi
nnoremap <c-u> viwU<Esc>

" Alternate way to save
nnoremap <C-s> :w<CR>
" Alternate way to quit
nnoremap <C-Q> :wq!<CR>
" Use control-c instead of escape
nnoremap <C-c> <Esc>
" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" Better tabbing
vnoremap < <gv
vnoremap > >gv

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <Leader>o o<Esc>^Da
nnoremap <Leader>O O<Esc>^Da

" Tab navigation
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>

" Open/Close all folds
nnoremap <expr> <Leader>ff &foldlevel ? 'zM' :'zR'
" Open/Close individual folds
nnoremap <expr> <leader>f foldclosed('.') != -1 ? 'zO' : 'zc'

" Toggle hybrid number line
nnoremap <silent> <leader>l :set relativenumber! <bar> set nu!<CR>

" }}}
"""""""""""""""""""""""""""""""""""""""""""""""""
" {{{ Plugin specific Keybindings:

" NerdTree
nnoremap <leader>n :NERDTreeToggle<CR>

" Startify
nnoremap <leader>sv :vsp <bar> Startify<CR>
nnoremap <leader>st :tabnew <bar> Startify<CR>

" Comfortable motion
noremap <silent> <ScrollWheelDown> :call comfortable_motion#flick(40)<CR>
noremap <silent> <ScrollWheelUp>   :call comfortable_motion#flick(-40)<CR>

" }}}
"""""""""""""""""""""""""""""""""""""""""""""""""

