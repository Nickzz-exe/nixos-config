#!/bin/bash
 
 # Get the current commit count
 commit_count=$(git rev-list --count HEAD)
 
 # Increment commit count for new commit message
 commit_number=$((commit_count + 1))
 
 # Add all files (git add respects .gitignore automatically)
 git add .
 
 # Commit with the message "commit #n"
 git commit -m "commit #$commit_number"
 
 # Push to master branch
 git push origin master
