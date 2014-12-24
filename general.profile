# some useful alias
if [[ "$unamestr" == 'Darwin' ]]; then
  alias ls="ls -aG"
  alias ll="ls -alh"
  alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'
  alias lock='/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend'
elif [[ "$unamestr" == 'Linux' ]]; then
  alias ls="ls -a --color"
  alias ll="ls -alh"
fi

alias gll="git log --graph --all --oneline --decorate --color"

