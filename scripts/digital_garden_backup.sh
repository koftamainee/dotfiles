#!/usr/bin/env sh

cd ~/.local/share/PrismLauncher/instances/Digital\ Garden/minecraft/saves/Digital\ Garden || exit

git add .
git commit -m "Backup on $(date)"
git push origin master
