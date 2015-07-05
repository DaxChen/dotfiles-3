# some useful alias
export unamestr=`uname`
if [[ "$unamestr" == 'Darwin' ]]; then
  alias ls="ls -aG"
  alias ll="ls -alh"
  alias vim='~/Applications/MacVim.app/Contents/MacOS/Vim'
  alias lock='/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend'
elif [[ "$unamestr" == 'Linux' ]]; then
  alias ls="ls -a --color"
  alias ll="ls -alh"
fi

alias gll="git log --graph --all --pretty=format:\"%C(auto)%w(78,0,8)%h%d %s\" --date=local"
alias glv="git log --graph --all --pretty=format:\"%C(auto)%h%d%n  %Cgreen%ad %Cblue%an%n%w(76,4,2)%s\" --date=local"
