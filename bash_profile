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

# Taken from blue:/usr/dist/pkgs/cue/env/std/verifypath and converted to sh
function verifypath () {

     pathlist=`echo $1 | sed 's/:/ /g'`
     if [ -z "$pathlist" ]; then
        echo ""; exit 1;
     fi

     # Remove Redundant Pathnames
     filtered=""
     for nf in $pathlist
     do
       redundant=no
       for f in $filtered
       do
	 if [ "$nf" = "$f" ]; then
	     redundant=yes
	 fi
       done
       if [ "$redundant" != "yes" ]; then
	 filtered="$filtered $nf"
       fi
     done

     pathlist="$filtered"

     # Verify pathlist
     # Validate existing directories
     newpath=""
     for dir in $pathlist
     do
       if [ -d "$dir" ]; then
	 if [ -z "$newpath" ]; then
	     newpath="$dir"
	 else
	     newpath="${newpath}:${dir}"
	 fi
       fi
     done

     # Return Verified Path
     echo $newpath
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
HISTFILE=$HOME/etc/bash_history.$USER  # keep history files separate
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
LESSHISTFILE=$HOME/etc/lesshst
#PRINTER=HP_DESKJET_895C_USB_1
MYSQL_HISTFILE=$HOME/etc/mysql_history.$USER
MAIL=/var/mail/sam
VBOX_USER_HOME=/home/vbox

set +a

#
# Path environment
#

#function ferrari-i386 () {
function blissrun () {
  set -a	 

  # Amazon S3
  if [ -f "$HOME/etc/ec2/s3keys" ]; then
     source "$HOME/etc/ec2/s3keys"
  fi

  # IRB
  IRBRC=$HOME/etc/irbrc

  # /var/lib/gems/1.8/bin/

  set +a
}

function gem_home () {
  tmp=$(gem env | grep INSTALLATION | awk '{ print $NF }')
  echo $tmp
}

# Kernel OS
case "`uname -s`" in
          *)      OSPATH=/usr/local/sbin:/usr/local/bin
                  OSPATH=$OSPATH:/sbin:/usr/sbin:/bin:/usr/bin
                  ;;
esac


# Host OS
case "$HOSTNAME" in
  #ferrari-i386)   $HOSTNAME
  blissrun)   $HOSTNAME
                  HOSTPATH=$EC2_HOME/bin:$JAVA_HOME/bin:$JRUBY_HOME/bin
                  HOSTPATH=$HOSTPATH:`gem_home`/bin
                  ;;
esac

PATH="`verifypath $HOME/bin:$HOSTPATH:$OSPATH:$PATH`"
export PATH

# Clean up local vars
unset HOSTPATH OSPATH
unset verifypath
unset -f ferrari-i386
unset -f zedit
