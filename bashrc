# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

# Prompt
# [ <red>Date Time</red> <blue>user</blue><yellow>@server</yellow> <green>cwd</green> ] <magenta>jobs</magenta> <green>$</green>
PS1="[ \[\033[1;31m\]\d \t \[\033[1;34m\]\u\[\033[1;33m\]@\h \[\033[1;32m\]\w \[\033[0m\]] \[\033[1;35m\]\j \[\033[1;32m\]\$ \[\033[0m\]"

export EDITOR="emacs"

# Colors for ls
# OS X is stupid and has non-standard options
if [[ `uname` == "Darwin" ]]; then
    alias ls='ls -G'
else
    alias ls='ls --color=auto'
fi
alias grep='grep --color=auto'

function mdless() {
    # h/o http://blog.metamatt.com/blog/2013/01/09/previewing-markdown-files-from-the-terminal/
    filename=$1
    pandoc -s -f markdown -t man "$filename" | groff -T utf8 -man | less
}

# If a command starts with a space it won't get saved to history
export HISTCONTROL=ignorespace

# Diff two directories with corresponding files (meaning /foo/a is checked against /bar/a, and so on)
alias diff-dir='diff -ENwbur'

# Load site-specific configuration options
[ -e ~/.bashrc_local ] && source ~/.bashrc_local
