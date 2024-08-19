#! /bin/bash

git log --all --oneline --reverse --format=%h | \
while read _commit ;  do 
   git checkout $_commit; 
   sleep 2; 
done
git checkout main

