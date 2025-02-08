" █▀█ █░░ █░█ █▀▀ █ █▄░█ █▀
" █▀▀ █▄▄ █▄█ █▄█ █ █░▀█ ▄█

" auto-install vim-plug

if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugUpdate
endif

"""""""""""""""""""""""""""""""""""
" add plugins using vim-plug

call plug#begin('~/.local/share/nvim/site/autoload/plugged')

      "Themes
      Plug 'dracula/vim', { 'as': 'dracula' }
      Plug 'arcticicestudio/nord-vim'
      Plug 'jnurmine/zenburn'
      Plug 'morhetz/gruvbox'

      "Plugins
      Plug 'vim-airline/vim-airline'
      Plug 'vim-airline/vim-airline-themes'
      Plug 'cespare/vim-toml'
      Plug 'mhinz/vim-startify'
      Plug 'preservim/nerdtree'
      Plug 'ryanoasis/vim-devicons'
      Plug 'yuttie/comfortable-motion.vim'
      Plug 'machakann/vim-highlightedyank'
      Plug 'Yggdroot/indentLine'
      Plug 'konfekt/foldtext'
      Plug 'raimondi/delimitmate'
      Plug 'tpope/vim-sensible'
      Plug 'godlygeek/tabular'
      Plug 'ntpeters/vim-better-whitespace'
      Plug 'dag/vim-fish'
      Plug 'lilydjwg/colorizer'

call plug#end()


