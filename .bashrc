#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export BAT_THEME=gruvbox-dark

alias ls='ls --color=auto'
alias grep='grep --color=auto'

source ~/.config/github_prompt.sh

PROMPT_COMMAND='PS1_CMD1=$(__git_ps1 " (%s)")'; PS1='\[\e[1m\]\$>\[\e[0m\]${PS1_CMD1} '

# Created by `pipx` on 2024-04-23 15:10:09
export PATH="$PATH:/home/pindjouf/.local/bin"

eval "$(register-python-argcomplete pipx)"

############################
# Copied from the internet #
############################
#
#
#                                                          
#                 █                    █                   
#                 █                    █                   
#                 █                    █                   
#                 █▓██   ░███░  ▒███▒  █▒██▒   █▒██▒  ▓██▒ 
#                 █▓ ▓█  █▒ ▒█  █▒ ░█  █▓ ▒█   ██  █ ▓█  ▓ 
#                 █   █      █  █▒░    █   █   █     █░    
#                 █   █  ▒████  ░███▒  █   █   █     █     
#                 █   █  █▒  █     ▒█  █   █   █     █░    
#                 █▓ ▓█  █░ ▓█  █░ ▒█  █   █   █     ▓█  ▓ 
#                 █▓██   ▒██▒█  ▒███▒  █   █   █      ▓██▒ 
#                                                  

# export RANGER_LOAD_DEFAULT_RC=FALSE
export VISUAL=nvim
export EDITOR=nvim
export BROWSER=firefox

#-----------------------------------------------------------------------
#
#                           PROMPT
#-----------------------------------------------------------------------

# Syntactic sugar for ANSI escape sequences
txtblk='\e[0;30m' # Black - Regular
txtred='\e[0;31m' # Red
txtgrn='\e[0;32m' # Green
txtylw='\e[0;33m' # Yellow
txtblu='\e[0;34m' # Blue
txtpur='\e[0;35m' # Purple
txtcyn='\e[0;36m' # Cyan
txtwht='\e[0;37m' # White
bldblk='\e[1;30m' # Black - Bold
bldred='\e[1;31m' # Red
bldgrn='\e[1;32m' # Green
bldylw='\e[1;33m' # Yellow
bldblu='\e[1;34m' # Blue
bldpur='\e[1;35m' # Purple
bldcyn='\e[1;36m' # Cyan
bldwht='\e[1;37m' # White
unkblk='\e[4;30m' # Black - Underline
undred='\e[4;31m' # Red
undgrn='\e[4;32m' # Green
undylw='\e[4;33m' # Yellow
undblu='\e[4;34m' # Blue
undpur='\e[4;35m' # Purple
undcyn='\e[4;36m' # Cyan
undwht='\e[4;37m' # White
bakblk='\e[40m'   # Black - Background
bakred='\e[41m'   # Red
badgrn='\e[42m'   # Green
bakylw='\e[43m'   # Yellow
bakblu='\e[44m'   # Blue
bakpur='\e[45m'   # Purple
bakcyn='\e[46m'   # Cyan
bakwht='\e[47m'   # White
txtrst='\e[0m'    # Text Reset

#-----------------------------------------------------------------------
#  
#                      COLORS FOR MAN PAGES 
#-----------------------------------------------------------------------

export LESS_TERMCAP_mb=$'\e[0;31m'
export LESS_TERMCAP_md=$'\e[0;34m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[0;34;36m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[0;35m'

#-----------------------------------------------------------------------
#                           ALIASES
#-----------------------------------------------------------------------

alias dots='cd ~/Documents/repos/dotfiles/'
alias bx='cd ~/Documents/repos/BXL-Cyber-Camp/'
alias bashrc='nvim ~/.bashrc'
alias reload='source ~/.bashrc'
alias l='ls --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -hFX'
alias ll='ls -l --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias la='ls -la --group-directories-first --time-style=+"%d.%m.%Y %H:%M" --color=auto -F'
alias grep='grep --color=tty -d skip'
alias vim='nvim'
alias cp="cp -i"                          # confirm before overwriting something
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias create='touch Documents/notes/$(date +%F).txt'
alias cat='bat'
# alias rm='rm -i'
