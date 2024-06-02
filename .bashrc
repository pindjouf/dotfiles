#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
# PS1='[\u@\h \W]\$ '

source ~/.config/github_prompt.sh

PROMPT_COMMAND='PS1_CMD1=$(__git_ps1 " (%s)")'; PS1='\[\e[1m\]\$>\[\e[0m\]${PS1_CMD1} '

export PATH="$PATH:/home/pindjouf/scripts"

# export RANGER_LOAD_DEFAULT_RC=FALSE
# export VISUAL=nvim
export EDITOR=nvim
export BROWSER=firefox

#-----------------------------------------------------------------------
#                           ALIASES
#-----------------------------------------------------------------------

alias dots='cd ~/Documents/repos/dotfiles/'
alias bx='cd ~/Documents/repos/BXL-Cyber-Camp/'
alias repos='cd ~/Documents/repos/'
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
# alias cat='bat'
# alias rm='rm -i'
