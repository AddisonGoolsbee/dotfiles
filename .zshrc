# Variables
SCRIPT_DIR='/Users/addisongoolsbee'

# ============================================
#              General Shortcuts
# ============================================

# Simple

alias c-="cd -"
alias c.="cd .."
alias ll="ls -alh"
alias sl=ls
alias dc=cd
alias cdh="cd ~"
alias cdes="cd ~/Desktop"
alias cdoc="cd ~/Documents"
alias cdow="cd ~/Downloads"
alias cdcod="cd ~/Documents/coding"
alias poop="echo 💩"
alias deac="deactivate"
alias rp="./prog"
# alias t="tree -L 2 -I 'target|dist|node_modules|.git|.venv|__pycache__'"

# --------------------------------------------
# Complex

alias hg="history | grep"
alias getip="ipconfig getifaddr en0 || ipconfig getifaddr en1"
alias ipget=getip

killport() {
    # Kills the process running at port $1
    kill -9 $(lsof -t -i:"$1")
}

sa() {
    eval "alias a='$@'"
}

sb() {
    eval "alias b='$@'"
}

sc() {
    eval "alias c='$@'"
}

sx() { export x="$1" }
sy() { export y="$1" }
sz() { export z="$1" }

t() {
  local depth="${1:-2}"
  tree -L "$depth" -I 'target|node_modules|.git|.venv|__pycache__'
}

# --------------------------------------------

# Package-Spefific

alias brew86="arch -x86_64 /usr/local/homebrew/bin/brew"
alias zoo="ssh -i ~/.ssh/zoo awg32@aphid.zoo.cs.yale.edu"

# --------------------------------------------

# zshrc

alias zshrc="open ${SCRIPT_DIR}/.zshrc"
alias zshr=". ${SCRIPT_DIR}/.zshrc"
alias zsha='f() { printf "\n%s\n" "$*" >> ~/.zshrc && zshr; }; f'
alias zshadd="zsha"
zshaa() {
    local first=$1
    shift
    zsha "alias $first=\"$@\""
}

zshg() {
    if [[ -z "$1" ]]; then
        echo "Enter a message"
    elif [[ -n "$1" ]]; then
        cd ~/.dotfiles
        gcp $1
        cd - >/dev/null
    fi
}

zshgl() {
    echo "Pulling zshrc"
    cd ~/.dotfiles
    gl
    cd - >>/dev/null
}

alias zshrg="zshr && zshg"

# ============================================
#            Development Shortcuts
# ============================================

# Python

alias pyvc="python -m venv .venv && source .venv/bin/activate"
alias pfr="pip freeze > requirements.txt"
alias pir="uv pip install -r requirements.txt"
alias pi="uv add"
alias piu="uv remove"

pyva() {
    # Activates the virtual environment with the name $1
    if [[ -z "$1" ]]; then
        source .venv/bin/activate
    elif [[ -n "$1" ]]; then
        source $1/bin/activate
    fi
}

# --------------------------------------------

# Javascript

alias ys="yarn start"
alias nrd="npm run dev"
alias nrb="npm run build"
alias nrs="npm run start"
alias pnd="pnpm dev"
alias pnb="pnpm build"
alias pns="pnpm start"

# --------------------------------------------

# DLang

alias lda="source ~/dlang/ldc-1.39.0/activate"

# builds and runs a .d file with rdmd
rd() {
    if [[ -e "$1" || -e "$1.d" ]]; then
        dmd -of="prog" $1 && ./prog
    else
        echo "Error: no file found with the name $1"
    fi
}

# builds and runs a .d file with lldc
ld() {
    if [[ -e "$1" || -e "$1.d" ]]; then
        ldc2 -of="prog" $1 && ./prog
    else
        echo "Error: no file found with the name $1"
    fi
}

# builds and a .d file for debugging
ldb() {
    if [[ -e "$1" || -e "$1.d" ]]; then
        ldc2 -of="prog" -g -gc $1
    else
        echo "Error: no file found with the name $1"
    fi
}

# --------------------------------------------

# Docker

alias dkup="docker compose up backend"
alias dkrun="docker compose run backend bash"
alias dkb="docker compose build"

# --------------------------------------------

# Git

alias gcl="git clone"
alias ga="git add"
alias gc="git commit -m"
alias gca="git commit --amend"
alias gcan="git commit -a --amend --no-edit"
alias gf='git fetch'
alias gfa="git fetch --all"
alias gch="git checkout"
alias gchb="git checkout -b"
alias gchm="git checkout main"
alias gs="git status"
alias gst="git stash"
alias gstp="git stash pop"
alias gb="git branch"
alias gbr='git branch -r'
alias gbd="git branch -d"
alias gbD="git branch -D"
alias grh="git reset --hard"
alias grhh="git reset --hard HEAD~1"
alias grsh="git reset --soft HEAD~1"
alias grv="git remote -v"
alias gra="git remote add"
alias grao="git remote add origin"
alias grs="git remote set-url"
alias grso="git remote set-url origin"
alias gp="git push"
alias gpd="git push origin --delete"
alias glo='git log --pretty="%C(Yellow)%h  %C(reset)%ad (%C(Green)%cr%C(reset))%x09 %C(Cyan)%an: %C(reset)%s" --date=short'
alias gd='git diff'
alias grb="git rebase"
alias grba="git rebase --abort"
alias grbc="git rebase --continue"
alias gsa="git submodule add"
alias ghi="gh repo create"
alias gl="git pull"
alias glf="git pull --ff-only"
alias glup="git pull upstream main && git push origin main"
alias gm="git merge"
alias gmf="git merge --ff-only"
alias gbp="git fetch --prune && git branch -vv | grep ': gone]' | awk '{print $1}' | xargs --no-run-if-empty git branch -D"

