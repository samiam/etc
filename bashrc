# .bash_profile
# $Id: bash_profile,v 1.2 2008/02/01 18:58:33 sam Exp sam $

# If we are not in an interactive shell, then we set up envars and
# return.  No need to prepare shell for an interactive login.
[ ! "$PS1" ] && return 0

# Aliases
case "$(uname -s)" in
  Darwin)  color="-G"  ;;
  Linux)   color="--color"  ;;
esac
alias ls="ls -CF $color"

# Number files in dir
alias lsc="ruby -e 'ARGV.each { |d|
  puts Dir.open(d).entries.count - 2 if File.directory?(d)
}'"
alias m=less
alias cp='cp -ip'
alias mv='mv -i'
alias wh='type -a'
alias bcd='builtin cd'
alias suu='ssh root@$HOSTNAME'
alias jobs='jobs -l'
alias st='set | m'
alias vi='vim'
alias hi='history | m'
if [ "`uname -s`" = "Darwin" ]; then
   alias md5sum=md5
fi
alias a2ps='a2ps --prologue=fixed --borders=yes'
alias ncat='nc'
alias ppjson='python -m json.tool'

# Functions
# ls after cd
function cd () { 
  builtin cd "$@" && set_prompt && ls
}

function set_prompt {
  if [ ${#PWD} -gt 50 ]; then
    export PS1='\h[\W]\$ '    # short path
  else
    export PS1='\h[\w]\$ '    # set the main prompt
  fi
}

# recursive up function inspired by the non-recursive version of terry jones
function u () { 
  if [ ${1:-1} -gt 0 ]; 
  then 
       builtin cd ..; 
       u $[ $1 - 1 ]; 
  else
       cd .
  fi
}

# Pick one
function zedit () {
  if [ -x $HOME/bin/myedit ]; then
     echo $HOME/bin/myedit
  else
     echo vi
  fi
}

function long_path () {
  tmp=$(pwd)
  if [ ${#tmp} -gt 50 ]; then
    export  PS1='\u@\h[\W]\$ '    # set the main prompt
  fi
}

#
# Shell environment
#
set -a

umask 022               # prohibit group/world write access on new files
PS1='\h[\w]\$ '         # set the main prompt
PS2='again> '           # secondary prompt
set -o emacs            # use emacs command-line editing
set -o monitor          # Job control enabled (exit notification).
set -o notify           # tell me when a background process exits
noclobber=              # don't clobber existing files via redirection
auto_resume=            # resume existing jobs instead of creating new ones
cdable_vars=            # allow shell variables to be cd-able directories
FIGNORE=".o:~"		# don't tab complete on these files

shopt -s checkwinsize   # checks the window size
shopt -s extglob        # extended glob; ls -d *[!.gz] list files w/o .gz ext


# Command history
HISTFILE=$HOME/etc/bash_history  # keep history files separate
HISTCONTROL=ignoredups:erasedups # don't keep duplicate entries in history
command_oriented_history= 	 # save multi-line cmds in one history entry
HISTFILESIZE=200000  		 # how much to remember on logout?
HISTSIZE=200000  		 # how much to remember in session?
shopt -s histappend              # append to history

# Program settings
EDITOR=`zedit`                  # what's my favorite editor?
VISUAL=$EDITOR	

# VI settings  - wm=wrap margins at 70-char
EXINIT='set redraw wm=10 showmode showmatch'

# Less
LESS="-XRqeiPm?f%f:<stdin> .?pb (%pb\%) .?m(file %i of %m)..?e(END) ?x- Next\: %x..%t"
LESSHISTFILE=$HOME/etc/lesshst

# Colorize man pages via less
# https://wiki.archlinux.org/index.php/Man_Page
LESS_TERMCAP_mb=$(printf "\e[1;31m")
LESS_TERMCAP_md=$(printf "\e[1;31m")
LESS_TERMCAP_me=$(printf "\e[0m")
LESS_TERMCAP_se=$(printf "\e[0m")
LESS_TERMCAP_so=$(printf "\e[1;44;33m")
LESS_TERMCAP_ue=$(printf "\e[0m")
LESS_TERMCAP_us=$(printf "\e[1;32m")

set +a

# Clean up local vars
unset -f zedit

# PATH
. ~/etc/verifypath
PATH="$HOME/bin:/usr/local/sbin:$PATH"
export PATH=$(verifypath "$PATH")

# Amazon S3
if [ -f "$HOME/.ssh/aws/s3keys" ]; then
   source "$HOME/.ssh/aws/s3keys"
fi

# Git
if [ -f /usr/local/share/zsh/site-functions/git-completion.bash ]; then
  source /usr/local/share/zsh/site-functions/git-completion.bash
fi

# chruby
if [ -f /usr/local/opt/chruby/share/chruby/chruby.sh ]; then
  source /usr/local/opt/chruby/share/chruby/chruby.sh
  source /usr/local/opt/chruby/share/chruby/auto.sh
fi

# bash-completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
  . $(brew --prefix)/etc/bash_completion
fi
eval "$(direnv hook bash)"

# ssh
ssh-add -L &> /dev/null
if [ $? -eq 1 ]; then
  ssh-add -K
fi

# local
if [ -f $HOME/etc/bash_local ]; then
  . $HOME/etc/bash_local
fi
