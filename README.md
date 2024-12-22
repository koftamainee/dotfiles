```bash
git clone https://github.com/koftamainee/dotfiles
cd dotfiles
mv .git ../
cp .zshrc ~
cp -r scripts ~
mkdir -p ~/.config/
cp -ar . ~/.config/
mv ../.git .
cd ../
```
