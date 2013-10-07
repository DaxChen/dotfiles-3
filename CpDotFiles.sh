
#!/bin/sh
unamestr=`uname`
if [ $? = 0 ]; then
  # For dotfiles, we need cp files
  cp .profile .tmux.conf .zshrc .vimrc ~/
  if [[ "$unamestr" == 'Darwin' ]]; then
    # cp osx-only filess
    cp .tmux-osx.conf ~/
  fi
fi
