# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

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
source ~/.bash_profile # Personal alias' etc here

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

eval "$(hub alias -s)"
#vim bash (missing vim necessities.. I don't like it)
#set -o vi

# Aliases
alias myssh="cat ~/.ssh/id_rsa.pub;"
alias reload!="source ~/.zshrc; source ~/.bash_profile"
alias erc="mvim ~/.zshrc"
alias ebash="mvim ~/.bash_profile" # I keep my personal shortcuts here
alias ..='cd ..'       # move up 1 dir
alias ...='cd ../..'   # move up 2 dirs

alias server="echo 'ruby -run -e httpd . -p 5000'; ruby -run -e httpd . -p 5000"

alias mysql="/usr/local/mysql/bin/mysql"
alias mysqladmin=/usr/local/mysql/bin/mysqladmin
alias rvmcur="rvm info | grep GEM_HOME"

# GIT
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gd='git diff'
alias gc='git commit'
alias gca='git commit -a'
alias gco='git checkout'
alias gb='git branch'

# RUBY MAGIC
alias irb='irb --readline -r irb/completion -rubygems' # use readline, completion and require rubygems by default for irb

# use: cdgem <gem name>, cd's into your gems directory and opens gem that best matches the gem name provided
function cdgem {
  cd /opt/local/lib/ruby/gems/1.8/gems/; cd `ls|grep $1|sort|tail -1`
}

# CODA
# Open current dir in Coda.. or open given file
alias opencoda='osascript -e "tell application \"Coda\"" -e "tell document 1" -e "change local path \"${PWD}\"" -e "end tell" -e "end tell"'
function coda() {  osascript -e "tell application \"Coda\"" -e "tell document 1" -e "open \"${PWD}/$@\"" -e "end tell" -e "end tell";}

#BROWSERS
alias chrome="/usr/bin/open -a '/Applications/Google Chrome.app'"
alias ff="/usr/bin/open -a '/Applications/FireFox.app'"

# brew install bash-completion
#if [ -f $(brew --prefix)/etc/bash_completion ]; then
  #. $(brew --prefix)/etc/bash_completion
#fi
