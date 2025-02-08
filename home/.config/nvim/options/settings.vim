" █▀ █▀▀ ▀█▀ ▀█▀ █ █▄░█ █▀▀ █▀
" ▄█ ██▄ ░█░ ░█░ █ █░▀█ █▄█ ▄█

colorscheme dracula

" {{{ General Settings

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

set backupdir=$HOME/.cache/nvim/tmp/backup
set dir=$HOME/.cache/nvim/tmp/swap
set viewdir=$HOME/.cache/nvim/tmp/view
set undodir=$HOME/.cache/nvim/tmp/undo

if !isdirectory(&backupdir) | call mkdir(&backupdir, 'p', 0700) | endif
if !isdirectory(&dir)       | call mkdir(&dir, 'p', 0700)       | endif
if !isdirectory(&viewdir)   | call mkdir(&viewdir, 'p', 0700)   | endif
if !isdirectory(&undodir)   | call mkdir(&undodir, 'p', 0700)   | endif

" }}}

" {{{ GUI and Terminal settings:

if has ('nvim') || &term == "rxvt-unicode-256color"
  set notermguicolors
  "set term=xterm-256color
endif

autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE "for a transparent bg on terminal

" }}}

"""""""""""""""""""""""""""""""""""

" {{{ Plugin Settings:
" Airline Settings
"let g:airline_theme='dracula'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_disable_statusline = 0
let g:airline#extensions#whitespace#enabled = 0
"let g:airline_powerline_fonts = 1
"let g:airline_left_sep = "\uE0B8"
"let g:airline_right_sep = "\uE0BA"
"let g:airline_left_alt_sep = "\ue0b9"
"let g:airline_right_alt_sep = "\ue0bb" 
"let g:airline#extensions#tabline#left_sep = "\ue0bc"
"let g:airline#extensions#tabline#left_alt_sep = '\ue0bd'
"let g:airline#extensions#tabline#right_sep = "\ue0be"
"let g:airline#extensions#tabline#right_alt_sep = "\ue0bf"

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
     \ { 'z': '~/.zshrc' },
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
let g:comfortable_motion_friction = 100.0
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

" }}}

