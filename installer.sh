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

echo -e "\n\e[39m= Installing devbox =\e[0m\n"
echo -e "\n\e[34m✓ Setting up directories ...\e[0m\n"
mkdir -p $HOME/.devbox/bin

echo -e "\n\e[34m✓ Symlinking commands ...\e[0m\n"
cp $(pwd)/bin/* $HOME/.devbox/bin/
ln -s $HOME/.devbox/bin/* /usr/local/bin/

echo -e "\n\e[34m✓ Preparing envvars ...\e[0m\n"
cp devbox.sh $HOME/.devbox/bin/
echo "export DEVBOX_ROOT_PATH=$(pwd)" > $HOME/.devbox/bin/devbox.sh

echo -e "\n\e[34m✓ Detecting shell and injecting loader ...\e[0m\n"
LOADER="[[ -s \"\$HOME/.devbox/bin/devbox.sh\" ]] && source \"\$HOME/.devbox/bin/devbox.sh\" # load devbox"
SHELLTYPE="$(basename "/$SHELL")"

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

echo -e "\n\e[32m✓ All done. Enjoy!\e[0m\n"
