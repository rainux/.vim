Overview
========

My .vimrc and plugins, plugins are installed as plugin bundles by [vundle](http://github.com/gmarik/vundle).

View .vimrc for key mappings and vundle.vim for installed plugin bundles.

Installation
============

Linux/Unix/Mac OS X
--------------------

Run the following commands in your terminal with bash/zsh:

    cd
    git clone git://github.com/rainux/.vim.git
    cd .vim
    git submodule update --init
    ln -s .vim/.gvimrc ~
    ln -s .vim/.vimrc ~
    vim -Ec "exec 'BundleDocs' | q"

Windows
-------

Run the following commands in cmd.exe:

    cd %HOME%
    git clone git://github.com/rainux/.vim.git
    cd .vim
    git submodule update --init
    copy .gvimrc.win "%HOME%\.gvimrc"
    copy .vimrc.win "%HOME%\.vimrc"
    vim -Ec "exec 'BundleDocs' | q"
