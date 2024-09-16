#  ╔═╗╔═╗╦ ╦╦═╗╔═╗  ╔═╗╔═╗╔╗╔╔═╗╦╔═╗	- z0mbi3
#  ╔═╝╚═╗╠═╣╠╦╝║    ║  ║ ║║║║╠╣ ║║ ╦	- https://github.com/gh0stzk/dotfiles
#  ╚═╝╚═╝╩ ╩╩╚═╚═╝  ╚═╝╚═╝╝╚╝╚  ╩╚═╝	- My zsh conf

#  ┬  ┬┌─┐┬─┐┌─┐
#  └┐┌┘├─┤├┬┘└─┐
#   └┘ ┴ ┴┴└─└─┘
export EDITOR='nvim'
export VISUAL="${EDITOR}"
export BROWSER='firefox'
export HISTORY_IGNORE="(ls|cd|pwd|exit|sudo reboot|history|cd -|cd ..)"
export HYPRSHOT_DIR="$HOME/Pictures/screenshots"
export XDG_PICTURES_DIR="$HOME/Pictures"

if [ -d "$HOME/.local/bin" ] ;
  then PATH="$HOME/.local/bin:$PATH"
fi

export PATH="$PATH:/home/pindjouf/scripts:/usr/local/bin"

#  ┬  ┌─┐┌─┐┌┬┐  ┌─┐┌┐┌┌─┐┬┌┐┌┌─┐
#  │  │ │├─┤ ││  ├┤ ││││ ┬││││├┤ 
#  ┴─┘└─┘┴ ┴─┴┘  └─┘┘└┘└─┘┴┘└┘└─┘
autoload -Uz compinit

for dump in ~/.config/zsh/zcompdump(N.mh+24); do
  compinit -d ~/.config/zsh/zcompdump
done

compinit -C -d ~/.config/zsh/zcompdump

autoload -Uz add-zsh-hook
autoload -Uz vcs_info
precmd () { vcs_info }
_comp_options+=(globdots)

zstyle ':completion:*' verbose true
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS} 'ma=48;5;197;1'
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:warnings' format "%B%F{red}No matches for:%f %F{magenta}%d%b"
zstyle ':completion:*:descriptions' format '%F{yellow}[-- %d --]%f'
zstyle ':vcs_info:*' formats ' %B%s-[%F{magenta}%f %F{yellow}%b%f]-'

#  ┬ ┬┌─┐┬┌┬┐┬┌┐┌┌─┐  ┌┬┐┌─┐┌┬┐┌─┐
#  │││├─┤│ │ │││││ ┬   │││ │ │ └─┐
#  └┴┘┴ ┴┴ ┴ ┴┘└┘└─┘  ─┴┘└─┘ ┴ └─┘
expand-or-complete-with-dots() {
  echo -n "\e[31m…\e[0m"
  zle expand-or-complete
  zle redisplay
}
zle -N expand-or-complete-with-dots
bindkey "^I" expand-or-complete-with-dots
bindkey -v

#  ┬ ┬┬┌─┐┌┬┐┌─┐┬─┐┬ ┬
#  ├─┤│└─┐ │ │ │├┬┘└┬┘
#  ┴ ┴┴└─┘ ┴ └─┘┴└─ ┴ 
HISTFILE=~/.config/zsh/zhistory
HISTSIZE=5000
SAVEHIST=5000

#  ┌─┐┌─┐┬ ┬  ┌─┐┌─┐┌─┐┬    ┌─┐┌─┐┌┬┐┬┌─┐┌┐┌┌─┐
#  ┌─┘└─┐├─┤  │  │ ││ ││    │ │├─┘ │ ││ ││││└─┐
#  └─┘└─┘┴ ┴  └─┘└─┘└─┘┴─┘  └─┘┴   ┴ ┴└─┘┘└┘└─┘
setopt AUTOCD              # change directory just by typing its name
setopt PROMPT_SUBST        # enable command substitution in prompt
setopt MENU_COMPLETE       # Automatically highlight first element of completion menu
setopt LIST_PACKED		   # The completion menu takes less space.
setopt AUTO_LIST           # Automatically list choices on ambiguous completion.
setopt HIST_IGNORE_DUPS	   # Do not write events to history that are duplicates of previous events
setopt HIST_FIND_NO_DUPS   # When searching history don't display results already cycled through twice
setopt COMPLETE_IN_WORD    # Complete from both ends of a word.

