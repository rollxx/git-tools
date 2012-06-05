#!/bin/bash

branches=`git branch | grep -v "\*"`
currentBranch=`git branch | grep "\*" | sed "s/* //"`
merged=""
for branch in $branches; do
    unmerged=`git cherry -v $currentBranch $branch|wc -l`
    if [ $unmerged -gt 0 ]; then
        echo $branch
        git cherry -v $currentBranch $branch
        echo ""
    else
        merged="$merged $branch"
    fi
done

echo "Zu löschen:"
for branch in $merged; do
    echo $branch
done
