#!/bin/bash
cd "$HOME/Obsidian" || echo "Failed cd to directory" && exit 1
git add .
git commit -m "commit from $(date)"
git push origin master
