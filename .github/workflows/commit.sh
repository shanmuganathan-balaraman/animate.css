#!/bin/sh

# initialize git with user config
remote_repo="https://${GITHUB_ACTOR}:${GITHUB_TOKEN}@github.com/${GITHUB_REPOSITORY}.git"
git config http.sslVerify false
git config user.name "portal-asset-build-bot"
git config user.email "actions@users.noreply.github.com"
git remote add pusher "${remote_repo}"

# push to github
git fetch
git checkout --track origin/${BRANCH_NAME}
git add -A
git commit -m "${COMMIT_MESSAGE} -- auto build" --no-verify || exit 0
git pull --rebase pusher ${BRANCH_NAME}
git push pusher ${BRANCH_NAME}