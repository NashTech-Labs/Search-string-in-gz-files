#!/bin/bash

# Directory to search
search_dir=<directory name>

# String to search for
search_string=<string>

if [ -z "$search_dir" ] || [ -z "$search_string" ]; then
    echo "Usage: $0 <directory> <string>"
    exit 1
fi

# Find and search for the string in regular files
grep_result=$(grep -r "$search_string" "$search_dir" 2>/dev/null)

# Find and search for the string in .gz files
gzgrep_result=$(find "$search_dir" -name "*.gz" -exec zgrep "$search_string" {} + 2>/dev/null)

# Check if either grep or zgrep found any files
if [ -n "$grep_result" ] || [ -n "$gzgrep_result" ]; then
    echo "Files containing '$search_string' found:"
    if [ -n "$grep_result" ]; then
        echo "Regular files:"
        echo "$grep_result"
    fi
    if [ -n "$gzgrep_result" ]; then
        echo "Gzipped files:"
        echo "$gzgrep_result"
    fi
else
    echo "No files containing '$search_string' found."
fi
