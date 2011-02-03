# .bash_profile
# $Id: bash_profile,v 1.2 2008/02/01 18:58:33 sam Exp sam $

# If we are not in an interactive shell, then we set up envars and
# return.  No need to prepare shell for an interactive login.
[ ! "$PS1" ] && return 0

# Aliases
alias ls='ls -CF'
alias m=less
alias cp='cp -i'
alias mv='mv -i'
alias wh='type -a'
alias suu='ssh root@$HOSTNAME'
if [ "`uname -s`" = "Darwin" ]; then
   alias md5sum=md5
fi

# To see all files _not_ ending in extension. eg. *.gz
# shopt -s extglob; ls -d !(*.gz)

# Functions
# ls after cd
function cd () { 
  builtin cd "$@" && ls; 
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

# Command history
HISTFILE=$HOME/.bash_history.$USER  # keep history files separate
HISTCONTROL=ignoredups	        # don't keep duplicate entries in history
command_oriented_history= 	# save multi-line cmds in one history entry
HISTFILESIZE=20000  		# how much to remember on logout?
HISTSIZE=20000  		# how much to remember in session?

# Program settings
EDITOR=`zedit`                  # what's my favorite editor?
VISUAL=$EDITOR	
# VI settings  - wm=wrap margins at 70-char
EXINIT='set redraw wm=10 showmode showmatch'
LESS="$LESS -RqeiPm?f%f:<stdin> .?pb (%pb\%) .?m(file %i of %m)..?e(END) ?x- Next\: %x..%t" 
MYSQL_HISTFILE=$HOME/.mysql_history.$USER

set +a

# Amazon S3
if [ -f "$HOME/.ssh/aws/s3keys" ]; then
   source "$HOME/.ssh/aws/s3keys"
fi

#
# Path environment
#
PATH="$HOME/bin:$PATH"
export PATH

# Clean up local vars
unset -f zedit

# RVM
if [[ -s '/usr/local/lib/rvm' ]]; then
   source '/usr/local/lib/rvm'
   [[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion

   # Insert colon after prompt b/f path when not using system ruby
   my_rvm_prompt() { [[ -n $(rvm-prompt) ]] && echo "$(rvm-prompt):"; }
   export PS1='\h[$(my_rvm_prompt)\w]\$ '
fi