#  ┌┬┐┬ ┬┌─┐  ┌─┐┬─┐┌─┐┌┬┐┌─┐┌┬┐
#   │ ├─┤├┤   ├─┘├┬┘│ ││││├─┘ │ 
#   ┴ ┴ ┴└─┘  ┴  ┴└─└─┘┴ ┴┴   ┴
function dir_icon {
  if [[ "$PWD" == "$HOME" ]]; then
    echo "%B%F{#83a598}%f%b"
  else
    echo "%B%F{#83a598}%f%b"
  fi
}

PS1='%B%F{#83a598}%f%b  %B%F{#d3869b}%n%f%b $(dir_icon)  %B%F{#fb4934}%~%f%b${vcs_info_msg_0_} %(?.%B%F{#b8bb26}.%F{#fb4934})%f%b '

#  ┌─┐┬  ┬ ┬┌─┐┬┌┐┌┌─┐
#  ├─┘│  │ ││ ┬││││└─┐
#  ┴  ┴─┘└─┘└─┘┴┘└┘└─┘
source /home/pindjouf/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source /home/pindjouf/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /home/pindjouf/.zsh/zsh-history-substring-search/zsh-history-substring-search.zsh

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

#  ┌─┐┬ ┬┌─┐┌┐┌┌─┐┌─┐  ┌┬┐┌─┐┬─┐┌┬┐┬┌┐┌┌─┐┬  ┌─┐  ┌┬┐┬┌┬┐┬  ┌─┐
#  │  ├─┤├─┤││││ ┬├┤    │ ├┤ ├┬┘│││││││├─┤│  └─┐   │ │ │ │  ├┤ 
#  └─┘┴ ┴┴ ┴┘└┘└─┘└─┘   ┴ └─┘┴└─┴ ┴┴┘└┘┴ ┴┴─┘└─┘   ┴ ┴ ┴ ┴─┘└─┘
function xterm_title_precmd () {
	print -Pn -- '\e]2;%n@%m %~\a'
	[[ "$TERM" == 'screen'* ]] && print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-}\e\\'
}

function xterm_title_preexec () {
	print -Pn -- '\e]2;%n@%m %~ %# ' && print -n -- "${(q)1}\a"
	[[ "$TERM" == 'screen'* ]] && { print -Pn -- '\e_\005{g}%n\005{-}@\005{m}%m\005{-} \005{B}%~\005{-} %# ' && print -n -- "${(q)1}\e\\"; }
}

if [[ "$TERM" == (kitty*|alacritty*|termite*|gnome*|konsole*|kterm*|putty*|rxvt*|screen*|tmux*|xterm*) ]]; then
	add-zsh-hook -Uz precmd xterm_title_precmd
	add-zsh-hook -Uz preexec xterm_title_preexec
fi

#  ┌─┐┬  ┬┌─┐┌─┐
#  ├─┤│  │├─┤└─┐
#  ┴ ┴┴─┘┴┴ ┴└─┘

alias grub-update="sudo grub-mkconfig -o /boot/grub/grub.cfg"

alias vm-on="sudo systemctl start libvirtd.service"
alias vm-off="sudo systemctl stop libvirtd.service"

alias musica="ncmpcpp"

# SSH to home servers
alias con='ssh osmc@192.168.129.5'
alias con2='ssh esau@192.168.129.174'
alias con3='ssh root@192.168.129.187'
alias con4='ssh root@192.168.129.196'

