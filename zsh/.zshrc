#!/bin/zsh

#----------------------------------------------------------------
# ADD ENVIRONMENT
#----------------------------------------------------------------

autoload -Uz ${ZSHRC_FUNCTIONS}/*(:t)

# Add environment specific variables
zsh_add_env

# Define color theme 
zsh_add_theme

#----------------------------------------------------------------
# ZSH FUNCTIONALITY
#----------------------------------------------------------------

# Disable zsh from changing the terminal title
DISABLE_AUTO_TITLE="true"

# Setting preferences
setopt NO_CASE_GLOB # Ignore case when searching with tab, opposite: GLOB_COMPLETE
setopt autocd extendedglob
unsetopt beep

# Key-bindings
bindkey -e
bindkey -r "^u"
bindkey -r "^d"
# For zsh-history-substring-search, if not working, run: cat -v in terminal and see what up and down arrow print
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

bindkey '^a' beginning-of-line
bindkey '^e' end-of-line

# completions
zstyle :compinstall filename '$ZDOTDIR/.zshrc'
autoload -Uz compinit
compinit -d $LOGS/.zcompdump

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# Colors
autoload -Uz colors && colors

#----------------------------------------------------------------
# ZSH HISTORY
#----------------------------------------------------------------

HISTFILE=${LOGS:-$HOME}/.zsh_history # Saves history file explicitely
export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
export LESSHISTFILE=$LOGS/.lesshst
HIST_STAMPS='yyyy-mm-dd'

setopt EXTENDED_HISTORY
setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt INC_APPEND_HISTORY
setopt HIST_REDUCE_BLANKS   
setopt HIST_IGNORE_ALL_DUPS 

#----------------------------------------------------------------
# LOAD FUNCTIONS
#----------------------------------------------------------------

zsh_autoload zsh
zsh_autoload apps
zsh_autoload git
zsh_autoload dev

#----------------------------------------------------------------
# VS Code
#----------------------------------------------------------------

export VS_USER=$wmnt/Users/$WIN_USER/AppData/Roaming/$VS_ROAM/User
export VS_EXT=$wmnt/Users/$WIN_USER/$VS_DOT/extensions

#----------------------------------------------------------------
# ADD SPECIAL CONFIGURATIONS
#----------------------------------------------------------------

zsh_add_zdotfile "code-config"
zsh_add_zdotfile "special-config"

#----------------------------------------------------------------
# LOAD FUNCTIONS AND PLUGINS
# Currently omz plugins are not working
#----------------------------------------------------------------

# Aliases: some use env variables
zsh_add_zdotfile "zsh-aliases"

# Load the plugins from $PLUGINLIST
zsh_load_plugins

#----------------------------------------------------------------
# KEEP THESE LAST!!!
#----------------------------------------------------------------

# Add any env specific "last commands"
zsh_add_envfile env_lastcommands

# Remove possible duplicates from path and fpath (caused by reloading this file)
typeset -U path
typeset -U fpath

# Update distro + check and update oh-my-posh if needed
zsh_start_update
