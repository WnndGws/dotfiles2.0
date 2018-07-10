#. ------------------ #
# >>>>> EXPORTS <<<<< #
#. ------------------ #
export EDITOR=/usr/bin/vim
export MANPAGER="/bin/sh -c \"col -b | vim --not-a-term -c 'set ft=man ts=8 nomod nolist noma' -\""
export VISUAL=/usr/bin/vim
#Sets environment variables

export XDG_CACHE_HOME=$HOME'/.cache'
export XDG_CONFIG_HOME=$HOME'/.config'
export XDG_DATA_HOME=$HOME'/.local/share'
#Sets all my XDG paths

export BROWSER=$HOME/Git/OneOffCodes/Shell/dmenu_openwith_prompt.sh
export CARGO_HOME="$XDG_DATA_HOME"/cargo
export FZF_DEFAULT_COMMAND='rg --files --hidden --smart-case --glob "!.git/*"'
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtkrc
export GNUPGHOME="$XDG_CONFIG_HOME"/gnupg
export GPG_TTY
export ICEAUTHORITY="$XDG_RUNTIME_DIR"/ICEauthority
export IPYTHONDIR="$XDG_CONFIG_HOME"/ipython
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history
export LESSKEY="$XDG_CONFIG_HOME"/less/lesskey
export MAILCAPS="$XDG_CONFIG_HOME"/mailcap/mailcap
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
export PYLINTRC="$XDG_CONFIG_HOME"/pylint/pylintrc

export RTV_BROWSER=$HOME/Git/OneOffCodes/Shell/dmenu_openwith_prompt.sh
export RTV_URLVIEWER=/usr/bin/urlscan
#Export RTV

GPG_TTY=$(tty)
if [ ! -e ~/.ssh/agentsock ]; then
    eval $(ssh-agent -a ~/.ssh/agentsock)
    ssh-add
else
    export SSH_AUTH_SOCK=~/.ssh/agentsock
fi
#. ---------------------- #
# >>>>> END EXPORTS <<<<< #
#. ---------------------- #

#. ------------------- #
# >>>>> SOURCING <<<<< #
#. ------------------- #
## Init fasd from cache if it exists
fasd_cache=$XDG_CACHE_HOME/fasd-init-zsh
if [ "$(command -v fasd)" -nt "$fasd_cache" -o ! -s "$fasd_cache" ]; then
  fasd --init posix-alias zsh-hook zsh-ccomp zsh-ccomp-install zsh-wcomp zsh-wcomp-install >| $fasd_cache
fi
source $fasd_cache
unset fasd_cache
#FASD

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
#FZF
#. ----------------------- #
# >>>>> END SOURCING <<<<< #
#. ----------------------- #

#. ------------------- #
# >>>>> SETTINGS <<<<< #
#. ------------------- #
HISTFILE=~/.config/zsh/histfile
#Lines configured by zsh-newuser-install

HISTSIZE=100000
#Save 1000 items in history

SAVEHIST=100000
#Save 1000 items in history

setopt EXTENDED_HISTORY
#Write the history file in the ":start:elapsed;command" format

setopt INC_APPEND_HISTORY
#Write to the history file immediately, not when the shell exits

setopt SHARE_HISTORY
#Share history between all sessions

setopt HIST_SAVE_NO_DUPS
#Don't write duplicate entries in the history file

setopt HIST_EXPIRE_DUPS_FIRST
#Expire duplicate entries first when trimming history

setopt HIST_IGNORE_DUPS
#Don't record an entry that was just recorded again

setopt HIST_IGNORE_ALL_DUPS
#Delete old recorded entry if new entry is a duplicate

setopt MENU_COMPLETE
#Completes the first in list of ambiguous completions

bindkey -v
#Explicitly sets keys to vim mode

zstyle :compinstall filename '~/.zshrc'
#Load completions from this file since they are handled by oh-my-zsh

autoload -Uz compinit

