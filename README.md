# ThunderThief's Dotfiles For MacOS

## What do I use to organize my dotfiles?

I use `stow` (GNU Stow). It is available on almost every distro.

1. Install stow using [homebrew](https://brew.sh/).  

2. Clone this repo  
`git clone https://github.com/thunderthief5/dotfiles-macos.git`

3. Use stow to adopt the home/ folder. This command will place symlinks to all the dotfiles in their appropriate locations in the home directory.  
`cd dotfiles-macos`  
`stow -v --adopt home/`  

4. If you add any new files to your dotfiles folder, you may update it using the restow flag.  
`stow -v --adopt --restow home/`  
