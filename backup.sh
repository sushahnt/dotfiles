#!/bin/bash

if git diff-index --quiet HEAD --; then
    echo "there is no changes"
else
    git add --all
    git commit -m "backup @ `date`"
    git push origin master
fi

