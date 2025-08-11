#!/bin/bash

while read repo; do
  if [ -n "$repo" ]; then
    echo "🔄 Forking $repo..."
    gh repo fork "$repo" --clone=false --remote=false &
  fi
done < repos.txt

wait
echo "✅ All forks completed!"
