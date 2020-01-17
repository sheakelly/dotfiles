#!/usr/bin/env bash
set -e # Exit immediately if a command exits with a non-zero status.

INSTALL_DIR=$PWD
BACKUP_DIR=$INSTALL_DIR/backup
echo "Backing up exising file to $BACKUP_DIR"

mkdir -p $BACKUP_DIR
mv $HOME/.zshrc $BACKUP_DIR/.zshrc 2>/dev/null
mv $HOME/.tmux.conf $BACKUP_DIR 2>/dev/null
mv $HOME/.config/nvim $BACKUP_DIR 2>/dev/null

ln -s $INSTALL_DIR/.zshrc $HOME/.zshrc
ln -s $INSTALL_DIR/.tmux.config $HOME/.tmux.config
ln -s $INSTALL_DIR/.config/nvim $HOME/.config/nvim
