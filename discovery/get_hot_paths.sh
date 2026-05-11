#!/bin/bash
# Usage: ./get_hot_paths.sh [target_directory]
TARGET=${1:-.}
echo "Top 20 most frequently modified files in $TARGET:"
git log --pretty=format: --name-only -- "$TARGET" | grep -v '^$' | sort | uniq -c | sort -rg | head -20
