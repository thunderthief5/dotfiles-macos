" █▄▀ █▀▀ █▄█ █▀
" █░█ ██▄ ░█░ ▄█

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

