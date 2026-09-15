export ZSH="$HOME/.oh-my-zsh"
export CC=gcc
export CXX=g++
export EDITOR='emacsclient -nw --alternate-editor='
export VISUAL='emacsclient -c --alternate-editor='
export MANPAGER='nvim +Man!'
export LESS='-R --mouse'

# Without this qt refuses to work for some fucking reason
export QT_QPA_PLATFORM=wayland
export QT_QPA_PLATFORMTHEME=qt6ct
export QT_STYLE_OVERRIDE=kvantum

# gooooh
export GOPATH=$HOME/go
export GOBIN="$GOPATH/bin"

# i am too broke to use p4 for now
# export P4PORT=localhost:1666
# export P4USER=$USER
# export P4ROOT=$HOME/Perforce
# export P4JOURNAL=$P4ROOT/p4d.journal
# export P4LOG=$P4ROOT/p4d.log

# i dont want my core to be dumped :(
ulimit -c 0

# path stuff
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$HOME/.dotnet/tools:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"

# for doom scripts
export PATH="$HOME/.config/emacs/bin:$PATH"

# opencode installation binary
export PATH=/home/kofta/.opencode/bin:$PATH

# zsh stuff
plugins=(
	docker
	docker-compose
	kubectl
	zsh-autosuggestions
	zsh-syntax-highlighting
)

source "$ZSH/oh-my-zsh.sh"

# unalias standart zsh macro for: p4 add ...
unalias '...'

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS HIST_IGNORE_SPACE SHARE_HISTORY INC_APPEND_HISTORY
setopt appendhistory

unsetopt AUTO_CD

# safety!!!
alias chmod='chmod --preserve-root'
alias chown='chown --preserve-root'
alias chgrp='chgrp --preserve-root'
alias rm='rm -I --preserve-root'
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'
alias mkdir='mkdir -pv'

# modern stuff for coreutils
alias cd='z'
alias ls='eza -a --icons'
alias ll='eza -al --icons'
alias lt='eza -a --tree --level=1 --icons'
alias cat='bat'
alias du='dust'
alias tree='tree -a --gitignore -I ".git"'
alias find='fd'
alias grep='rg'
alias ps='procs'

# i am lazy
alias c='clear'
alias vim='nvim'
alias :q='exit'
alias cr='cargo run'
alias cw='cargo watch'
alias crr='cargo run --release'
alias ct='cargo test'
alias ch='cargo check'
alias cb='cargo build'
alias cbr='cargo build --release'
alias mb='make build'
alias mr='make run'
alias md='make dev'
alias mt='make test'
alias erst='systemctl --user restart emacs'
alias gs='git status'
alias glog='git log --graph --decorate --oneline'

# go to top level root of repo
alias cdr='cd "$(git rev-parse --show-superproject-working-tree 2>/dev/null || git rev-parse --show-toplevel 2>/dev/null || echo .)"'

# commit dotfiles on github
alias cfgs='bash $HOME/scripts/cfgs.sh'

alias shd='shutdown now'
# TODO: figure out how to reboot w/o sudo
alias srb='sudo reboot now'
# when'd impostor is sus
alias sus='systemctl suspend'

# anime
alias ff='fastfetch -c ~/.config/fastfetch/config-compact.jsonc --logo-color-1 "#FF6B00"'
alias yolo='sudo pacman -Syu --noconfirm && paru -Syua --devel --noconfirm'
alias wttr='curl "wttr.in/Moscow"'

# repeat previous command with sudo
pls() {
	/usr/bin/sudo $(fc -ln -1)
}

mkcd() {
	mkdir -p "$1" && cd "$1" || return
}

source <(fzf --zsh)

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(direnv hook zsh)"

bindkey -s '^f' "tmux-sessionizer\n"
