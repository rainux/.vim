#!/bin/bash

cd `dirname $0` > /dev/null

echo 'Installing plugin bundles...'
git submodule update --init

echo "Symbolic linking $HOME/.gvimrc -> $PWD/.gvimrc"
ln -sf $PWD/.gvimrc ~

echo "Symbolic linking $HOME/.vimrc -> $PWD/.vimrc"
ln -sf $PWD/.vimrc ~

echo 'Generating help tags for plugin bundles...'
vim -Ec "exec 'BundleDocs' | q"
