#!/bin/bash

USERNAME="surjeet-web"
EMAIL="codieshiv.web@gmail.com"
FILEPATH="contribution.txt"

# Date range
START_DATE="2024-01-01"
END_DATE="2025-04-30"

# Get all repos and branches as lines
mapfile -t REPOS < <(
  gh repo list "$USERNAME" --limit 200 --json nameWithOwner,defaultBranchRef \
    -q '.[] | "\(.nameWithOwner) \(.defaultBranchRef.name)"'
)

# Loop through each date
current_date="$START_DATE"
while [ "$(date -d "$current_date" +%Y-%m-%d)" != "$(date -d "$END_DATE +1 day" +%Y-%m-%d)" ]; do
  
  for i in {1..2}; do
    # Pick a random line from REPOS
    RANDOM_LINE="${REPOS[$RANDOM % ${#REPOS[@]}]}"
    REPO=$(echo "$RANDOM_LINE" | awk '{print $1}')
    BRANCH=$(echo "$RANDOM_LINE" | awk '{print $2}')

    COMMIT_MSG="Daily contribution update $current_date Commit-$i"
    echo "[$current_date] Commit-$i → $REPO ($BRANCH)"

    # Check if file exists
    FILE_SHA=$(gh api repos/$REPO/contents/$FILEPATH -F ref=$BRANCH -q '.sha' 2>/dev/null)

    # Unique commit content
    CONTENT=$(echo -n "$current_date Commit-$i" | base64)

    if [ -z "$FILE_SHA" ]; then
      gh api repos/$REPO/contents/$FILEPATH \
        -X PUT \
        -F message="$COMMIT_MSG" \
        -F content="$CONTENT" \
        -F branch="$BRANCH" \
        -F committer.name="$USERNAME" \
        -F committer.email="$EMAIL" \
        -F author.name="$USERNAME" \
        -F author.email="$EMAIL" \
        -F date="$current_date"
    else
      gh api repos/$REPO/contents/$FILEPATH \
        -X PUT \
        -F message="$COMMIT_MSG" \
        -F content="$CONTENT" \
        -F sha="$FILE_SHA" \
        -F branch="$BRANCH" \
        -F committer.name="$USERNAME" \
        -F committer.email="$EMAIL" \
        -F author.name="$USERNAME" \
        -F author.email="$EMAIL" \
        -F date="$current_date"
    fi
  done

  current_date=$(date -I -d "$current_date + 1 day")
done

