#!/bin/bash

# Declare the associative array of configuration files
declare -A CONFIG_FILES=(
  [scripts]="$HOME/scripts/"
  [zsh]="$HOME/.zshrc"
  [hypr]="$HOME/.config/hypr"
  [waybar]="$HOME/.config/waybar"
  [gtk]="$HOME/.config/gtk-3.0 $HOME/.config/gtk-4.0"
  [qt]="$HOME/.config/qt5ct $HOME/.config/qt6ct"
  [nvim]="$HOME/.config/nvim"
  [fastfetch]="$HOME/.config/fastfetch"
  [btop]="$HOME/.config/btop"
  [cava]="$HOME/.config/cava"
  [gdb]="$HOME/.gdbinit"
  [rofi]="$HOME/.config/rofi"
  [wezterm]="$HOME/.config/wezterm"
)

# Define the backup directory and repository URL
BACKUP_DIR="$HOME/config_backup"
GIT_REPO_URL="git@github.com:koftamainee/dotfiles"

# Create the backup directory if it doesn't exist
mkdir -p "$BACKUP_DIR"

# Backup each configuration file
echo "Starting backup..."
for key in "${!CONFIG_FILES[@]}"; do
  echo "Backing up ${key}..."
  for file in ${CONFIG_FILES[$key]}; do
    if [ -e "$file" ]; then
        cp -r "$file" "$BACKUP_DIR/"
    else
      echo "Warning: $file does not exist."
    fi
  done
done

# Navigate to the backup directory
cd "$BACKUP_DIR" || exit

# Initialize Git repository if not already initialized
if [ ! -d "$BACKUP_DIR/.git" ]; then
  echo "Initializing Git repository..."
  git init
  git remote add origin "$GIT_REPO_URL"
fi

# Add, commit, and push changes to GitHub
echo "Pushing backups to GitHub..."
git add .
git commit -m "Backup on $(date)"
git branch -M master
git push -u origin master

echo "Backup complete!"
