#!/usr/bin/env bash

## Get system info
user="${USER}@$(scutil --get ComputerName)"
distro="macOS $(sw_vers -productVersion)"
kernel="$(uname -sr)"
uptime="$(uptime | sed -E 's/.*up (.*), [0-9]+ users.*/\1/')"
shell="$(basename ${SHELL})"

## Homebrew + Applications count
brew_pkgs() { command -v brew &>/dev/null && brew list | wc -l | xargs || echo "0"; }
apps_pkgs() { find /Applications ~/Applications -type d -name "*.app" 2>/dev/null | wc -l | xargs; }
brew_packages="$(brew_pkgs)"
app_packages="$(apps_pkgs)"

## CPU/GPU details via system_profiler
chipset=$(system_profiler SPDisplaysDataType | awk -F': ' '/Chipset Model/ {print $2; exit}')
gpu_cores=$(system_profiler SPDisplaysDataType | awk -F': ' '/Total Number of Cores/ {print $2; exit}')
gpu="${chipset} (${gpu_cores} cores)"

cpu="$(sysctl -n machdep.cpu.brand_string)"
cores="$(sysctl -n hw.ncpu)"

## RAM usage
ram_total="$(($(sysctl -n hw.memsize) / 1024 / 1024))MiB"
ram_used="$(vm_stat | awk '/Pages active/ {active=$3} /Pages wired down/ {wired=$4} END {print int((active + wired) * 4096 / 1024 / 1024)}')MiB"

WM="Aqua"
envtype="DE"

## Define rainbow colors
bold="$(tput bold)"
reset="$(tput sgr0)"
red="$(tput setaf 1)"
orange="$(tput setaf 208)"
yellow="$(tput setaf 3)"
green="$(tput setaf 2)"
blue="$(tput setaf 4)"
violet="$(tput setaf 5)"

## Output
cat <<EOF

 ${bold}${red}▄▀█ ${orange}█▀█ ${yellow}█▀█ ${green}█░░ ${blue}█▀▀   ${violet}█▀ ${red}█ ${orange}█░░ ${yellow}█ ${green}█▀▀ ${blue}█▀█ ${violet}█▄░█
 ${bold}${red}█▀█ ${orange}█▀▀ ${yellow}█▀▀ ${green}█▄▄ ${blue}██▄   ${violet}▄█ ${red}█ ${orange}█▄▄ ${yellow}█ ${green}█▄▄ ${blue}█▄█ ${violet}█░▀█

 ${bold}${red}USER:      ${red}${user}
 ${bold}${orange}DISTRO:    ${orange}${distro}
 ${bold}${yellow}KERNEL:    ${yellow}${kernel}
 ${bold}${green}UPTIME:    ${green}${uptime}
 ${bold}${blue}${envtype}:        ${blue}${WM}
 ${bold}${violet}SHELL:     ${violet}${shell}
 ${bold}${red}CPU:       ${red}${cpu} (${cores} cores)
 ${bold}${orange}GPU:       ${orange}${gpu}
 ${bold}${green}RAM:       ${green}${ram_used} / ${ram_total}
 ${bold}${blue}PKGS:      ${blue}(${brew_packages}) Brew + (${app_packages}) Apps${reset}

EOF
