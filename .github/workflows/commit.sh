#!/bin/sh

# initialize git with user config
remote_repo="https://${GITHUB_ACTOR}:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"
git config http.sslVerify false
git config user.name "portal-asset-build-bot"
git config user.email "actions@users.noreply.github.com"
git remote add pusher "${remote_repo}"

# push to github
git checkout ${BRANCH_NAME}
git add -A
git reset -- yarn.lock # to ignore yarn lock file being commited
git commit -m "${COMMIT_MESSAGE} -- auto build" --no-verify || exit 0

# since yarn.lock file is not committed it will show as unstaged changes, which will thorw error in pull with rebase
# to discard the same we are adding it to stash and dropping it
git stash
git stash drop 
git pull pusher ${BRANCH_NAME}
git push pusher ${BRANCH_NAME}