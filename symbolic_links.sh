#!/bin/env zsh

apps=( nano zsh )

for i in $apps; do
    rcfile=".$i"rc
    source=~/dotfiles/$i/$rcfile
    target=~/$rcfile
    [[ -f $target ]] && {
      echo "skipping: $i"
      echo "$target alredy exist"
    } || {
      echo "Creating symbolic for: $i"
      echo "Source: $source"
      echo "Target: $target"
      ln -s $source $target
    }
done
