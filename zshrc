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

# Personal alias' etc here
source ~/.bash_profile

########################
# bash_profile contents: 
########################
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

eval "$(hub alias -s)"

# MISC
alias myssh="cat ~/.ssh/id_rsa.pub;"
alias ezshrc="mvim ~/.zshrc"
alias ebash="mvim ~/.bash_profile" #I keep my personal shortcuts here
alias reload!="source ~/.zshrc; source ~/.bash_profile"
#set -o vi #vim bash--missing vim necessities.. don't like it.
alias ..='cd ..'       # move up 1 dir
alias ...='cd ../..'   # move up 2 dirs

# RUBY MAGIC
alias irb='irb --readline -r irb/completion -rubygems' # use readline, completion and require rubygems by default for irb

alias mysql="/usr/local/mysql/bin/mysql"
alias mysqladmin=/usr/local/mysql/bin/mysqladmin
alias rvmcur="rvm info | grep GEM_HOME"

# use: cdgem <gem name>, cd's into your gems directory and opens gem that best matches the gem name provided
function cdgem {
  cd /opt/local/lib/ruby/gems/1.8/gems/; cd `ls|grep $1|sort|tail -1`
}

# Open current dir in Coda.. or open given file
alias opencoda='osascript -e "tell application \"Coda\"" -e "tell document 1" -e "change local path \"${PWD}\"" -e "end tell" -e "end tell"'
function coda() {  osascript -e "tell application \"Coda\"" -e "tell document 1" -e "open \"${PWD}/$@\"" -e "end tell" -e "end tell";}
