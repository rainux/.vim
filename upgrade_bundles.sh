#!/bin/bash
for bundle in bundle/*
do
    if [[ -d $bundle ]] && [[ $bundle != 'bundle/vundle' ]]
    then
        pushd $bundle

        if [[ $bundle == 'bundle/vim-powerline' ]]
        then
            branch='develop'
        else
            branch='master'
        fi

        git checkout $branch
        git pull

        popd
    fi
done
