alias zoo="ssh -i ~/.ssh/zoo awg32@cobra.zoo.cs.yale.edu"
# alias ipython=IPython

# General Shortcuts
alias c.="cd .."
alias ll="ls -alh"
alias sl=ls
alias dc=cd
alias zshrc="open ~/.dotfiles/.zshrc"
alias rzsh=". ~/.dotfiles/.zshrc"
alias python=python3
alias brew86="arch -x86_64 /usr/local/homebrew/bin/brew"

# Dev Shortcuts
alias dkup="docker-compose up app"
alias dkrun="docker-compose run app bash"
alias ys="yarn start"

# Git Shortcuts
alias ga="git add"
alias gc="git commit -m"
alias gcS="git commit -amS"
alias gca="git commit --amend --no-edit"
alias gl="git pull"
alias gch="git checkout"
alias gchb="git checkout -b"
alias gchm="git checkout main"
alias gs="git status"
alias gb="git branch"
alias gbr='git branch -r'
alias gbd="git branch -d"
alias gbD="git branch -D"
alias grh="git reset --hard"
alias gra="git remote add origin"
alias gp="git push"
alias gpu="git push -u origin"
alias glo='git log --oneline --decorate'
alias gd='git diff'
alias gm='git merge'
alias gf='git fetch'
alias gr="git rebase"

# Heroku Shortcuts
alias gph='git push heroku & git push; wait'
alias hl='heroku logs -t -n 1000'
alias hls='heroku logs -t --source=app -n 1000'
alias hpp='heroku pg:psql'
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
    git add .
    git commit -m $1
}

# Standard git commit -> push workflow
gcp() {
    git add .
    git commit -m $1
    git push
}

grem() {
    git remote add origin $1
    gpu main
}


# Terminal visuals
PROMPT='%B%F{30}%n%f%b:%B%F{31}%1~%f%b$ '
export LSCOLORS=ExCxhxdxfxegedfhfgEcEd
export CLICOLOR=1

# Paths
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/Library/Python/3.10/bin:$PATH"


export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export JAVA_HOME=/Library/Internet\ Plug-Ins/JavaAppletPlugin.plugin/Contents/Home

# Android Studio 
export ANDROID_HOME=/Users/addisongoolsbee/Library/Android/sdk
export PATH=$PATH:/ANDROID_HOME/platform-tools:

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
