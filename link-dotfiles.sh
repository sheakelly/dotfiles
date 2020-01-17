#!/usr/bin/env bash

INSTALL_DIR=$PWD
BACKUP_DIR=$INSTALL_DIR/backup
mkdir -p $BACKUP_DIR

echo "Backing up exising file to $BACKUP_DIR"
mv $HOME/.zshrc $BACKUP_DIR/.zshrc 2>/dev/null
mv $HOME/.tmux.conf $BACKUP_DIR 2>/dev/null
mv $HOME/.config/nvim $BACKUP_DIR 2>/dev/null

echo "Linking dotfiles"
ln -s $INSTALL_DIR/.zshrc $HOME/.zshrc
ln -s $INSTALL_DIR/.tmux.config $HOME/.tmux.config
ln -s $INSTALL_DIR/.config/nvim $HOME/.config/nvim
