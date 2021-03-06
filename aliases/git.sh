#!/bin/bash
## GIT
alias stg='git stage'
alias stg.='git stage .'
alias st='git status'
alias cln='git clone'
alias cmm='git commit -m'
alias psh='git push'
alias psh+=$'git branch | grep "*" | awk \'{ print $2 }\' | xargs git push --set-upstream origin' # Push a branch for the first time
alias chk='git checkout'
alias chk+='git checkout -b'
alias graph='git log --graph'
alias rb='git rebase'
alias b='git branch'
alias b-='git branch -d'
alias p='git pull'
alias m='git merge'
alias t='git tag'
alias t+='git tag -a'
alias t-='git tag -d'
alias cpb=$'git branch | grep "*" | awk \'{ print $2 }\' | pbcopy' # Copy branch name