alias dots='cd ~/Documents/repos/dotfiles/; ya'
alias bx='cd ~/Documents/repos/BXL-Cyber-Camp/Redd; ya'
alias repos='cd ~/Documents/repos/; ya'
alias zrc='nvim ~/.zshrc'
alias reload='source ~/.zshrc'
alias l='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -hFX'
alias ll='ls -l --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias la='ls -la --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias grep='grep --color=tty -d skip'
alias vim='nvim'
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias ya='yy'                          # human-readable sizes
alias wgup='wg-quick up pindjouf'
alias wgdown='wg-quick down pindjouf'
alias from='cd ~/Documents/repos/fromthetransistor ; ya'
alias conf='nvim /etc/nixos/configuration.nix'
alias rebuild='sudo nixos-rebuild switch'
alias notes='cd ~/Documents/notes; ya'
alias docs='rustup doc'

# Functions
function bat() {
    local percentage=$(cat /sys/class/power_supply/BAT0/capacity)
    local state=$(cat /sys/class/power_supply/BAT0/status)

    # Gruvbox colors
    local no_color='\033[0m'
    local red='\033[0;31m'
    local green='\033[0;32m'
    local yellow='\033[0;33m'
    local blue='\033[0;34m'

    printf "${blue}[Battery]${no_color}\n"
    if [[ "$state" == "Discharging" ]]; then
        printf "Status: ${red}%s${no_color}\n" "$state"
    else
        printf "Status: ${green}%s${no_color}\n" "$state"
    fi
    if [[ "$percentage" -gt 80 ]]; then
        printf "Your battery is at: ${green}%s%%${no_color}\n" "$percentage"
    elif [[ "$percentage" -le 80 && "$percentage" -ge 20 ]]; then
        printf "Your battery is at: ${yellow}%s%%${no_color}\n" "$percentage"
    else
        printf "Your battery is at: ${red}%s%%${no_color}\n" "$percentage"
    fi
}

function create() {
    local current_date=$(date +%F)
    local current_year=$(date +%Y)
    local current_month=$(date +%B | tr '[:upper:]' '[:lower:]')
    local current_month_n=$(date +%m)
    local current_time=$(date +%r)
    local today=$(date '+%A %B %d')
    local journal_file=~/Documents/notes/journal/"$current_year"/"$current_month_n"."$current_month"/"$current_date.md"  

    cd ~/Documents/notes/journal

    if [ -f "$journal_file" ]; then
        echo "## $current_time" >> "$journal_file"
        echo "" >> "$journal_file"
        echo "" >> "$journal_file"
        nvim "$journal_file"
    else
        echo "# $today" > "$journal_file"
        echo "" >> "$journal_file"
        echo "## $current_time" >> "$journal_file"
        echo "" >> "$journal_file"
        echo "" >> "$journal_file"
        nvim "$journal_file"
    fi
}

function main() {
    local main_file=~/Documents/notes/main.md

    cd ~/Documents/notes

    if [ -f "$main_file" ]; then
        ${EDITOR} "$main_file"
        sed -i -e :a -e '/^\n*$/{$d;N;ba' -e '}' "$main_file"
    else
        echo "# Stuff to keep in mind" >> "$main_file"
        echo "" >> "$main_file"
        echo "## todo" >> "$main_file"
        echo "" >> "$main_file"
        echo "" >> "$main_file"
        ${EDITOR} "$main_file"
    fi
}

function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

#  ┌─┐┬ ┬┌┬┐┌─┐  ┌─┐┌┬┐┌─┐┬─┐┌┬┐
#  ├─┤│ │ │ │ │  └─┐ │ ├─┤├┬┘ │ 
#  ┴ ┴└─┘ ┴ └─┘  └─┘ ┴ ┴ ┴┴└─ ┴ 
#  Make ssh work
# eval `ssh-agent -s` > /dev/null ; ssh-add ~/.ssh/mac > /dev/null 2>&1
bat
