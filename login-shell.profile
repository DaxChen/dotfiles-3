source ~/dotfiles/general.profile
# Detect OS
# Darwin stands for OSX
export unamestr=`uname`
# or we can use $OSTYPE directly
# darwin11.0 stands for OSX 10.8
# some useful export
if [[ "$unamestr" == 'Darwin' ]]; then
  #for basictex
  [ -d /usr/texbin ] && export PATH=/usr/texbin:"$PATH"
  #for python
  [ -d /usr/local/share/python ] && export PATH=/usr/local/share/python:$PATH
  export PYTHON_PLUGINS=/usr/local/lib/python2.7/site-packages/
  export PATH=.:$PATH
elif [[ "$unamestr" == 'Linux' ]]; then
  export PATH=.:$PATH
fi

source ~/dotfiles/color.sh

if [[ "$unamestr" == 'Darwin' ]]; then
  HOSTNAME='MacbookAir'
fi

# customize the command line prompt
pre_prompt() {
  # uncomment this line only when using bash
  if [ "$WINDOW" != "" ]; then
    printf "\n$bldcyn%s@%s[%d]" "${USER}" "`hostname`" "$WINDOW"
  else
    printf "\n$bldcyn%s@%s" "${USER}" "`hostname`"
  fi
  printf "$txtblk:$bldylw%s$txtrst " "${PWD/#$HOME/~}"
}

git_branch() {
  # Determine if the working directory is controlled under git
  git rev-parse --is-inside-work-tree >/dev/null 2>&1 && \
    isGitRepo=1 || return

  # Get the branch name
  branchName=`git rev-parse --abbrev-ref HEAD 2>/dev/null`
  [ $branchName = 'HEAD' ] && branchName='unknown'

  # Check if there is unstaged change to tracked files
  dirty=''
  git diff --quiet 2>/dev/null || dirty='±'

  # Check if there is untracked files
  [ -n "`git ls-files --others --exclude-standard 2>/dev/null`" ] && \
    dirty=$dirty'?'

  echo -n "[$branchName$dirty]"
}

## zsh
#PROMPT='$(git_branch)%{$reset_color%}→ '
#precmd() {
#  print -rP '$(pre_prompt)' 
#}

##bash
PROMPT_COMMAND='prompt_gen'
PS1="$(git_branch)→ "
prompt_gen() {
  pre_prompt
  echo
  PS1="$(git_branch)→ "
}

# Since tmux runs automatically when opening a terminal, it doesn't need to show thess message
# Show info when tmux is running
# If tmux is installed
#   if command -v tmux >/dev/null 2>&1; then
#     # If outside tmux, and there exists some tmux session
#     if [ -z "$TMUX" ]; then
#       TMUX_LIST=$(tmux ls 2>/dev/null)
#       if [ "$TMUX_LIST" ]; then
#         echo
#         echo '   There are some tmux sessions running in the background:'
#         echo "$TMUX_LIST" | sed 's/^/   /'
#         echo
#       fi
#     fi
#   fi

# Let tmux correctly show 256 colors
export TERM=screen-256color

# Uncomment this to run tmux automatically when opening a terminal
command -v tmux >/dev/null &&
  if [[ -z "$TMUX" ]]; then
    # echo "Out of tmux"
    AUTO_TMUX=""
    printf "Should attach tmux? (y)\n"
    read -t 1 AUTO_TMUX;
    if [[ "$AUTO_TMUX" == "" || "$AUTO_TMUX" == "y" ]]; then
      printf "Attach!\n"
      ( tmux ls >/dev/null && tmux attach || tmux new)
    else
      printf "Not attch because you input: $AUTO_TMUX\n"
    fi
  else
    # echo "In tmux"
    tmux source-file ~/dotfiles/tmux.conf
    if [[ "$unamestr" == 'Darwin' ]]; then
      tmux source-file ~/dotfiles/tmux-osx.conf
    # elif [[ "$unamestr" == 'Linux' ]]; then
    fi
  fi

# command -v tmux >/dev/null && [ -z "$TMUX" ] && ( tmux ls >/dev/null && tmux attach || tmux new) && exit
# command -v tmux >/dev/null && [ -n "$TMUX" ] && tmux source-file ~/dotfiles/tmux.conf
# if [[ "$unamestr" == 'Darwin' ]]; then
#   command -v tmux >/dev/null && [ -n "$TMUX" ] && tmux source-file ~/dotfiles/tmux-osx.conf
# # elif [[ "$unamestr" == 'Linux' ]]; then
# fi
