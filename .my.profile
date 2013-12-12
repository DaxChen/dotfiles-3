export TERM=screen-256color
# Detect OS
# Darwin stands for OSX
unamestr=`uname`
# or we can use $OSTYPE directly
# darwin11.0 stands for OSX 10.8
# some useful export
if [[ "$unamestr" == 'Darwin' ]]; then
  export PATH=./:/usr/local/bin:/usr/local/bin/dot:/opt/local/bin:~/project/storm/bin:~/bin:$PATH
  [ -d /usr/local/share/python ] && PATH=/usr/local/share/python:$PATH
  export PYTHON_PLUGINS=/usr/local/lib/python2.7/site-packages/
elif [[ "$unamestr" == 'Linux' ]]; then
  export PATH=./:/usr/local/bin:/usr/local/bin/dot:/opt/local/bin:/usr/share/zookeeper/bin/:$PATH
  export JAVA_HOME=/usr/lib/jvm/java-7-oracle
fi

export _JAVA_OPTIONS=-Xmx24g

# some useful alias
if [[ "$unamestr" == 'Darwin' ]]; then
  alias ls="ls -aG"
  alias ll="ls -alh"
  alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'
  alias matlab='/Applications/MATLAB_R2011b.app/Contents/MacOS/StartMATLAB'
  alias lock='/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend'
elif [[ "$unamestr" == 'Linux' ]]; then
  alias ls="ls -a --color"
  alias ll="ls -alh"
fi

alias gll="git log --graph --all --oneline --decorate --color"

source ~/.color.sh

if [[ "$unamestr" == 'Darwin' ]]; then
  HOSTNAME='MacbookAir'
fi

# customize the command line prompt
multiline() {
  # uncomment this line only when using bash
  if [ "$WINDOW" != "" ]; then
    printf "\n$bldcyn%s@%s[%d]" "${USER}" "`hostname`" "$WINDOW"
  else
    printf "\n$bldcyn%s@%s" "${USER}" "`hostname`"
  fi
  printf "$txtblk:$bldylw%s$txtrst " "${PWD/#$HOME/~}"
}

## on-my-zsh
PROMPT='$(git_branch)%{$reset_color%}→ '
precmd() {
  print -rP '$(multiline)' 
}

git_branch() {
  # Determine if the working directory is controlled under git
  git rev-parse --is-inside-work-tree >/dev/null 2>&1 && \
    isGitRepo=1 || return

  # Get the branch name
  branchName=`git rev-parse --abbrev-ref HEAD 2>/dev/null`
  [ $branchName = 'HEAD' ] && branchName='unknown'

  # Check if there is unstaged change to tracked files
  git diff --quiet 2>/dev/null || dirty='±'

  # Check if there is untracked files
  [ -n "`git ls-files --others --exclude-standard 2>/dev/null`" ] && \
    dirty=$dirty'?'

  echo "[$branchName$dirty]"
}

# Show info when tmux is running
# If tmux is installed
if command -v tmux >/dev/null 2>&1; then
  # If outside tmux, and there exists some tmux session
  if [ -z "$TMUX" ]; then
    TMUX_LIST=$(tmux ls 2>/dev/null)
    if [ "$TMUX_LIST" ]; then
      echo
      echo '   There are some tmux sessions running in the background:'
      echo "$TMUX_LIST" | sed 's/^/   /'
      echo
    fi
  fi
fi


# Let tmux correctly show 256 colors
export TERM=screen-256color

# Uncomment this to run tmux automatically when opening a terminal
command -v tmux >/dev/null && [ -z "$TMUX" ] && ( tmux ls >/dev/null && tmux attach || tmux new) && exit

if [[ "$unamestr" == 'Darwin' ]]; then
command -v tmux >/dev/null && [ -n "$TMUX" ] && tmux source-file ~/.tmux-osx.conf
# elif [[ "$unamestr" == 'Linux' ]]; then
fi

# Vi mode
#bindkey -v
