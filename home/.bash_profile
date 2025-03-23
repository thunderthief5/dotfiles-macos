
#░ █▄▄ ▄▀█ █▀ █░█ █▀█ █▀▀ ThunderThief
#▄ █▄█ █▀█ ▄█ █▀█ █▀▄ █▄▄ vim:fileencoding=utf-8:foldmethod=marker

#### {{{ Environment, Path, and Aliases

# Set terminal colors
if [[ ! $TERM == *rxvt* ]]; then
  export TERM="xterm-256color"
fi

# Default editor settings
export EDITOR="vim"
export VISUAL="vim"
export BAT_THEME="zenburn"

# Add directories to PATH dynamically
for dir in "$HOME/.bin" "$HOME/.local/bin" "/usr/local/sbin"; do
  [ -d "$dir" ] && PATH="$dir:$PATH"
done

# Ensure ~/.local/bin exists
mkdir -p "$HOME/.local/bin"

# Load pkgfile command-not-found (Arch Linux)
command -v pkgfile &>/dev/null && source /usr/share/doc/pkgfile/command-not-found.bash

# Load aliases if the file exists
[ -f ~/.aliases ] && source ~/.aliases

# Debian-specific alias for bat
command -v batcat &>/dev/null && alias bat='batcat'

# Use doas instead of sudo if available
command -v doas &>/dev/null && alias sudo='doas' && alias svim='doas vim'

#### }}}

#### {{{ History Control

export HISTCONTROL=ignoreboth:erasedups
HISTSIZE=1000
HISTFILESIZE=2000

# Shell options
shopt -s autocd cdspell cmdhist dotglob histappend expand_aliases checkwinsize

# Ensure script runs only in interactive shells
case $- in
  *i*) ;;
  *) return ;;
esac

# Ignore case in TAB completion
bind "set completion-ignore-case on"

# Enable history search with arrow keys (similar to Fish shell)
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

#### }}}

#### {{{ Manual Page Viewer

# Uncomment one of these:
# export MANPAGER="sh -c 'col -bx | bat -l man -p'"
# export MANPAGER='/bin/bash -c "vim -MRn -c \"set buftype=nofile showtabline=0 ft=man ts=8 nomod nolist norelativenumber nonu noma\" -c \"normal L\" -c \"nmap q :qa<CR>\"</dev/tty <(col -b)"'
# export MANPAGER="nvim -c 'set ft=man' -"

#### }}}

#### {{{ Functions

# Set terminal window title
case ${TERM} in
  xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|alacritty|st|konsole*)
    PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
    ;;
  screen*)
    PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
    ;;
esac

# Create a directory and immediately cd into it
mkcd() {
  [[ -z "$1" ]] && echo "Usage: mkcd <directory-name>" && return 1
  mkdir -p "$1" && cd "$1" || return 1
}

# Change directory and list files
cdls() {
  local dir="${1:-$HOME}"
  [[ -d "$dir" ]] && cd "$dir" >/dev/null && ls || echo "bash: cdls: $dir: Directory not found"
}

# Backup a file
bak() {
  [[ -z "$1" ]] && echo "File name required. Aborting." && return 1
  cp "$1" "$1.bak"
  echo "File backed up to: $1.bak"
}

# Archive extraction function
ex() {
  [[ ! -f "$1" ]] && echo "'$1' is not a valid file" && return 1

  shopt -s nocasematch
  case "$1" in
    *.tar.bz2|*.tbz2) tar xjf "$1" ;;
    *.tar.gz|*.tgz)   tar xzf "$1" ;;
    *.bz2)            bunzip2 "$1" ;;
    *.rar)            unrar x "$1" ;;
    *.gz)             gunzip "$1" ;;
    *.tar)            tar xf "$1" ;;
    *.zip)            unzip "$1" ;;
    *.7z)             7z x "$1" ;;
    *.tar.xz)         tar xf "$1" ;;
    *.tar.zst)        unzstd "$1" ;;
    *)                echo "'$1' cannot be extracted via ex()" ;;
  esac
}

# Deactivates Conda before running Brew
brew() {
    local conda_env="${CONDA_DEFAULT_ENV:-}"
    while [ "$CONDA_SHLVL" -gt 0 ]; do conda deactivate; done
    command brew "$@"
    local status=$?
    [[ -n "$conda_env" ]] && conda activate "$conda_env"
    return $status
}

#### }}}

#### {{{ Homebrew and Package Management

# Add Homebrew to PATH
eval "$(/opt/homebrew/bin/brew shellenv)"

#### }}}

#### {{{ Conda Initialization

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Users/krishnatejavedula/miniforge3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/krishnatejavedula/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/Users/krishnatejavedula/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/krishnatejavedula/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

#### }}}

#### {{{ Node Version Manager (NVM)

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

#### }}}

#### {{{ Environment Variables

export DYLD_LIBRARY_PATH="$HOME/.local/lib"
export C_INCLUDE_PATH=$HOME/.local/include:$C_INCLUDE_PATH
export LIBRARY_PATH=$HOME/.local/lib:$LIBRARY_PATH
export LD_LIBRARY_PATH=$HOME/.local/lib:$LD_LIBRARY_PATH


#### }}}

#### {{{ Compiler Settings

# export CC=/opt/homebrew/bin/gcc-12
# export CXX=/opt/homebrew/bin/g++-12
# export FC=/opt/homebrew/bin/gfortran-12

#### }}}

#### {{{ Starship Prompt and Startup Banner

if [[ $- == *i* ]]; then
    eval "$(starship init bash)"
    echo '
█▄▄ ▄▀█ █▀ █░█
█▄█ █▀█ ▄█ █▀█
' | lolcat
fi

#### }}}
