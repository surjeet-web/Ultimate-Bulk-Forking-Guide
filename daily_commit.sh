#!/bin/bash

USERNAME="surjeet-web"
FILEPATH="contribution.txt"
COMMITS=10  # number of commits today

# Fetch repos with default branch
mapfile -t REPOS < <(gh repo list $USERNAME --limit 200 --json nameWithOwner,defaultBranchRef \
  -q '.[] | select(.defaultBranchRef != null) | "\(.nameWithOwner) \(.defaultBranchRef.name)"')

for i in $(seq 1 $COMMITS); do
  RANDOM_LINE="${REPOS[$RANDOM % ${#REPOS[@]}]}"
  REPO=$(echo "$RANDOM_LINE" | awk '{print $1}')
  BRANCH=$(echo "$RANDOM_LINE" | awk '{print $2}')

  NOW=$(date '+%Y-%m-%d %H:%M:%S')
  COMMIT_MSG="Daily contribution update $NOW Commit-$i"

  echo "[$NOW] Commit-$i → $REPO ($BRANCH)"

  # Ensure content is base64 without line breaks
  CONTENT=$(echo -n "$NOW Commit-$i" | base64 | tr -d '\n')

  # Check if file exists
  FILE_SHA=$(gh api repos/$REPO/contents/$FILEPATH -F ref=$BRANCH -q '.sha' 2>/dev/null)

  if [ -z "$FILE_SHA" ]; then
    gh api repos/$REPO/contents/$FILEPATH \
      -X PUT -F message="$COMMIT_MSG" -F content="$CONTENT" -F branch="$BRANCH" >/dev/null
  else
    gh api repos/$REPO/contents/$FILEPATH \
      -X PUT -F message="$COMMIT_MSG" -F content="$CONTENT" -F sha="$FILE_SHA" -F branch="$BRANCH" >/dev/null
  fi

  echo "✅ Commit done in $REPO"
  sleep 3  # wait to avoid GitHub rate-limit
done
