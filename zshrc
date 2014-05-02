# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

export EDITOR=vim

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh
source ~/.bash_profile # Where I keep personal alias' etc.

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

eval "$(hub alias -s)"

# ALIASES
alias myssh="cat ~/.ssh/id_rsa.pub;"
alias reload!="source ~/.zshrc; source ~/.bash_profile"
alias erc="mvim ~/.zshrc"
alias ebash="mvim ~/.bash_profile" # I keep my personal shortcuts here
alias ..='cd ..'       # move up 1 dir
alias ...='cd ../..'   # move up 2 dirs

alias mysql="/usr/local/mysql/bin/mysql"
alias mysqladmin=/usr/local/mysql/bin/mysqladmin
alias rvmcur="rvm info | grep GEM_HOME"
alias rs="rvmsudo rails s -p 80"
alias vim="reattach-to-user-namespace vim" # fix tmux clipboard issue

# vim colors in tmux. c.f. http://stackoverflow.com/questions/10158508/lose-vim-colorscheme-in-tmux-mode
alias tmux="TERM=screen-256color-bce tmux"

# GIT
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gd='git diff'
alias gdc='git diff --cached'
alias gc='git commit'
alias gca='git commit -a'
alias gco='git checkout'
alias gb='git branch'
alias gs='git status'
alias gl='git log'

# RUBY MAGIC
alias irb='irb --readline -r irb/completion -rubygems' # use readline, completion and require rubygems by default for irb
alias server="echo 'ruby -run -e httpd . -p 5000'; ruby -run -e httpd . -p 5000"

# use: cdgem <gem name>, cd's into your gems directory and opens gem that best matches the gem name provided
function cdgem {
  cd /opt/local/lib/ruby/gems/1.8/gems/; cd `ls|grep $1|sort|tail -1`
}

# CODA - Open current dir in Coda.. or open given file
alias opencoda='osascript -e "tell application \"Coda\"" -e "tell document 1" -e "change local path \"${PWD}\"" -e "end tell" -e "end tell"'
function coda() {  osascript -e "tell application \"Coda\"" -e "tell document 1" -e "open \"${PWD}/$@\"" -e "end tell" -e "end tell";}

# BROWSERS
alias chrome="/usr/bin/open -a '/Applications/Google Chrome.app'"
alias ff="/usr/bin/open -a '/Applications/FireFox.app'"

# GIT CLEANING
function filter_wanted_branches {
  cat $@ | grep -v "master$" | grep -v "release$" | grep -v "patch$"
}
function merged_local {
  git branch --merged | filter_wanted_branches
}
function merged_remote {
  git branch -r --merged | filter_wanted_branches
}
function clean_merged {
  echo "Deleting local..."
  merged_local | xargs git branch -d
  echo "Pruning..."
  git remote prune origin
  echo "Deleting remote..."
  merged_remote | grep "origin\/" | sed "s/ *origin\///" | xargs git push origin --delete
}

function curr_branch {
  git branch | sed -n '/^\*/s/^\* //p'
}
function gpr {
  echo "git pull-request -b infusedsys:release -h wejrowski:$(curr_branch)"
  git pull-request -b infusedsys:release -h wejrowski:$(curr_branch)
}

# MISC UNUSED
# # vim bash (missing vim necessities.. I don't like it)
# set -o vi

# #brew install bash-completion
# if [ -f $(brew --prefix)/etc/bash_completion ]; then
#   . $(brew --prefix)/etc/bash_completion
# fi
