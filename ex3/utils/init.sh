#!/bin/sh

set -e

BASE_REPO_GITHUB_URL="https://raw.githubusercontent.com/alonitac/DevSecOpsBIU12/main"
APP_CODE_URL="$BASE_REPO_GITHUB_URL/ex3/utils/app.py"
APP_V1_CODE_URL="$BASE_REPO_GITHUB_URL/ex3/utils/app_v1.py"
APP_V2_CODE_URL="$BASE_REPO_GITHUB_URL/ex3/utils/app_v2.py"


echo "Verifying Git installation..."

git --version > /dev/null

if [ ! $? -eq 0 ]; then
    echo "Git must be installed for this exercise"
    exit 1
fi

echo "Checking no remotes for this Git repo..."

REMOTES=$(git remote -v)
if [ ! -z "$REMOTES" ]; then
  echo "This script should be executed from the local repo you've created. Read instructions carefully!!! "
  exit 1
fi

if ! git checkout -b main; then
  echo "Error: Unable to checkout new branch 'main'"
  exit 1
fi

if ! git add init.sh && git commit -m "add init.sh"; then
  echo "Error: Unable to add and commit init.sh file"
  exit 1
fi

touch .gitignore
echo ".idea" >> .gitignore
echo "venv" >> .gitignore

git add .gitignore && git commit -m "add gitignore"

echo "Creating branches..."


# general branches
git branch bugfix/fix_readme_typo
git branch feature/upgrade_angular_version
git branch feature/data_retention_policy
git branch feature/elasticsearch_helm_chart
git branch bugfix/open_kibana_port

# Changes in working tree and switch branches
git checkout -b dev

echo "a" >> take.txt
echo "b" >> take.txt
echo "c" >> take.txt

git add take.txt && git commit -m "add take.txt in dev"
git checkout main

echo "Creating files for git reset question..."


# Reset
git checkout -b reset_question

for i in $(seq 1 10);
do
    echo "$i" > $i.txt
    git add $i.txt
    git commit -m "$i"
done

git checkout main

echo "Creating conflict scenario..."


# Resolve conflicts
rm -f -r app.py

curl --version

if [ ! $? -eq 0 ]; then
    echo "'curl' cli must be installed for this exercise"
    exit 1
fi

if ! curl -f $APP_CODE_URL -o app.py; then
  echo "Error: Unable retrieve app.py from GitHub"
  exit 1
fi

git add app.py && git commit -m "add app.py"

git checkout -b feature/version1
rm -f -r app.py
if ! curl -f $APP_V1_CODE_URL -o app.py; then
  echo "Error: Unable retrieve app.py from GitHub"
  exit 1
fi

git add app.py && git -c user.name='John Doe' -c user.email='john.doe@microsoft.com' commit -m "John's changes for app.py"

touch .env && git add .env
git -c user.name='John Doe' -c user.email='john.doe@microsoft.com' commit -m "use correct lock type in reconnect()"

touch config.json && git add config.json
git -c user.name='John Doe' -c user.email='john.doe@microsoft.com' commit -m "Restrict the extensions that can be disabled"


git checkout main
git checkout -b feature/version2
rm -f -r app.py
if ! curl -f $APP_V2_CODE_URL -o app.py; then
  echo "Error: Unable retrieve app.py from GitHub"
  exit 1
fi
git add app.py && git -c user.name='Narayan Nadella' -c user.email='narayan.nadella@microsoft.com' commit -m "Nayaran's changes for app.py"

git checkout main


echo
echo
echo "Repo initialized successfully! go ahead with your solution..."
echo