#Checking the cached zcompdump can be slow making zsh startup slow
#Check only once an hour
if [[ -a $HOME/.zcompdump(#qN.mh+1) ]]; then
    compinit
else
    compinit -C
fi
#Enables zsh autocompletions of commands
#. ---------------------- #
# >>>>> END SETTINGS <<<<<#
#. ---------------------- #

#. ------------------------ #
# >>>>> USER SETTINGS <<<<< #
#. ------------------------ #
[[ $- != *i* ]] && return
#If not running interactively, don't do anything

PS1='[%n@%M %d]$ '

CDPATH=.:..:~:~/Git
#When type cd it will look for folder in cwd, parent, home, or git

fancy-ctrl-z () {
  if [[ $#BUFFER -eq 0  ]]; then
      BUFFER="fg"
      zle accept-line -w
    else
        zle push-input
        zle clear-screen
    fi
}
zle -N fancy-ctrl-z
bindkey '^Z' fancy-ctrl-z
#When ctrl-z out of vim can ctrl-z back in

set RANGER_LOAD_DEFAULT_RC false
#Dont want to load deafult AND mine, only mine

autoload -U edit-command-line
zle -N edit-command-line
bindkey -M vicmd v edit-command-line
#Enable 'v' in normal mode to edit command line
#Edit commands by pressing v when in normal mode
#. --------------------------- #
# >>>>> END USER SETTINGS <<<<<#
#. --------------------------- #

#. ----------------------------- #
# >>>>> OH MY ZSH SETTINGS <<<<< #
#. ----------------------------- #
export PATH=$HOME/bin:/usr/local/bin:$HOME/Git/OneOffCodes/Python/myman:$PATH
#Path includes path to all scripts i want to run natively

ZSH=/usr/share/oh-my-zsh
#Path to your oh-my-zsh installation.

ZSH_CUSTOM=~/.oh-my-zsh/custom
#Custom path for oh-my-zsh

ZSH_THEME="spaceship"
#Name of theme, can be "random"

CASE_SENSITIVE="false"
#Case sensitive completions are different commands

ENABLE_CORRECTION="false"
#Don't autocorrect

COMPLETION_WAITING_DOTS="true"
#Display red dots while waiting for completions

ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh-cache
#Set cache location, create if doesn't exist

if [[ ! -d $ZSH_CACHE_DIR ]]; then
    mkdir $ZSH_CACHE_DIR
fi

plugins=(
 django\
 zsh-completions\
 safe-paste\
 history-substring-search\
 zsh-autosuggestions\
 archlinux\
 pip\
 python\
 zsh-syntax-highlighting\
 alias-tips\
 auto-ls\
 zsh-interactive-zsh
)
#Plugins can be found in ~/.oh-my-zsh/plugins/*
#Plugins can be found in ~/.oh-my-zsh/custom/plugins/* (NB. extension must be ".plugin.zsh")

bindkey "^[[A" history-substring-search-up
#Search through history with arrow keys

bindkey "^[[B" history-substring-search-down
#Search through history with arrow keys

source $ZSH/oh-my-zsh.sh
#Source oh-my-zsh for settings to take effect

spaceship_vi_mode_enable
#Explicitly enable vi mode

export KEYTIMEOUT=1
#By default, there is a 0.4 second delay after you hit the <ESC> key and when the mode change is registered. This results in a very jarring and frustrating transition between modes. Let's reduce this delay to 0.1 seconds.

bindkey "^[^M" autosuggest-accept
#Let me enter without needing to complete

#. ----------------------------------#
# >>>>> END OH MY ZSH SETTINGS <<<<< #
#. ----------------------------------#

#. ------------------ #
# >>>>> ALIASES <<<<< #
#. ------------------ #
alias archdate='pakku -Syyuu; pakku -T; wget -O /etc/hosts https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews/hosts; cat /etc/hosts.spotify >> /etc/hosts; polybar-msg cmd restart'
alias ad="archdate"
#Update command

alias attach_monitor_right='xrandr --output LVDS-1 --primary --mode 1366x768 --pos 0x312 --rotate normal --output DP-1-1 --off --output HDMI-1-1 --auto --pos 1366x0 --rotate normal'
#alias attach_monitor_left='xrandr --output LVDS1 --auto --primary --output HDMI-1-1 --auto --left-of LVDS-1'
#Attaches a second screen if it exists

alias bing_wallpaper="$HOME/Git/OneOffCodes/Python/wallpaper_maker/wallpaper_maker.py change_wallpaper --bing --quote-file $HOME/Git/OneOffCodes/Python/wallpaperMaker/quotes.txt"
#Set my bing wallpaper

alias bluesink='$HOME/Git/OneOffCodes/Expects/bluetooth_connect_ticpods.exp && pactl set-card-profile bluez_card.00_11_B1_01_BE_1E a2dp_sink'
#Attaches and sets bluetooth headphones as sink out

alias bluetooth_nexus='$HOME/Git/OneOffCodes/Expects/bluetooth_connect_nexus6p.exp'
#Connect to phone bluetooth

alias calc="gcalcli --monday --detail_length --refresh calw"
#Outputs google calendar

alias calcadd="gcalcli add --calendar 'Personal Calendar'"
#Add events to calendar

alias clean_latex="fd -e aux -e bbl -e bcf -e blg -e fdb_latexmk -e fls -e log -e out -e xml -e gz -e xdv | xargs -I{} rm -f {}"
#Remove lint latex files

alias clip="xclip -o -sel clip | xsel -p"
alias paste="xclip -o -sel clip"
#Copies the content of PRIMARY buffer to clipboard so I can paste outside urxvt

alias cm="centerim5"
#Saves typing

alias cl='$HOME/Git/OneOffCodes/Shell/Compile_Latex.sh'
#Compile and open latex

alias dm='$HOME/Git/dotfiles2.0/.files/dotmake.sh'
#Saves typing

alias failed_ctl='systemctl list-units --state=failed'
#To list any failed systemctl units

alias gi="cat $HOME/Git/dotfiles2.0/.files/gitignores.txt >> .gitignore"
#Create a gitignore file

alias git_push_all="~/Git/OneOffCodes/Shell/gitPushAll.sh"
alias gtpa="~/Git/OneOffCodes/Shell/gitPushAll.sh"
#Use script to push everything in all my repos

alias git_push='git add -p . && git commit -aS && git pull && git push'
alias gtp='git add -p . && git commit -aS && git pull && git push'
#Add, commit, and push git in one command

alias gm='$HOME/Git/OneOffCodes/Python/gifmaker/gifmaker.py make_gif'
#Make webms from videos

alias gpg_encrypt="~/Git/OneOffCodes/Shell/gpgEncrypt.sh"
#GPG encrypt a file to the recipient and myself

alias hn="haxor-news"
#Saves typing

alias largest_files="~/Git/OneOffCodes/Shell/largestFiles.sh"
#Lists the 10 largest files in a given dir

alias largest_folders="~/Git/OneOffCodes/Shell/largestFolders.sh"
#Lists the 10 largest folders in a given dir

alias latex_shortcuts="cat $HOME/.vimrc | rg 'autocmd FileType tex inoremap.*' | cut -d';' -f2"
#Prints tha latex shortcuts I have in my vimrc

alias lg='vim "+Gist -l"'
#Lists Gists

alias lock="~/Git/OneOffCodes/Shell/lock.sh"
#Locks PC and mutes

alias lsa='exa --all --color always --color-scale'
#List all including hidden

alias lsl='exa --all --color always --color-scale --long'
#List all including hidden in a long list

alias ls='exa --color always --color-scale'
#Colours in ls

alias md2pdf='$HOME/Git/OneOffCodes/Shell/md2pdf.sh'
#Use my own script using pandoc

alias mm='myman try_tldr --program'
#Uses vimman instead of normal man

alias mkdir='mkdir -p'
#Create parent folders if doesnt exists

alias mount_phone='simple-mtpfs --device 1 /mnt/Nexus6p'
alias mp='mount_phone'
alias unmount_phone='fusermount -u /mnt/Nexus6p'
#Allows me to mtp mount and unmount phone easily

alias nb='newsboat'
#Saves typing

alias nf="neofetch"
#Neofetch

alias nm='offlineimap -o && offlineimap -u quiet & neomutt && killall -9 offlineimap'
#Saves typing

alias open="xdg-open"
alias o='fasd -a -e xdg-open' 
#Quick opening files with xdg-open

alias paorph='pacman --query --unrequired --deps --quiet'
#Pacaur orphans

alias play_DCAU="~/Git/OneOffCodes/Shell/playlistPlay.sh ~/wynZFS/Media/WatchOrders/DCAU.order"
#Plays the next episode in the DCAU that I am up to

alias playlist_play="~/Git/OneOffCodes/Shell/playlistPlay.sh"
#Use to play .order files so can watch overlapping shows in correct order. Searches and plays 1st line in a file. If multiples found presents them. Offers choice whether want to move played file to bottom
#Relys on custom 'lsgrep' function

alias post_lands="~/Git/OneOffCodes/Shell/postLands.sh"
#Puts computer back into its "normal" state
alias pre_lands="~/Git/OneOffCodes/Shell/preLands.sh"
#Gets computer ready for online games

alias rcp="~/Git/OneOffCodes/Shell/rcp.sh"
#Uses rsync to copy, allows me to be able to copy using wildcards
alias rmv="~/Git/OneOffCodes/Shell/rmv.sh"
#Uses rsync to move, allows me to be able to move using wildcards

alias rm='trash -riv'
#Prompt when removing files, force recursive

alias rs='rainbowstream'
#Saves typing

alias rsync="rsync -vrhP"
#I always use rsync with these flags

alias sab_ssh_tun='ssh -L 8080:localhost:8080 gouws.com.au -N'
alias sonar_ssh_tun='ssh -L 8081:localhost:8081 gouws.com.au -N'
alias torrent_ssh_tun='ssh -L 8082:localhost:8082 gouws.com.au -N'
#Create ssh tunnels to my localhosts

alias scim="sc-im"

alias shutdown_at="~/Git/OneOffCodes/Shell/shutdownAt.sh"
#Allows user to enter shutdown_in hh:mm:ss and gives a countdown
alias shutdown_in="~/Git/OneOffCodes/Shell/shutdownIn.sh"
#Allows user to enter shutdown_in hh:mm:ss and gives a countdown
alias shutdown="~/Git/OneOffCodes/Shell/dmenu_yn_prompt.sh 'Do You want to shut down?' \"~/Git/OneOffCodes/Shell/shutdownIn.sh 0:05\""
#Is the same as normal shutdown, except instead of just saying a min it counts down. Much more convenient

alias //="sudo"
#Use as Sudo

alias suspend="_ rtcwake --date +1month -m mem; ~/Git/OneOffCodes/Shell/lock.sh; _ systemctl restart openvpn.service"
#Use rtc wake as suspend

alias p='pakku -Ss'
#Minimize keystrokes
alias pare='pakku -R'
#Remove package using pacman
alias pin='pakku -S --noconfirm'
#Trizen install

alias time='hyperfine'
#Use hyperfine to time commands

alias tpoff='synclient "TouchpadOff"=1'
alias tpon='synclient "TouchpadOff"=0'
#Turns touchpad off and on

alias udm="udiskie-mount -a"
alias udum="udiskie-umount --detach -a"
#Udiskie

alias un:pw="cat /dev/urandom | tr -dc 'a-zA-Z0-9-_!@#$%^&*()_+{}|:?=' | fold -w 8 | grep '[!@#$%^&*()_+{}|:?=]' | head -n 1; cat /dev/urandom | tr -dc 'a-zA-Z0-9-_!@#$%^&*()_+{}|:?=' | fold -w 32 | grep '[!@#$%^&*()_+{}|:?=]' | head -n 1"
#Echo out a 8 char un and 32 char pw

alias v='fasd -f -e vim' 
#Quick opening files with vim

alias vd="_ systemctl stop --now openvpn.service"
alias vu="_ systemctl restart --now openvpn.service"
#Aliases for VPN up or down

alias vw="vim \"+VimwikiUISelect\""
#Opens my Vimwiki

alias ww="cd $HOME/Git/WnndGws.github.io; fd . -e md -x pandoc -s -f markdown -t html5 -o '{/.}.html' '{/.}.md' -c pandoc.css -c zenburn.css"
#WynWiki's my markdown files to html

alias y='streamlink --player "mpv --force-seekable=yes --hr-seek=yes --hr-seek-framedrop=yes --speed=1.2 --no-terminal --force-window --demuxer-thread=yes --demuxer-readahead-secs=180"'
#Plays youtube videos in non-seethrough mpv

alias youtube-ul="~/Git/OneOffCodes/Shell/youtubeUL.sh"
alias ytul="youtube-ul"
#Uploads files to youtube

alias ytdl="youtube-dl"
#Youtube Upload

alias yv='youtube-viewer --results=50 --order=date'
#Alias for youtube viewer

alias zsh_time='time "zsh -i -c exit"'
alias zt='zsh_time'
#Times my zsh load time

fo() { vim $(fzf --no-multi --query="$1"); }
fc() { cd $(dirname $(fzf +m -q "$1")); }
#Using fzf to find and open files/dirs
#. -------------------- #
# >>>>>END ALIASES<<<<< #
#. -------------------- #
