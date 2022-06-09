# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# ---------------------------------------------------------------------------
# Setup Prompt

source $HOME/.bash_lib/git-prompt.sh

GIT_PS1_SHOWCOLORHINTS=1
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWDIRTYSTATE=1

__conda_ps1()
{
    if [[ ! -z "$CONDA_PREFIX" ]]; then
        if [[ "$CONDA_PREFIX" == "$HOME/miniconda3" ]]; then
            printf $1 "base"
        else
            printf $1 $(basename $CONDA_PREFIX)
        fi
    fi
}

export -f __conda_ps1

#PS1='\#|\[\e[1;33m\]\j\[\e[m\]|$(echo ${?})'
#if [ $( id -u ) == "0" ]; then
#	PS1=${PS1}'[\[\e[38;5;196m\]\u\[\e[m\]'
#else
#	PS1=${PS1}'[\[\e[38;5;83m\]\u\[\e[m\]'
#fi
# Return code of previous command.
PS1='\[\e[94m\]+--\[\e[0m\] [$(res=$?; [ $res -ne 0 ] && echo "\[\e[1;4;31m\]e:$res\[\e[0m\]" || echo e:$res)]'
# Background jobs, if any.
PS1=${PS1}'$([ \j -gt 0 ] && echo "-[\[\e[1;4;33m\]j:\j\[\e[0m\]]")'
# User and host.
PS1=${PS1}'\[\e[90m\]-\[\e[0m\][\[\e[32m\]\u\[\e[0m\]@\[\e[36m\]\h\[\e[0m\]]'
# Put directory
PS1=${PS1}'\[\e[90m\]-\[\e[0m\][\w]'
# Put git branch (if any)
PS1=${PS1}'$(__git_ps1 "\[\e[90m\]-\[\e[0m\](\[\e[33m\]%s\[\e[0m\])")'
# Put date and time
PS1=${PS1}'\[\e[90m\]-[$(date "+%Y/%m/%d %T")]\[\e[0m\]'
# Put prompt to new line
PS1=${PS1}'\n\[\e[94m\]+->\[\e[0m\] '

PS2="\[\e[94m\]..>\[\e[0m\] "


# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

#if [ "$color_prompt" = yes ]; then
#    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
#else
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#fi
#unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

case $HOSTNAME in
    s-bih-cubi-cs01|s-bih-cubi-cs02|s-bih-cubi-cs03)
        export TMPDIR=/vol/local/scratch/holtgrem/tmp
        mkdir -p ${TMPDIR}
        #module use /bihbi/tools/easybuild/modules/all
        ;;
esac

alias ssh_bihcluster="ssh -A -t bihcluster ssh -A -t 172.16.45.210 qlogin $*"
alias ssh_bihcluster2="ssh -A -t bihcluster ssh -o StrictHostKeyChecking=no -A -t 172.16.45.209 qlogin $*"
alias ssh_bihcluster_login="ssh -A -t bihcluster ssh -A -t 172.16.45.210"
alias ssh_bihcluster_tunnel="ssh -Y -A -l mholtgr ssh1.dv20.mdc-berlin.de -L 4445:172.16.45.210:22"
alias ssh_bihcluster_tunnel2="ssh -Y -A -l mholtgr ssh1.dv20.mdc-berlin.de -L 4445:172.16.45.209:22"

rsync_to_bihcluster()
{
    SRC=$1
    shift
    DEST=$1

    test -z "${SRC}" && { echo "rsync_to_bihcluster SRC DEST"; return 1; }
    test -z "${DEST}" && { echo "rsync_to_bihcluster SRC DEST"; return 1; }

    echo rsync -e \"ssh -p 4445\" -avP ${SRC} mholtgr@localhost:${DEST}
}

export TERM=xterm-256color

#source ~/local/venv/bin/activate
#powerline-daemon -q
#POWERLINE_BASH_CONTINUATION=1
#POWERLINE_BASH_SELECT=1
#. ${HOME}/local/venv/lib/python3.4/site-packages/powerline/bindings/bash/powerline.sh

#export PATH=/bioconda/2018-02/miniconda3/bin:$PATH

# NPM packages in homedir
NPM_PACKAGES="$HOME/.npm-packages"

# Tell our environment about user-installed node tools
PATH="$NPM_PACKAGES/bin:$PATH"
# Unset manpath so we can inherit from /etc/manpath via the `manpath` command
unset MANPATH  # delete if you already modified MANPATH elsewhere in your configuration
MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

# Tell Node about these packages
NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"

export PATH=${HOME}/.npm-packages/bin:$PATH

export GOPATH=$HOME/gocode
export PATH=$GOPATH/bin:$PATH

# Helper for BIH cluster PXE
octoquad()
{
    nums=$(echo $1 | sed -e 's/\./ /g')
    for num in $nums; do
        printf "%2s" $(echo "obase=16;$num" | bc) \
        | sed -e 's/ /0/g'
    done \
    | tr -d '\n'
    echo
}

export -f octoquad

cook-cookie()
{
    outdir=${1-.}
    token=${2-germline}
    cookiecutter -o $outdir gh:bihealth/cookiecutter-isatab-$token
}

export -f cook-cookie

#export CARGO_HOME=/vol/local/programs/cargo
#export RUSTUP_HOME=/vol/local/programs/rustup
#export PATH=$PATH:/vol/local/programs/cargo/bin/

export SENTRY_AUTH_TOKEN=691778fbaf4643988fc63f90eb3a18a00b7871b6687e41269ff39a61ab6f0710

#export SODAR_AUTH_TOKEN=y4jgbnszveu930jf7x9qhf7uc3w7fafz

alias molecule=~/.local/bin/molecule

export IDOIT_USER=systemapi
export IDOIT_PASSWORD=hohj3Bu0
export IDOIT_API_KEY=hag2f5mt1fs4o8o4
export IDOIT_URL=http://172.16.35.131/i-doit

export DJANGO_READ_DOT_ENV_FILE=1

export PATH=$PATH:$HOME/local/bin

/usr/bin/keychain --nogui $HOME/.ssh/id_rsa
source $HOME/.keychain/$HOSTNAME-sh

export PATH=$PATH:$HOME/.local/bin
export GOPATH=${HOME}/go
export PATH=/usr/local/go/bin:${PATH}:${GOPATH}/bin

alias miniconda3="source /opt/miniconda3/bin/activate"

alias run-irods="docker run -p 1247:1247 -p 20000-20019:20000-20019 -p 5432:5432 --detach --name irods mjstealey/irods-provider-postgres:4.2.4"

alias mount-cluster="sshfs transfer-2.research.hpc.bihealth.org:/ /data/sshfs"

export PATH=$PATH:/usr/local/go/bin
export GOROOT=/usr/local/go
export GOPATH=$HOME/go

alias onedrive-pull="rclone sync -i -P charite: $HOME/Documents/Charite_OneDrive"
alias onedrive-push="rclone sync -i -P $HOME/Documents/Charite_OneDrive charite:"
alias onedrive-check="rclone check charite: $HOME/Documents/Charite_OneDrive"
source "$HOME/.cargo/env"

export JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
