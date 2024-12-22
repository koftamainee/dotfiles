```bash
git clone https://github.com/koftamainee/dotfiles
cd dotfiles
rm -rf .git
cp .zshrc ~
cp -r scripts ~
mkdir -p ~/.config/
cp -ar . ~/.config/
cd ../
rm -rf dotfiles
```
