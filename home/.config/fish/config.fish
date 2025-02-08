
# █▀▀ █ █▀ █░█ ThunderThief
# █▀░ █ ▄█ █▀█ vim:fileencoding=utf-8:foldmethod=marker


##### General settings
set fish_greeting                      # hide fish intro message
#set TERM "xterm-256color"             # Sets the terminal type
set -gx EDITOR nvim
set -gx VISUAL nvim

set PATH $HOME/.local/bin $HOME/.bin/ $PATH        # Add .bin, .local/bin to $PATH

source ~/.aliases                      # Use Bash Aliases

##### Set emacs OR vi mode
function fish_user_key_bindings
   fish_default_key_bindings
  #fish_vi_key_bindings
end

##### {{{ Functions
# mkdir and cd in one command
function mkcd
    mkdir -p $argv;
    cd $argv;
end

# cd and ls in one command
function cdls
    if count $argv > /dev/null
        builtin cd "$argv"; and ls
    else
        builtin cd ~; and ls
    end
end

# Function for creating a backup file
function bak --argument filename
    cp $filename $filename.bak
    echo File backed to: $filename.bak
end

# basic system info
function fetch
    echo  Hostname: (echo $hostname) && echo OS: (uname -o) && echo Version: (uname -mrs) && echo Shell: (basename $SHELL)
end

# }}}

##### Starship Prompt
starship init fish | source

##### Startup commands
#blocks1
echo '
█▀▀ █ █▀ █░█
█▀░ █ ▄█ █▀█' | lolcat

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
eval /opt/anaconda3/bin/conda "shell.fish" "hook" $argv | source
# <<< conda initialize <<<

