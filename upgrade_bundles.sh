#!/bin/bash

git submodule foreach <<BASH '
    if [ "$name" = "bundle/vundle" ]; then
        continue
    fi

    if [ "$name" = "bundle/vim-powerline" ]; then
        branch='develop'
    else
        branch='master'
    fi

    git checkout $branch 2> /dev/null
    git pull
'
BASH
