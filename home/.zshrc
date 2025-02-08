
#░ ▀█ █▀ █░█ █▀█ █▀▀ ThunderThief
#▄ █▄ ▄█ █▀█ █▀▄ █▄▄ vim:fileencoding=utf-8:foldmethod=marker

#### {{{ Environment, Path and Aliases

if [[ ! $TERM == *rxvt*  ]]; then
  export TERM="xterm-256color"              # getting proper colors
fi
export EDITOR="vim"
export VISUAL="vim"
export BAT_THEME="base16"

bindkey -e                                # emacs keybindings

# PATH
if [ -d "$HOME/.bin" ] ;
  then PATH="$HOME/.bin:$PATH"
fi

# create .local/bin if it doesnt exist
if ! [[ -d "$HOME/.local/bin" ]]; then
mkdir -p $HOME/.local/bin
fi

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

if [[ $OSTYPE == darwin* ]]; then
  export PATH="/usr/local/sbin:$PATH"     #for homebrew
fi

# pkgfile arch
if command -v pkgfile 2>&1 >/dev/null; then
  source /usr/share/doc/pkgfile/command-not-found.zsh
fi

# .aliases
if [ -f ~/.aliases ]; then
  . ~/.aliases
fi

# vim: Defaults to Neovim if exists
#if command -v nvim 2>&1 >/dev/null; then
#  alias vim='nvim'
#fi

# batcat to bat in Debian
if command -v batcat 2>&1 >/dev/null; then
  alias bat='batcat'
fi

if command -v exa 2>&1 >/dev/null; then
  alias la='exa -al --color=always --group-directories-first' # my preferred listing
  alias ls='exa -a --color=always --group-directories-first'  # all files and dirs
  alias ll='exa -l --color=always --group-directories-first'  # long format
  alias lt='exa -aT --color=always --group-directories-first' # tree listing
  alias l.='exa -a | egrep "^\."'
fi

if command -v doas 2>&1 >/dev/null; then
  alias sudo='doas'
  alias svim='doas vim'
fi

#### }}}

#### {{{ History control

# History file settings
HISTSIZE=100000
SAVEHIST=$HISTSIZE

export HISTFILE=~/.bash_history
export HISTTIMEFORMAT="[%F %T] "

setopt hist_ignore_all_dups # remove older duplicate entries from history
setopt hist_reduce_blanks   # remove superfluous blanks from history items
setopt inc_append_history   # save history entries as soon as they are entered
setopt share_history        # share history between different instances of the shell
setopt auto_cd              # cd by typing directory name if it's not a command
setopt correct_all          # autocorrect commands
setopt auto_list            # automatically list choices on ambiguous completion
setopt auto_menu            # automatically use menu completion
setopt always_to_end        # move cursor to end if word had one match

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Basic auto/tab complete:
zstyle ':completion:*' menu select                                          # select completions with arrow keys
zstyle ':completion:*' group-name ''                                        # group results by category
zstyle ':completion:::::' completer _expand _complete _ignored _approximate # enable approximate matches for completion

# regenerate .zcompdump only once a day
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

_comp_options+=(globdots)		# Include hidden files.

#### }}}

#### {{{ Functions

### change terminal title
function precmd () {
  echo -ne "\033]0;$USER @ $(pwd | sed -e "s;^$HOME;~;")\a"
}

# create a directory and cd into it
mkcd()
{
 mkdir -p $1 && cd $1
}

# function to use cd and ls in one command
cdls() {
  local dir="$1"
  local dir="${dir:=$HOME}"
  if [[ -d "$dir" ]]; then
          cd "$dir" >/dev/null; ls
  else
          echo "bash: cdls: $dir: Directory not found"
  fi
}

# function to use cd and dust in one command
cdust() {
  local dir="$1"
  local dir="${dir:=$HOME}"
  if [[ -d "$dir" ]]; then
          cd "$dir" >/dev/null; dust -brd1
  else
          echo "bash: cdust: $dir: Directory not found"
  fi
}

# function for creating a backup file
bak() {
if [ "$1" = "" ]; then
   echo "File name required. Aborting."
   exit 1
fi
cp "$1" "$1.bak"
echo File backed up to: $1.bak
}

# Archive extraction
# usage: ex <file>
ex ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1   ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *.deb)       ar x $1      ;;
      *.tar.xz)    tar xf $1    ;;
      *.tar.zst)   unzstd $1    ;;
      *)           echo "'$1' cannot be extracted via ex()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

# Deactivates conda before running brew. 
# Re-activates conda if it was active upon completion.

brew() {
    local conda_env="$CONDA_DEFAULT_ENV"
    while [ "$CONDA_SHLVL" -gt 0  ]; do
        conda deactivate
    done
    command brew $@
    local brew_status=$?
    [ -n "${conda_env:+x}" ] && conda activate "$conda_env"
    return "$brew_status"
}

# }}}

#### {{{ Plugins

# assumes github and slash separated plugin names
github_plugins=(
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-completions
  zsh-users/zsh-syntax-highlighting
  zsh-users/zsh-history-substring-search
 )

# clone the plugin from github if it doesn't exist
for plugin in $github_plugins; do
  if [[ ! -d ${ZDOTDIR:-$HOME}/.zsh_plugins/$plugin ]]; then
    mkdir -p ${ZDOTDIR:-$HOME}/.zsh_plugins/${plugin%/*}
    git clone --depth 1 --recursive https://github.com/$plugin.git ${ZDOTDIR:-$HOME}/.zsh_plugins/$plugin
  fi

# load the plugin
for initscript in ${plugin#*/}.zsh ${plugin#*/}.plugin.zsh ${plugin#*/}.sh; do
  if [[ -f ${ZDOTDIR:-$HOME}/.zsh_plugins/$plugin/$initscript ]]; then
    source ${ZDOTDIR:-$HOME}/.zsh_plugins/$plugin/$initscript
    break
  fi
  done
done

# clean up
unset github_plugins
unset plugin
unset initscript


# keybindings for history search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
# for debian (if the above dont work)
bindkey "$terminfo[kcuu1]" history-substring-search-up 
bindkey "$terminfo[kcud1]" history-substring-search-down

#### }}}

#### Starship Prompt
eval "$(starship init zsh)"

##### Start-up Commands
#simplefetch
echo '
▀█ █▀ █░█
█▄ ▄█ █▀█
' | lolcat

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/krishnatejavedula/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/krishnatejavedula/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/krishnatejavedula/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/krishnatejavedula/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

