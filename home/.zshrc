
#░ ▀█ █▀ █░█ █▀█ █▀▀ ThunderThief
#▄ █▄ ▄█ █▀█ █▀▄ █▄▄ vim:fileencoding=utf-8:foldmethod=marker

#### {{{ Environment, Path and Aliases

if [[ ! $TERM == *rxvt* ]]; then
  export TERM="xterm-256color"  # Proper color support
fi

export EDITOR="vim"
export VISUAL="vim"
export BAT_THEME="base16"

bindkey -e  # Emacs keybindings

# PATH Configuration
for dir in "$HOME/.bin" "$HOME/.local/bin" "/usr/local/sbin"; do
  [ -d "$dir" ] && PATH="$dir:$PATH"
done

# Ensure ~/.local/bin exists
mkdir -p "$HOME/.local/bin"

# pkgfile Arch Linux integration
command -v pkgfile &>/dev/null && source /usr/share/doc/pkgfile/command-not-found.zsh

# Load aliases if available
[ -f ~/.aliases ] && source ~/.aliases

# Use Neovim if installed (commented out)
# command -v nvim &>/dev/null && alias vim='nvim'

# Debian-specific alias for bat
command -v batcat &>/dev/null && alias bat='batcat'

# exa as replacement for ls
if command -v exa &>/dev/null; then
  alias la='exa -al --color=always --group-directories-first'
  alias ls='exa -a --color=always --group-directories-first'
  alias ll='exa -l --color=always --group-directories-first'
  alias lt='exa -aT --color=always --group-directories-first'
  alias l.='exa -a | egrep "^\."'
fi

# Use doas instead of sudo if available
command -v doas &>/dev/null && alias sudo='doas' && alias svim='doas vim'

#### }}}

#### {{{ History Control

export HISTFILE=~/.zsh_history
export HISTSIZE=100000
export SAVEHIST=$HISTSIZE
export HISTTIMEFORMAT="[%F %T] "

setopt hist_ignore_all_dups  # Remove older duplicate entries
setopt hist_reduce_blanks    # Remove redundant spaces
setopt inc_append_history    # Save entries as soon as they are entered
setopt share_history         # Share history between shell instances
setopt auto_cd               # `cd` by typing the directory name
setopt correct_all           # Autocorrect commands
setopt auto_list             # List choices on ambiguous completion
setopt auto_menu             # Use menu completion
setopt always_to_end         # Move cursor to the end if word has one match

# Ensure the script runs only in interactive shells
case $- in
  *i*) ;;
  *) return ;;
esac

# Basic auto/tab completion
zstyle ':completion:*' menu select
zstyle ':completion:*' group-name ''
zstyle ':completion:::::' completer _expand _complete _ignored _approximate

# Regenerate .zcompdump only once per day
autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

_comp_options+=(globdots)  # Include hidden files in completion

#### }}}

#### {{{ Environment Variables

export DYLD_LIBRARY_PATH="$HOME/.local/lib"

# GNU Scientific Library (GSL)
export GSL_DIR="/opt/homebrew/opt/gsl"
export PATH="$GSL_DIR/bin:$PATH"
export LDFLAGS="-L$GSL_DIR/lib"
export CPPFLAGS="-I$GSL_DIR/include"
export PKG_CONFIG_PATH="$GSL_DIR/lib/pkgconfig"

#### }}}

#### {{{ Compiler Settings

# Uncomment these if you need GCC and GFortran
# export CC=/opt/homebrew/bin/gcc-12
# export CXX=/opt/homebrew/bin/g++-12
# export FC=/opt/homebrew/bin/gfortran-12

#### }}}

#### {{{ Functions

# Set terminal title
function precmd() {
  echo -ne "\033]0;$USER @ $(pwd | sed -e "s;^$HOME;~;")\a"
}

# Create a directory and immediately cd into it
mkcd() {
  [[ -z "$1" ]] && echo "Usage: mkcd <directory-name>" && return 1
  mkdir -p "$1" && cd "$1" || return 1
}

# Change directory and list files
cdls() {
  local dir="${1:-$HOME}"
  [[ -d "$dir" ]] && cd "$dir" >/dev/null && ls || echo "zsh: cdls: $dir: Directory not found"
}

# Change directory and show disk usage (dust required)
cdust() {
  local dir="${1:-$HOME}"
  [[ -d "$dir" ]] && cd "$dir" >/dev/null && dust -brd1 || echo "zsh: cdust: $dir: Directory not found"
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

#### {{{ Plugins

github_plugins=(
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-completions
  zsh-users/zsh-syntax-highlighting
  zsh-users/zsh-history-substring-search
)

# Clone missing plugins
for plugin in $github_plugins; do
  plugin_dir="${ZDOTDIR:-$HOME}/.zsh_plugins/$plugin"
  [[ ! -d "$plugin_dir" ]] && git clone --depth 1 --recursive "https://github.com/$plugin.git" "$plugin_dir"
done

# Load plugins
for plugin in $github_plugins; do
  for initscript in "${plugin#*/}.zsh" "${plugin#*/}.plugin.zsh" "${plugin#*/}.sh"; do
    plugin_path="${ZDOTDIR:-$HOME}/.zsh_plugins/$plugin/$initscript"
    [[ -f "$plugin_path" ]] && source "$plugin_path" && break
  done
done

unset github_plugins plugin plugin_path initscript

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

#### {{{ Starship Prompt

eval "$(starship init zsh)"

#### }}}

#### {{{ Start-up Commands

if [[ $- == *i* ]]; then
    echo '
▀█ █▀ █░█
█▄ ▄█ █▀█
' | lolcat
fi

#### }}}

