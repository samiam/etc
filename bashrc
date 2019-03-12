# .bash_profile
# $Id: bash_profile,v 1.2 2008/02/01 18:58:33 sam Exp sam $

# If we are not in an interactive shell, then we set up envars and
# return.  No need to prepare shell for an interactive login.
[ ! "$PS1" ] && return 0

# Aliases
case "$(uname -s)" in
  Darwin)  color="-G"
           alias md5sum=md5
           ;;
  Linux)   color="--color"
           ;;
esac

alias ls="ls -CF $color"
alias m=less
alias cp='cp -ip'
alias mv='mv -i'
alias wh='type -a'
alias bcd='builtin cd'
alias jobs='jobs -l'
alias st='set | m'
alias vi='vim'
alias hi='history | m'
alias ppjson='python -m json.tool'

# Functions
# ls after cd
function cd () { 
  builtin cd "$@" && ls
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
shopt -s cmdhist                 # save multi-line cmds in one history entry
shopt -s histappend              # append to history
HISTFILE=$HOME/etc/bash_history  # keep history files separate
HISTCONTROL=ignoredups:erasedups # don't keep duplicate entries in history
HISTFILESIZE=200000  		 # how much to remember on logout?
HISTSIZE=200000  		 # how much to remember in session?

# Program settings
EDITOR=vi                  # what's my favorite editor?
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

#
# Path environment
#
export VBOX_INSTALL_PATH=/Applications/VirtualBox.app/Contents/MacOS
PATH="$HOME/bin:/usr/local/sbin:$PATH:$VBOX_INSTALL_PATH"

# Brew app setup: $(brew --prefix)
brew_prefix="/usr/local"

# chruby
# brew install chruby ruby-install
# https://github.com/postmodern/chruby
if [ -f $brew_prefix/share/chruby/chruby.sh ]; then
  source $brew_prefix/share/chruby/chruby.sh
  source $brew_prefix/share/chruby/auto.sh
fi

# bash-git-prompt
# brew install bash-git-prompt
# https://github.com/magicmonty/bash-git-prompt
if [ -f "$brew_prefix/opt/bash-git-prompt/share/gitprompt.sh" ]; then
  __GIT_PROMPT_DIR=$brew_prefix/opt/bash-git-prompt/share
  GIT_PROMPT_ONLY_IN_REPO=0
  GIT_PROMPT_THEME=Custom
  source "$brew_prefix/opt/bash-git-prompt/share/gitprompt.sh"
fi

# bash-completion
# brew install bash-completion@2
# https://github.com/scop/bash-completion
if [[ -r $brew_prefix/etc/profile.d/bash_completion.sh ]]; then
  export BASH_COMPLETION_COMPAT_DIR=$brew_prefix/etc/bash_completion.d
  source $brew_prefix/etc/profile.d/bash_completion.sh
fi

unset brew_prefix

# pyenv & pyenv-virtualenv
# brew install pyenv pyenv-virtualenv
# brew should point to pyenv versions to avoid duplicates
# ln -s ~/.pyenv/versions $(brew --cellar python@2)
# ln -s ~/.pyenv/versions $(brew --cellar python@3)
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# Heroku
if [ -f $HOME/Library/Caches/heroku/autocomplete/bash_setup ]; then
  source $HOME/Library/Caches/heroku/autocomplete/bash_setup
fi

# ssh
ssh-add -L &> /dev/null
if [ $? -eq 1 ]; then
  ssh-add -K
fi
