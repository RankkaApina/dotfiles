# This file is executed after /etc/zshenv

#----------------------------------------------------------------
# ZSH GENERAL PREFERENCES
#----------------------------------------------------------------

# Setting time style for ls
export TIME_STYLE="+%FT%T%z"

# Set the locale, so that ls sorting is case insensitive
export LC_COLLATE="en_US.UTF-8"

# Fixing MANPATH
export MANPATH=/usr/share/man

# set the zsh to understand the windows terminal can print true color,
# default: xterm-256color
export COLORTERM=truecolor

#----------------------------------------------------------------
# FIGURE OUT ENVIRONMENT
#----------------------------------------------------------------

# I have changed my $USER for work, as I don't want to share it
if [[ "$USER" == "work-username" ]]; then
  export env=work
  export wmnt="/c"
else
  export env=home
  export wmnt="$wmnt"
fi

# This way of getting the win_user requires wslu installed for Debian, Ubuntu comes installed
# Requires wslu to be installed
export WIN_USER=$(wslvar USERNAME)

#----------------------------------------------------------------
# IMPORTANT CONFIG FOLDERS AND FILES
#----------------------------------------------------------------

# FOLDERS THAT OTHER CONFIGS DEPEND ON
#----------------------------------------------------------------

export CONFIGS=$DOT/configs
export REQS=$DOT/reqs/linux
export wapps=$wmnt/Users/$WIN_USER/AppData

# Depend on $CONFIGS
export ENVDIR=$CONFIGS/env/$env
export THEME_DIR=$CONFIGS/themes
# Depend on $ENVDIR
export LOGS=$ENVDIR/logs

# SYSTEM & APP CONFIGS
#----------------------------------------------------------------

# To be able to run sudo with askpass 
export SUDO_ASKPASS=$CONFIGS/term/sudo-askpass

# APT config file (first to run)
export APT_CONFIG=$CONFIGS/term/apt_config

# Set WGETRC variable for wget settings
export WGETRC=$CONFIGS/term/wgetrc

#----------------------------------------------------------------
# PERSONAL FUNCTIONS 
#----------------------------------------------------------------

export CODE_DIR=$DOT/default-code
export MY_FUNCTIONS=$ZDOTDIR/functions
export ZSHRC_FUNCTIONS=$MY_FUNCTIONS/zshrc

# PLUGINS 
#----------------------------------------------------------------

# The important settings
export ZPLUGINDIR=$HOME/.config/zsh/plugins
export PLUGINLIST=$ZDOTDIR/pluginlist

# FUNCTIONS
#----------------------------------------------------------------

# zsh_update_wtscheck timestamps folder
export TSDIR=$HOME/.cache/timestamps

# git repo lists
export COMMON_REPOS=$CONFIGS/git/common-repos
export PULL_REPOS=$ENVDIR/git/pull-repos
export PUSH_REPOS=$ENVDIR/git/push-repos

# Windows Terminal
export WT_DIR=$wapps/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState
export WT_SETTINGS=$CONFIGS/wt/settings_$env.json
export WT_INPUT=$CONFIGS/wt/settings

# VS Code
# NOTE: VS_DIR is defined in .zshrc, because it's dependent on the vs code version defined in the environment settings
export VS_USER_SETTINGS=$CONFIGS/vscode/user_$env.json
export VS_KEYBINDINGS=$CONFIGS/vscode/keybindings.json
export VS_INPUT=$CONFIGS/vscode/settings

#----------------------------------------------------------------
# PATHS
#----------------------------------------------------------------

# Paths
export PATH="$CODE_DIR:$CODE_DIR/js:$CODE_DIR/python:$HOME/.local/bin:/usr/local:$PATH"
export FPATH="$MY_FUNCTIONS:$ZSHRC_FUNCTIONS:$FPATH"

#----------------------------------------------------------------
# LESS IMPORTANT FOLDERS
#----------------------------------------------------------------

export VAULT=$PROJ/memory-alpha
export TEX_SETTINGS=$PROJ/tex/_latex/texmf

export wdl=$wmnt/Users/$WIN_USER/Downloads
export wdoc=$wmnt/Users/$WIN_USER/Documents
export whome=$wmnt/Users/$WIN_USER
export oneD=$wmnt/Users/$WIN_USER/OneDrive
export wnotes=$wmnt/Users/$WIN_USER/Notes



