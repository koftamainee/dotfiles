# Set environment variables
export ZSH="$HOME/.oh-my-zsh"
export CC=clang
export CXX=clang++
export EDITOR=nvim
export VISUAL=nvim
export PATH="$PATH:$HOME/.local/bin"
export TERM_PROGRAM=ghostty


export PATH="$HOME/.cargo/bin:$PATH"
source $HOME/.cargo/env


export RUSTUP_DIST_SERVER="https://rsproxy.cn"
export RUSTUP_UPDATE_ROOT="https://rsproxy.cn/rustup"

# Go Paths setup
export GOPATH=$HOME/go
export PATH="$PATH:$(go env GOBIN):$(go env GOPATH)/bin"

export PATH=$PATH:$HOME/.emacs.d/bin/

# Rust Paths setup
export PATH="$HOME/.cargo/bin:$PATH"

# ZSH theme
ZSH_THEME="xiong-chiamiov-plus"

# Enable plugins
plugins=(
    git
    archlinux
    zsh-autosuggestions
    zsh-syntax-highlighting
)

# Source oh-my-zsh
source $ZSH/oh-my-zsh.sh
if [ -e /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]; then
  . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
fi

ulimit -c 0
# funcs
function ex {
 if [ -z "$1" ]; then
    # display usage if no parameters given
    echo "Usage: ex <path/file_name>.<zip|rar|bz2|gz|tar|tbz2|tgz|Z|7z|xz|ex|tar.bz2|tar.gz|tar.xz>"
    echo "       extract <path/file_name_1.ext> [path/file_name_2.ext] [path/file_name_3.ext]"
 else
    for n in "$@"
    do
      if [ -f "$n" ] ; then
          case "${n%,}" in
            *.cbt|*.tar.bz2|*.tar.gz|*.tar.xz|*.tbz2|*.tgz|*.txz|*.tar)
                         tar xvf "$n"       ;;
            *.lzma)      unlzma ./"$n"      ;;
            *.bz2)       bunzip2 ./"$n"     ;;
            *.cbr|*.rar)       unrar x -ad ./"$n" ;;
            *.gz)        gunzip ./"$n"      ;;
            *.cbz|*.epub|*.zip)       unzip ./"$n"       ;;
            *.z)         uncompress ./"$n"  ;;
            *.7z|*.arj|*.cab|*.cb7|*.chm|*.deb|*.dmg|*.iso|*.lzh|*.msi|*.pkg|*.rpm|*.udf|*.wim|*.xar)
                         7z x ./"$n"        ;;
            *.xz)        unxz ./"$n"        ;;
            *.exe)       cabextract ./"$n"  ;;
            *.cpio)      cpio -id < ./"$n"  ;;
            *.cba|*.ace)      unace x ./"$n"      ;;
            *)
                         echo "ex: '$n' - unknown archive method"
                         return 1
                         ;;
          esac
      else
          echo "'$n' - file does not exist"
          return 1
      fi
    done
fi
}

pls () {
  /usr/bin/sudo $(history | tail -n 1 | awk '{$1=""; print substr($0,2)}')
}

# Mom we have ls at home
alias ls='eza -a --icons'
alias ll='eza -al --icons'
alias lt='eza -a --tree --level=1 --icons'

# Animal stuff
alias cat='bat'

# I am too lazy
alias tree="erd"
alias du="dust"
alias lh='~/scripts/lh.sh'
alias gs='git status'
alias glog='git log --graph --decorate --oneline'
alias c='clear'
alias '$'=""
alias 'gdb'='pwndbg'
mkcd() { mkdir -p "$1" && cd "$1" }
alias pyserver='python3 -m http.server 8000'
alias spsql='bash $HOME/scripts/spsql.sh'

# Safety !!!
alias chmod='chmod --preserve-root'
alias chown='chown --preserve-root'
alias chgrp='chgrp --preserve-root'

# Custom scripts
alias t="~/scripts/t.sh"
alias cfgs='bash $HOME/scripts/cfgs.sh'


# System commands
alias shd='bash $HOME/scripts/commit_obsidian.sh; shutdown now'
alias srb='sudo reboot now'
alias sus='systemctl suspend' # when d impostor is sus

# Programming stuff
alias vim='nvim'
alias k8s='minikube'

# Cringe stuff
alias ff='fastfetch -c $HOME/.config/fastfetch/config-compact.jsonc --logo-color-1 magenta'
alias shrug='echo "¯\_(ツ)_/¯"'
alias toss='[ $((RANDOM % 2)) -eq 0 ] && echo "🪙 Heads!" || echo "🪙 Tails!"'
alias yolo='sudo pacman -Syu --noconfirm && paru -Syua --devel --noconfirm'
alias cow='fortune | cowsay | lolcat'

# General convenience aliases
alias :q='exit' # vim-user moment
alias mv='mv -i'
alias cp='cp -i'
alias ln='ln -i'
alias rm='rm -I --preserve-root'
alias mkdir='mkdir -pv'
alias whoami='whoami && curl ident.me && echo'

# pretty usefull stuff
alias wttr='curl "wttr.in"'

# Set-up FZF key bindings (CTRL R for fuzzy history finder)
source <(fzf --zsh)

# History settings
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# THE FUCK
eval $(thefuck --alias)
eval "$(starship init zsh)"

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f /home/kofta/.dart-cli-completion/zsh-config.zsh ]] && . /home/kofta/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]

