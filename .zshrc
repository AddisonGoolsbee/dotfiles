alias zoo="ssh -i ~/.ssh/zoo awg32@cobra.zoo.cs.yale.edu"
# alias ipython=IPython

# General Shortcuts
alias c.="cd .."
alias ll="ls -alh"
alias sl=ls
alias zshrc="open ~/config-files/.zshrc"
alias rzsh=". ~/config-files/.zshrc"
alias python=python3

killport() {
    kill -9 $(lsof -t -i:"$1")
}

# Dev Shortcuts
alias dkup="docker-compose up app"
alias dkrun="docker-compose run app bash"
alias ys="yarn start"

# Git Shortcuts
alias ga="git add"
alias gcm="git commit -am"
alias gcS="git commit -amS"
alias gca="git commit --amend --no-edit"
alias gl="git pull"
alias gch="git checkout"
alias gs="git status -s"
alias gb="git branch"
alias gra="git remote add origin"
alias gp="git push"
alias gpu="git push -u origin"
alias glo='git log --oneline --decorate'
alias gd='git diff'
alias gm='git merge'

# Heroku Shortcuts
alias gph='git push heroku & git push; wait'
alias hl='heroku logs -t -n 1000'
alias hls='heroku logs -t --source=app -n 1000'
alias hpp='heroku pg:psql'
function hcp {
    export "$1=$(heroku config:get $1)"
}


# Terminal visuals
PROMPT='%B%F{30}%n%f%b:%B%F{31}%1~%f%b%# '
export LSCOLORS=ExCxhxdxfxegedfhfgEcEd
export CLICOLOR=1


export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export JAVA_HOME=/Library/Internet\ Plug-Ins/JavaAppletPlugin.plugin/Contents/Home

# Android Studio 
export ANDROID_HOME=/Users/addisongoolsbee/Library/Android/sdk
export PATH=$PATH:/ANDROID_HOME/platform-tools:\$PATH

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
