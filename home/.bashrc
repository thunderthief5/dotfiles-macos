
#░ █▄▄ ▄▀█ █▀ █░█ █▀█ █▀▀ ThunderThief
#▄ █▄█ █▀█ ▄█ █▀█ █▀▄ █▄▄ vim:fileencoding=utf-8:foldmethod=marker

#### {{{ Environment, Path and Aliases

if [[ ! $TERM == *rxvt*  ]]; then
  export TERM="xterm-256color"              # getting proper colors
fi
export EDITOR="vim"
export VISUAL="vim"
export BAT_THEME="GitHub"

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
export PATH="/usr/local/sbin:$PATH" #for homebrew
fi

# pkgfile arch
if command -v pkgfile 2>&1 >/dev/null; then
  source /usr/share/doc/pkgfile/command-not-found.bash
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

# start urxvt with zsh

#if [[ $TERM == *rxvt*  ]]; then
#  exec zsh
#fi

#### }}}

#### {{{ History control
export HISTCONTROL=ignoreboth:erasedups

HISTSIZE=1000
HISTFILESIZE=2000

### SHOPT
shopt -s autocd # change to named directory
shopt -s cdspell # autocorrects cd misspellings
shopt -s cmdhist # save multi-line commands in history as single line
shopt -s dotglob
shopt -s histappend # do not overwrite history
shopt -s expand_aliases # expand aliases
shopt -s checkwinsize # checks term size when bash regains control


# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

#ignore upper and lowercase when TAB completion
bind "set completion-ignore-case on"

#history completion using arrow keys (almost like fish)
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# }}}

#### {{{ SET MANPAGER
# Uncomment only one of these!

# "bat" as manpager
#export MANPAGER="sh -c 'col -bx | bat -l man -p'"

# "vim" as manpager
# export MANPAGER='/bin/bash -c "vim -MRn -c \"set buftype=nofile showtabline=0 ft=man ts=8 nomod nolist norelativenumber nonu noma\" -c \"normal L\" -c \"nmap q :qa<CR>\"</dev/tty <(col -b)"'

#"nvim" as manpager
# export MANPAGER="nvim -c 'set ft=man' -"

# }}}

#### {{{ my custom bash prompts
#export PS1="\n[\e[01;36m\u\e[m on \e[01;31m\h\e[m] \e[01;32m\w\e[m \n\e[01;32m</> \e[m"

#export PS1='\[\e[m\]\n\[\e[0;1m\][\[\e[0;1;96m\]\u\[\e[0;1m\]]\[\e[m\] \[\e[0;1;92m\]\w\[\e[m\] \[\e0'

#export PS1='\[\e[m\]\n\[\e[0;1m\][\[\e[0;1;96m\]\u\[\e[m\] \[\e[0m\]on\[\e[m\] \[\e[0;1;95m\]\h\[\e[0;1m\]]\[\e[m\]\n\[\e[0;1;3;32m\]\w\[\e[m\] \[\e0'

#export PS1='\[\e[m\]\n\[\e[0;1m\][\[\e[0;1;96m\]\u\[\e[m\] \[\e[0m\]on\[\e[m\] \[\e[0;1;95m\]\h\[\e[0;1m\]]\[\e[m\] \[\e[0;1;32m\]\w\[\e[m\]\n\[\e[0;1;92m\]\A\[\e[m\] \[\e0'

# }}}

#### {{{ Functions

### CHANGE TITLE OF TERMINALS
case ${TERM} in
  xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|alacritty|st|konsole*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
        ;;
  screen*)
    PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
    ;;
esac

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

## Temporarily deactivates anaconda environment to run brew command(s)
#
#brew() {(
#    local conda_env="$CONDA_DEFAULT_ENV"
#    while [ "$CONDA_SHLVL" -gt 0  ]; do
#        conda deactivate
#    done
#    command brew $@
#    local brew_status=$?
#    return "$brew_status"
#)}

# }}}


# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/krishnatejavedula/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
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


#### Starship Prompt
eval "$(starship init bash)"

##### Start-up Commands
#simplefetch
echo '
█▄▄ ▄▀█ █▀ █░█
█▄█ █▀█ ▄█ █▀█
' | lolcat
