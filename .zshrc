# Variables
SCRIPT_DIR='/Users/addisongoolsbee'

# General Shortcuts
alias c-="cd -"
alias c.="cd .."
alias ll="ls -alh"
alias sl=ls
alias dc=cd
alias cdes="cd ~/Desktop"
alias cdoc="cd ~/Documents"
alias cdow="cd ~/Downloads"
alias cdh="cd ~"

alias hg="history | grep"

alias zshrc="open ${SCRIPT_DIR}/.zshrc"
alias zshr=". ${SCRIPT_DIR}/.zshrc"

alias zoo="ssh -i ~/.ssh/zoo awg32@cobra.zoo.cs.yale.edu"
alias brew86="arch -x86_64 /usr/local/homebrew/bin/brew"

# Dev Shortcuts
alias dkup="docker compose up backend"
alias dkrun="docker compose run backend bash"
alias ys="yarn start"

# Git Shortcuts
alias gcl="git clone"
alias ga="git add"
alias gc="git commit -m"
alias gcS="git commit -amS"
alias gca="git commit --amend --no-edit"
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
alias gpu="git push -u origin"
alias gpum="git push -u origin main"
alias glo='git log --oneline --decorate'
alias gd='git diff'
alias gm='git merge'
alias gf='git fetch'
alias gr="git rebase"
alias gsa="git submodule add"
alias ghi="gh repo create"

# Heroku Shortcuts
alias gph='git push heroku & git push; wait'
alias hl='heroku logs -t -n 1000'
alias hls='heroku logs -t --source=app -n 1000'
alias hpp='heroku pg:psql'
alias hrb='heroku run bash'
function hcp {
    export "$1=$(heroku config:get $1)"
}

# Functions

# Kills the process running at port arg1
killport() {
    kill -9 $(lsof -t -i:"$1")
}

# Standard git commit workflow
gcm() {
    if [[ -z "$1" ]]; then
        echo "Enter a message"
    elif [[ -n "$1" ]]; then
        git add .
        git commit -m $1
    fi
}

# Standard git commit -> push workflow
gcp() {
    if [[ -z "$1" ]]; then
        echo "Enter a message"
    elif [[ -n "$1" ]]; then
        git add .
        git commit -m $1
        git push
    fi
}

grem() {
    git remote add origin $1
    gpu main
}

ghau() {
    if [[ -z "$1" ]]; then
        echo "Enter a user to add"
    elif [[ -n "$1" ]]; then
        REPOSITORY=$(gh repo view --json name -q .name)
        gh api repos/addisongoolsbee/${REPOSITORY}/collaborators/${1} --method PUT 
    fi        
}

zshg() {
    if [[ -z "$1" ]]; then
        echo "Enter a message"
    elif [[ -n "$1" ]]; then
        cd ~/.dotfiles
        gcp $1
        cd -
    fi
}

# Terminal visuals
PROMPT='%B%F{30}%n%f%b:%B%F{31}%1~%f%b$ '
export LSCOLORS=ExCxhxdxfxegedfhfgEcEd
export CLICOLOR=1

# Paths
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/Library/Python/3.11/bin:$PATH"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export JAVA_HOME=/Library/Internet\ Plug-Ins/JavaAppletPlugin.plugin/Contents/Home

# Android Studio
export ANDROID_HOME=/Users/addisongoolsbee/Library/Android/sdk
export PATH=$PATH:/ANDROID_HOME/platform-tools:

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion


# conda stuff
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
