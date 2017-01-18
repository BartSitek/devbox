#!/bin/bash

#                  ,$$$$$',$$$$$',$$$$$'
#                 ,$$$$$',$$$$$',$$$$$'           - - -- ---- ✈
#                ,$$$$$',$$$$$',$$$$$'   ᕦ(ò_óˇ)ᕤ いきましょう！
#               ,s$$$$',$$$$$',$$$$$'
#              ,$$$$$',$$$$$',$$$$$'       SΙΤΞΚ SYSTΞMS ©1985
#             ,$$$$$',$$$$$',$$$$$'

#             Disclaimer: This SOFTWARE PRODUCT is provided
#             by THE PROVIDER "as is", with all faults and
#             without warranty of any kind.

#             SΙΤΞΚ SYSTΞMS ©1985. All rights Reserved.

#///////////////////////////////////////////////////////////////////////////////

# `source installer.sh` to install
# https://github.com/rcaloras/bash-preexec

function default() {
  echo -e "\n\033[39m  📦  Setting up Devbox. Stand by ...\033[0m"

  if [ -d "$HOME/.devbox" ]; then
    echo -e "\n\033[39m---> Previous installation found. Cleaning up ...\033[0m"
    rm -rf $HOME/.devbox
    rm /usr/local/bin/devbox
  fi

  echo -e "\n\033[39m---> Setting up directories ...\033[0m"
  mkdir -p $HOME/.devbox/bin

  echo -e "\n\033[39m---> Symlinking commands ...\033[0m"
  cp $(pwd)/bin/* $HOME/.devbox/bin/
  ln -sfn $HOME/.devbox/bin/* /usr/local/bin/
  # ln -sfn $(pwd)/bin/* /usr/local/bin/ # enable for debugging ...

  echo -e "\n\033[39m---> Preparing envvars ...\033[0m"
  cp loader.sh $HOME/.devbox/
  echo "export DEVBOX_ROOT_PATH=$(pwd)" > $HOME/.devbox/loader.sh

  echo -e "\n\033[39m---> Detecting shell and injecting loader ...\033[0m"
  LOADER="[[ -s \"\$HOME/.devbox/loader.sh\" ]] && source \"\$HOME/.devbox/loader.sh\" # load devbox"

  if [ "$SHELLTYPE" = "bash" ]; then
    if [ -f "$HOME/.bashrc" ]; then
      echo $LOADER >> $HOME/.bashrc
      source $HOME/.bashrc
    elif [ -f "$HOME/.bash_profile" ]; then
      echo $LOADER >> $HOME/.bash_profile
      source $HOME/.bash_profile
    fi
  elif [ "$SHELLTYPE" = "zsh" ]; then
    echo $LOADER >> $HOME/.zshrc
    source $HOME/.zshrc
  fi

  # echo -e "\n\033[32m✓ All done. Enjoy!\033[0m\n"
  echo -e "\n\033[39m  🎯  All done. Enjoy!\033[0m\n"
}

function remove() {
  # if [ -d "$HOME/.devbox" ]; then
    echo -e "\n\033[39m  📦  Removing Devbox. Stand by ...\033[0m"
    echo -e "\n\033[39m---> Cleaning up ...\033[0m"
    # rm -rf $HOME/.devbox
    # rm /usr/local/bin/devbox
    echo -e "\n\033[39m  ♻️  All clean. Sorry to see you go!\033[0m\n"
  # fi
}

function helpmenu() {
  echo -e "\n\033[39m📦  Devbox\033[0m"
  echo -e "\n\033[39mUsage:\033[0m"
  echo -e "\033[39m  --help, -h                       Show this message\033[0m"
  echo -e "\033[39m  --remove, -r                     Uninstall devbox\033[0m"
  echo -e ""
}

#///////////////////////////////////////////////////////////////////////////////

#  ARGUMENT LOGIC

#///////////////////////////////////////////////////////////////////////////////
# http://stackoverflow.com/questions/192249/how-do-i-parse-command-line-arguments-in-bash
# http://wiki.bash-hackers.org/howto/getopts_tutorial

while [ ! $# -eq 0 ]; do
  case "$1" in
    --help | -h)
      helpmenu
      exit
      ;;
    --remove | -r)
      remove
      exit
      ;;
  esac
  shift
done

if [ $# -eq 0 ]; then
  default
  exit
fi
