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
alias t="tree -L 2"

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


# --------------------------------------------

# Package-Spefific

alias brew86="arch -x86_64 /usr/local/homebrew/bin/brew"
alias zoo="ssh -i ~/.ssh/zoo awg32@aphid.zoo.cs.yale.edu"

# --------------------------------------------

# zshrc

alias zshrc="open ${SCRIPT_DIR}/.zshrc"
alias zshr=". ${SCRIPT_DIR}/.zshrc"
alias zsha="echo "\n'$@'" >> ~/.zshrc && zshr"

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

alias pyvc="python -m venv .venv"
alias pfr="pip freeze > requirements.txt"
alias pir="pip install -r requirements.txt"
alias pi="pip install"
alias piu="pip uninstall"

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
alias gm="git merge"
alias gmf="git merge --ff-only"

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

QEMU_ISO="vm/ubuntu.iso"
QEMU_QCOW="vm/ubuntu.qcow2"
QEMU_SHARE="./proj1"

alias qcowsetup="qemu-img create -f qcow2 $QEMU_QCOW 80G"
alias qmsetup="qemu-system-x86_64 -hda $QEMU_QCOW -boot c -m 4G -cdrom $QEMU_ISO"
alias qmrsimple="qemu-system-x86_64 -hda $QEMU_QCOW -boot c -m 4G"
alias qmr="qemu-system-x86_64 \
    -hda $QEMU_QCOW \
    -boot c -m 4G -smp 4 \
    -virtfs local,path=$QEMU_SHARE,mount_tag=hostshare,security_model=mapped-xattr,id=hostsh \
    -net user,hostfwd=tcp::2222-:22 -net nic"
alias qmsh="ssh addisongoolsbee@localhost -p 2222"

alias qmsa="qemu-system-aarch64 \
   -M virt,highmem=on \
   -accel hvf \
   -cpu host \
   -smp 6 \
   -m 12G \
   -bios vm/QEMU_EFI.fd \
   -device virtio-gpu-pci \
   -display default,show-cursor=on \
   -device qemu-xhci \
   -device usb-ehci -device usb-kbd -device usb-mouse -usb \
   -device usb-tablet \
   -drive file=vm/ubuntu-arm.qcow2,format=qcow2,if=virtio,cache=writethrough \
   -cdrom vm/ubuntu-arm.iso"

alias qmra="sudo qemu-system-aarch64 \
    -M virt,highmem=on \
    -accel hvf \
    -cpu host \
    -smp 6 \
    -m 12G \
    -bios vm/QEMU_EFI.fd \
    -device virtio-gpu-pci \
    -display default,show-cursor=on \
    -device qemu-xhci \
    -device usb-ehci -device usb-kbd -device usb-mouse -usb \
    -device usb-tablet \
    -drive file=vm/ubuntu-arm.qcow2,format=qcow2,if=virtio,cache=writethrough \
    -virtfs local,path=$QEMU_SHARE,mount_tag=hostshare,security_model=mapped-xattr,id=hostsh \
    -netdev vmnet-shared,id=net0 \
    -device virtio-net-pci,netdev=net0"

Q_FSTAB="hostshare /home/addison/code 9p trans=virtio,version=9p2000.L,rw,uid=1000,gid=1000 0 0"

alias t1='socket_vmnet_client "$(brew --prefix)/var/run/socket_vmnet" \
    qemu-system-aarch64 \
        -machine virt,accel=hvf \
        -cpu host \
        -smp 6 \
        -m 8G \
        -device virtio-net-pci,netdev=net0 -netdev socket,id=net0,fd=3 \
        -drive if=virtio,format=qcow2,file=vm/target.qcow2 \
        -cdrom vm/ubuntu-arm.iso> \
        -nographic \
        -bios vm/QEMU_EFI.fd'

Q_ROOT="${HOME}/Desktop/System Design/"
Q_BIOS="${Q_ROOT}vm/QEMU_EFI.fd"
Q_DEV="${Q_ROOT}vm/dev.qcow2"
Q_TARGET="${Q_ROOT}vm/target.qcow2"
Q_ISO="${Q_ROOT}vm/ubuntu-arm.is"
Q_SHARE="${Q_ROOT}proj2"

alias qdev='socket_vmnet_client "$(brew --prefix)/var/run/socket_vmnet" \
    qemu-system-aarch64 \
        -machine virt,accel=hvf \
        -cpu host \
        -smp 6 \
        -m 12G \
        -device virtio-net-pci,netdev=net0 -netdev socket,id=net0,fd=3 \
        -drive if=virtio,format=qcow2,file=${Q_DEV} \
        -nographic \
        -virtfs local,path=${Q_SHARE},mount_tag=hostshare,security_model=mapped-xattr,id=hostsh \
        -bios ${Q_BIOS}'

alias qtarget='qemu-system-aarch64 \
        -machine virt,accel=hvf \
        -cpu host \
        -smp 6 \
        -m 12G \
        -drive if=virtio,format=qcow2,file=${Q_TARGET} \
        -virtfs local,path=${Q_SHARE},mount_tag=hostshare,security_model=mapped-xattr,id=hostsh \
        -bios ${Q_BIOS} \
        -device virtio-gpu-pci,edid=on,xres=1920,yres=1080 \
        -display default,show-cursor=on \
        -device qemu-xhci \
        -device usb-kbd \
        -device usb-mouse'


alias adev="ssh m1loser@172.29.80.69"
alias atarget="ssh m1loser@172.29.80.146"

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

