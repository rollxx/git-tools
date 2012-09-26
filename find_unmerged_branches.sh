#!/bin/bash

currentBranch=`git branch | grep "\*" | sed "s/* //"`
echo "Looking for branches not being merged to $currentBranch, yet"
branches=`git branch -r | grep -v "\*" | grep -v "\->" | grep -w "backend/feature\|backend/bugfix"`
merged=""
for branch in $branches; do
    unmerged=`git cherry -v "$currentBranch" "$branch"|wc -l`
    if [ $unmerged -gt 0 ]; then
        echo $branch
        git cherry -v "$currentBranch" "$branch"
        echo ""
    else
        merged="$merged $branch"
    fi
done

echo "Merged branches:"
for branch in $merged; do
    echo $branch
done
