#!/bin/bash

# Read JSON input from stdin
input=$(cat)

# Extract current working directory
cwd=$(echo "$input" | jq -r '.workspace.current_dir')

# Get git branch (skip optional locks for performance)
git_branch=$(git -C "$cwd" branch --show-current 2>/dev/null)

# Check if we're in a git worktree
is_worktree=""
if [ -n "$git_branch" ]; then
  # Check if this is a worktree by looking for .git file (not directory)
  if [ -f "$cwd/.git" ]; then
    is_worktree="🌿 "
  fi
fi

# Build the git info string
if [ -n "$git_branch" ]; then
  git_info=" (${is_worktree}${git_branch})"
else
  git_info=""
fi

# Print status line with colors
# Cyan for directory name, Yellow for git info, White for arrow
printf "\033[36m%s\033[0m\033[33m%s\033[0m \033[37m➔\033[0m" "$(basename "$cwd")" "$git_info"
