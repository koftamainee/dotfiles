export ZSH="$HOME/.oh-my-zsh"
export CC=gcc
export CXX=g++
export EDITOR=nvim
export VISUAL=nvim

# Without this qt refuses to work for some fucking reason
export QT_QPA_PLATFORM=wayland
export QT_QPA_PLATFORMTHEME=qt6ct
export QT_STYLE_OVERRIDE=kvantum

export LIBVIRT_DEFAULT_URI=qemu:///system

export GOPATH=$HOME/go
export SDKMAN_DIR="$HOME/.sdkman"

# i dont want my core to be dumped :(
ulimit -c 0

export PATH="/usr/bin:$PATH"
export PATH="$HOME/.npm-global/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
export PATH="$GEM_HOME/bin:$PATH"
export PATH="$HOME/.emacs.d/bin:$PATH"
export PATH="$HOME/.opencode/bin:$PATH"

source "$HOME/vulkansdk/default/setup-env.sh" 2>/dev/null

# zsh stuff
ZSH_THEME="xiong-chiamiov-plus"

plugins=(
    docker
    docker-compose
    kubectl
    git
    archlinux
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source "$ZSH/oh-my-zsh.sh"

unalias md

md() {
    if [ -z "$1" ]; then
        echo "md: Specify markdown file to edit"
        return 1
    fi
    marktext $1 &!
}


HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# safety!!!
alias chmod='chmod --preserve-root'
alias chown='chown --preserve-root'
alias chgrp='chgrp --preserve-root'
alias rm='rm -I --preserve-root'
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'
alias mkdir='mkdir -pv'

alias cd='z'
alias ls='eza -a --icons'
alias ll='eza -al --icons'
alias lt='eza -a --tree --level=1 --icons'
alias cat='bat'
alias du='dust'
alias tree='tree -a --gitignore -I ".git"'

alias gs='git status'
alias glog='git log --graph --decorate --oneline'

# i am lazy
alias c='clear'
alias vim='nvim'
alias :q='exit'
alias whoami='whoami && curl -s ident.me && echo'

# dont use it now, but dont want to delete it
alias t="$HOME/scripts/t.sh"
alias cfgs='bash $HOME/scripts/cfgs.sh'

alias shd='bash $HOME/scripts/commit_obsidian.sh; shutdown now'
alias srb='sudo reboot now'
alias sus='systemctl suspend'

# oh no cringe
alias ff='fastfetch -c $HOME/.config/fastfetch/config-compact.jsonc --logo-color-1 "#FF6B00"'
alias yolo='sudo pacman -Syu --noconfirm && paru -Syua --devel --noconfirm'
alias wttr='curl "wttr.in"'

ex() {
    if [ -z "$1" ]; then
        echo "Usage: ex <file.[archive format]> ..."
        return 1
    fi
    for n in "$@"; do
        if [ -f "$n" ]; then
            case "${n%,}" in
                *.cbt|*.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar)
                    tar xvf "$n" ;;
                *.lzma)   unlzma "$n" ;;
                *.bz2)    bunzip2 "$n" ;;
                *.cbr|*.rar) unrar x -ad "$n" ;;
                *.gz)     gunzip "$n" ;;
                *.cbz|*.epub|*.zip) unzip "$n" ;;
                *.z)      uncompress "$n" ;;
                *.7z|*.arj|*.cab|*.cb7|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.pkg|*.rpm|*.udf|*.wim|*.xar)
                    7z x "$n" ;;
                *.xz)     unxz "$n" ;;
                *.exe)    cabextract "$n" ;;
                *.cpio)   cpio -id < "$n" ;;
                *.cba|*.ace) unace x "$n" ;;
                *) echo "ex: '$n' - unknown archive format"; return 1 ;;
            esac
        else
            echo "'$n' does not exist"
            return 1
        fi
    done
}

pls() {
    /usr/bin/sudo $(fc -ln -1)
}

mkcd() {
    mkdir -p "$1" && cd "$1" || return
}

tmp() {
    temp_dir=$(mktemp -d tmpdir-XXXXXX)
    cd "$temp_dir" || return
    add-zsh-hook zshexit _tmp_cleanup
}

_tmp_cleanup() {
    rm -rf "$temp_dir"
}

source <(fzf --zsh)

eval "$(starship init zsh)"

eval "$(zoxide init zsh)"

[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

eval "$(mise activate zsh)"

[ -f "/home/kofta/.ghcup/env" ] && . "/home/kofta/.ghcup/env" # ghcup-env

# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
[[ ! -r '/home/kofta/.opam/opam-init/init.zsh' ]] || source '/home/kofta/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null
# END opam configuration
