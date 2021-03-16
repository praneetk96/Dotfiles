# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
alias s="fzf -e"
alias l="lsd -a"
alias n="nvim"
alias bupdate="bash-it update stable"

#############################################################################
# to fetch system information
#!/bin/sh
host="$(hostname)"
os="$(cat /etc/fedora-release)"
kernel="$(uname -sr)"
uptime="$(uptime -p | sed 's/up //')"
packages="$(yum list installed | wc -l)"
shell="$(basename ${SHELL})"

if [ -z "${WM}" ]; then
	if [ "${XDG_CURRENT_DESKTOP}" ]; then
		envtype='DE'
		WM="${XDG_CURRENT_DESKTOP}"
	elif [ "${DESKTOP_SESSION}" ]; then
		envtype='DE'
		WM="${DESKTOP_SESSION}"
	else
		envtype='WM'
		WM="$(tail -n 1 "${HOME}/.xinitrc" | cut -d ' ' -f 2)"
	fi
else
	envtype='WM'
fi

## DEFINE COLORS

# probably don't change these
bold="$(tput bold)"
black="$(tput setaf 0)"
red="$(tput setaf 1)"
green="$(tput setaf 2)"
yellow="$(tput setaf 3)"
blue="$(tput setaf 4)"
magenta="$(tput setaf 5)"
cyan="$(tput setaf 6)"
white="$(tput setaf 7)"
reset="$(tput sgr0)"

# you can change these
lc="${reset}${bold}${blue}"		# labels
nc="${reset}${bold}${blue}"		# user and hostname
ic="${reset}${bold}${white}"	# info
c0="${reset}${white}"			# first color

## OUTPUT

cat <<EOF
${c0}       _____
${c0}      /   __/  ${nc}${USER}${ic}@${nc}${host}${reset}
${c0}     |  /      ${lc}OS:        ${ic}${os}${reset}
${c0}    _|  |_     ${lc}KERNEL:    ${ic}${kernel}${reset}
${c0}   |_    _|    ${lc}UPTIME:    ${ic}${uptime}${reset}
${c0}     |  |      ${lc}PACKAGES:  ${ic}${packages}${reset}
${c0}   __/  |      ${lc}SHELL:     ${ic}${shell}${reset}
${c0}  /____/       ${lc}${envtype}:        ${ic}${WM}${reset}

EOF
#############################################################################

# If not running interactively, don't do anything
case $- in
  *i*) ;;
    *) return;;
esac

# Path to the bash it configuration
export BASH_IT="/home/praneet/.bash_it"

# Lock and Load a custom theme file.
# Leave empty to disable theming.
# location /.bash_it/themes/
export BASH_IT_THEME='barbuk'

# (Advanced): Change this to the name of your remote repo if you
# cloned bash-it with a remote other than origin such as `bash-it`.
# export BASH_IT_REMOTE='bash-it'

# (Advanced): Change this to the name of the main development branch if
# you renamed it or if it was changed for some reason
# export BASH_IT_DEVELOPMENT_BRANCH='master'

# Your place for hosting Git repos. I use this for private repos.
export GIT_HOSTING='git@git.domain.com'

# Don't check mail when opening terminal.
unset MAILCHECK

# Change this to your console based IRC client of choice.
export IRC_CLIENT='irssi'

# Set this to the command you use for todo.txt-cli
export TODO="t"

# Set this to false to turn off version control status checking within the prompt for all themes
export SCM_CHECK=true
# Set to actual location of gitstatus directory if installed
#export SCM_GIT_GITSTATUS_DIR="$HOME/gitstatus"
# per default gitstatus uses 2 times as many threads as CPU cores, you can change this here if you must
#export GITSTATUS_NUM_THREADS=8

# Set Xterm/screen/Tmux title with only a short hostname.
# Uncomment this (or set SHORT_HOSTNAME to something else),
# Will otherwise fall back on $HOSTNAME.
#export SHORT_HOSTNAME=$(hostname -s)

# Set Xterm/screen/Tmux title with only a short username.
# Uncomment this (or set SHORT_USER to something else),
# Will otherwise fall back on $USER.
#export SHORT_USER=${USER:0:8}

# If your theme use command duration, uncomment this to
# enable display of last command duration.
#export BASH_IT_COMMAND_DURATION=true
# You can choose the minimum time in seconds before
# command duration is displayed.
#export COMMAND_DURATION_MIN_SECONDS=1

# Set Xterm/screen/Tmux title with shortened command and directory.
# Uncomment this to set.
#export SHORT_TERM_LINE=true

# Set vcprompt executable path for scm advance info in prompt (demula theme)
# https://github.com/djl/vcprompt
#export VCPROMPT_EXECUTABLE=~/.vcprompt/bin/vcprompt

# (Advanced): Uncomment this to make Bash-it reload itself automatically
# after enabling or disabling aliases, plugins, and completions.
# export BASH_IT_AUTOMATIC_RELOAD_AFTER_CONFIG_CHANGE=1

# Uncomment this to make Bash-it create alias reload.
# export BASH_IT_RELOAD_LEGACY=1

# Load Bash It
source "$BASH_IT"/bash_it.sh
