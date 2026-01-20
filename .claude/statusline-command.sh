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

# Get context usage percentage
used_pct=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

# Build context usage string with color coding
context_info=""
if [ -n "$used_pct" ]; then
  # Convert to integer for comparison
  used_int=$(printf "%.0f" "$used_pct")

  # Color code based on usage: green < 50%, yellow 50-80%, red > 80%
  if [ "$used_int" -lt 50 ]; then
    color="\033[32m"  # Green
  elif [ "$used_int" -lt 80 ]; then
    color="\033[33m"  # Yellow
  else
    color="\033[31m"  # Red
  fi

  context_info=$(printf " ${color}[%s%%]\033[0m" "$used_int")
fi

# Print status line with colors
# Cyan for directory name, Yellow for git info, White for arrow, color-coded for context usage
printf "\033[36m%s\033[0m\033[33m%s\033[0m%s \033[37m➔\033[0m" "$(basename "$cwd")" "$git_info" "$context_info"
