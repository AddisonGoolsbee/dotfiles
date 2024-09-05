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

# --------------------------------------------

# Complex

alias hg="history | grep"
alias getip="ipconfig getifaddr en0 || ipconfig getifaddr en1"
alias ipget=getip

killport() {
    # Kills the process running at port $1
    kill -9 $(lsof -t -i:"$1")
}

# --------------------------------------------

# Package-Spefific

alias brew86="arch -x86_64 /usr/local/homebrew/bin/brew"
alias zoo="ssh -i ~/.ssh/zoo awg32@aphid.zoo.cs.yale.edu"

# --------------------------------------------

# zshrc

alias zshrc="open ${SCRIPT_DIR}/.zshrc"
alias zshr=". ${SCRIPT_DIR}/.zshrc"
# zshg(message): commits zshrc and pushes to origin
# zshgl(): pulls to zshrc
# zshrg: runs zshr and zshg

# ============================================
#            Development Shortcuts
# ============================================

# Python

alias pyvc="python -m venv .venv"
alias pfr="pip freeze > requirements.txt"
alias pir="pip install -r requirements.txt"
alias pipi="pip install"

pyva() {
    # Activates the virtual environment with the name $1
    if [[ -z "$1" ]]; then
        source venv/bin/activate
    elif [[ -n "$1" ]]; then
        source $1/bin/activate
    fi
}

# --------------------------------------------

# Node

alias dkup="docker compose up backend"
alias dkrun="docker compose run backend bash"
alias dkb="docker compose build"
alias ys="yarn start"

# --------------------------------------------

# DLang

alias da="source ~/dlang/ldc-1.39.0/activate"

# builds and runs a .d file
d() {
    if [[ -e "$1" || -e "$1.d" ]]; then
        ldc2 -of="prog" $1 && ./prog
    else
        echo "Error: no file found with the name $1"
    fi
}

# --------------------------------------------

# Git

alias gcl="git clone"
alias ga="git add"
alias gc="git commit -m"
alias gcS="git commit -amS"
alias gca="git add . && git commit --amend --no-edit"
alias gl="git pull"
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
alias grv="git remote -v"
alias gra="git remote add"
alias grao="git remote add origin"
alias grs="git remote set-url"
alias grso="git remote set-url origin"
alias gp="git push"
alias gpu="git push -u origin $(git rev-parse --abbrev-ref HEAD)"
alias gpd="git push origin --delete"
alias glo='git log --pretty="%C(Yellow)%h  %C(reset)%ad (%C(Green)%cr%C(reset))%x09 %C(Cyan)%an: %C(reset)%s" --date=short'
alias gd='git diff'
alias gm='git merge'
alias gf='git fetch'
alias gr="git rebase"
alias gsa="git submodule add"
alias ghi="gh repo create"

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
#         Delayed Function Definitions
# ============================================

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

# --------------------------------------------

# Environment Varialbes
# Java
export JAVA_HOME=/Library/Internet\ Plug-Ins/JavaAppletPlugin.plugin/Contents/Home
# Android Studio
export ANDROID_HOME=/Users/addisongoolsbee/Library/Android/sdk
export PATH=$PATH:/ANDROID_HOME/platform-tools:
# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
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

# ============================================
#              Unsorted Additions
# ============================================