glon() {
    if [[ -z "$1" ]]; then
        glo -n 5
    else
        glo -n $1
    fi
}

# gm() {
#     if [[ -z "$1" ]]; then
#         echo "Enter a branch to merge"
#     else
#         git merge --ff-only $1 || git merge $1
#     fi
# }

# gl() {
#     if [[ -z "$1" ]]; then
#         echo "Enter a branch to pull"
#     else
#         git pull --ff-only $1 || git pull $1
#     fi
# }

gcm() {
    # add . and commit with message $1
    if [[ -z "$1" ]]; then
        echo "Enter a message"
    else
        git add .
        git commit -m "$1"
    fi
}

gcp() {
    # add . and commit with message $1, then push
    if [[ -z "$1" ]]; then
        echo "Enter a message"
    else
        git add .
        git commit -m "$1"
        git push
    fi
}

gpu() {
    git push -u origin $(git rev-parse --abbrev-ref HEAD)
}

grem() {
    # Adds remote origin $1 and pushes main to it
    git remote add origin $1
    gpu main
}

gta() {
    # Creates a tag with name $1 and description $2, then pushes it to origin
    if [[ -z "$1" ]]; then
        echo "Enter a tag name"
    elif [[ -z "$2" ]]; then
        echo "Enter a tag description"
    else
        git tag -a $1 -m $2
        git push origin $1
    fi
}

ghau() {
    # Sends GitHub invite to user $1 for current repository
    if [[ -z "$1" ]]; then
        echo "Enter a user to add"
    elif [[ -n "$1" ]]; then
        REPOSITORY=$(gh repo view --json name -q .name)
        if gh api repos/addisongoolsbee/${REPOSITORY}/collaborators/${1} --method PUT >/dev/null; then
            echo "Invite send to $1"
        fi
    fi
}

grbi() {
    # squash the last $1 commits together
    if [[ -z "$1" ]]; then
        echo "Enter the number of commits"
    else
        git rebase -i HEAD~$1
    fi
}

# --------------------------------------------

# Heroku

alias gph='git push heroku & git push; wait'
alias hl='heroku logs -t -n 1000'
alias hls='heroku logs -t --source=app -n 1000'
alias hpp='heroku pg:psql'
alias hrb='heroku run bash'

function hcp {
    # print heroku config file
    export "$1=$(heroku config:get $1)"
}

# ============================================
#                   Other
# ============================================

# Terminal visuals

PROMPT='%B%F{30}%n%f%b:%B%F{31}%1~%f%b$ '
export LSCOLORS=ExCxhxdxfxegedfhfgEcEd
export CLICOLOR=1

# --------------------------------------------

# Paths

export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/Library/Python/3.11/bin:$PATH"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$(brew --prefix)/opt/socket_vmnet/bin:${PATH}"

# --------------------------------------------

# Environment Varialbes
# Java
export JAVA_HOME=/Library/Internet\ Plug-Ins/JavaAppletPlugin.plugin/Contents/Home
# Android Studio
export ANDROID_HOME=/Users/addisongoolsbee/Library/Android/sdk
export PATH=$PATH:/ANDROID_HOME/platform-tools:
# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
# Ruby
eval "$(rbenv init -)"
# Conda
__conda_setup="$('/Users/addisongoolsbee/anaconda3/bin/conda' 'shell.zsh' 'hook' 2>/dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Users/addisongoolsbee/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Users/addisongoolsbee/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Users/addisongoolsbee/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup

export PATH="/usr/local/bin:/opt/homebrew/opt/llvm/bin:$PATH"
export LLVM_LIB_DIR=$(llvm-config --libdir)

export CXX=/opt/homebrew/opt/llvm/bin/clang++
export CC=/opt/homebrew/opt/llvm/bin/clang
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
export LIBOMP="/opt/homebrew/opt/libomp"

# ============================================
#              Unsorted Additions
# ============================================

# https://stackoverflow.com/questions/14040351/filtering-zsh-history-by-command
function percol_select_history() {
    local tac
    exists gtac && tac="gtac" || { exists tac && tac="tac" || { tac="tail -r" } }
    BUFFER=$(fc -l -n 1 | eval $tac | percol --query "$LBUFFER")
    CURSOR=$#BUFFER         # move cursor
    zle -R -c               # refresh
}

zle -N percol_select_history
bindkey '^R' percol_select_history

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

function exists { which $1 &> /dev/null }

# usage: req "$1" please add an arg || return
req() {
local arg="$1"
shift
local msg="${*:-Please provide an argument}"
[[ -n $arg ]] || { print -u2 -- "$msg"; return 1; }
}

alias req1='req "$1"'
alias req2='req "$2"'
alias req3='req "$3"'

export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export PATH="/opt/homebrew/opt/llvm@14/bin:$PATH"

alias pm="python -m"

# pnpm
export PNPM_HOME="/Users/addisongoolsbee/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

alias prd="pnpm run dev"
