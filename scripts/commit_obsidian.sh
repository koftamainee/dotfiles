#!/bin/bash
cd "$HOME/Obsidian" || exit
git add .
git commit -m "Commit from $(date)"
git push origin master
