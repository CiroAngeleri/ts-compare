#!/bin/bash

RED='\033[0;31m'

echo "Thanks for checking TS errors 💕"

YOUR_BRANCH=`git rev-parse --abbrev-ref HEAD`

echo "Looking for errors on your branch: $YOUR_BRANCH 🕵️"

ERRORS_ON_YOUR_BRANCH=`npm run check-types` # This should point to your tsc command
COUNT_ON_YOUR_BRANCH_TEXT=`npm run check-types | grep Found`
COUNT_ON_YOUR_BRANCH_SPLIT=($COUNT_ON_YOUR_BRANCH_TEXT)
COUNT_ON_YOUR_BRANCH=${COUNT_ON_YOUR_BRANCH_SPLIT[1]} 


echo "Let's see what master looks like 🕵️"

git fetch --quiet
git checkout master --quiet
git pull origin master --quiet || true

ERRORS_ON_MASTER=`npm run check-types`
COUNT_ON_MASTER_TEXT=`npm run check-types | grep Found`
COUNT_ON_MASTER_SPLIT=($COUNT_ON_MASTER_TEXT)
COUNT_ON_MASTER=${COUNT_ON_MASTER_SPLIT[1]} 

git checkout $YOUR_BRANCH --quiet

echo "Comparing... 🔎"

if [[ $COUNT_ON_YOUR_BRANCH -le $COUNT_ON_MASTER ]]
  then
    echo "No new errors! 🎉"
    exit 0
  else
    DIFF=`diff  <(echo "$ERRORS_ON_YOUR_BRANCH" ) <(echo "$ERRORS_ON_MASTER")`
    echo -e "\n${RED}--- TS ERRORS DIFF --- \n"
    echo "$DIFF"
    echo -e "\n${RED} Your branch has $COUNT_ON_YOUR_BRANCH errors\n"
    echo -e "\n${RED} master branch has $COUNT_ON_MASTER errors\n"
    exit 1
fi