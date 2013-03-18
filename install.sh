#!/bin/bash

cd `dirname $0` > /dev/null

echo 'Installing plugin bundles...'
git submodule update --init

for file in .gvimrc .vimrc
do
    if [[ (-e "$HOME/$file") && (! -L "$HOME/$file") ]]; then
        echo "Backing up $HOME/$file -> $HOME/$file.original"
        cp "$HOME/$file" "$HOME/$file.original"
    fi
    echo "Symbolic linking $HOME/$file -> $PWD/$file"
    ln -sf "$PWD/$file" ~
done

echo 'Generating help tags for plugin bundles...'
vim -Ec "exec 'BundleDocs' | q"
