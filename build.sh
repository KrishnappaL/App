#!/bin/bash
REMOTE=origin
BRANCH=main
git fetch
if [[ "$(git rev-parse $BRANCH)" != "$(git rev-parse "$REMOTE/$BRANCH")" ]]; then
	echo "change found on remote"
else
	echo "no change"
fi
