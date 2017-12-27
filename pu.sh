#!/bin/bash

if git diff-index --quiet HEAD --; then
    echo "no changes were made :)"
else
    git add --all
    git commit -m "backup @ `date`"
    git push origin master
fi

