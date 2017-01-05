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

# source ~/.gvm/scripts/gvm
# 8.0_25 for BE/Alex
# export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_25.jdk/Contents/Home"
# u40 + for erie
export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_91.jdk/Contents/Home"

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
alias v=nvim
# alias vim="reattach-to-user-namespace vim" # fix tmux clipboard issue

# vim colors in tmux. c.f. http://stackoverflow.com/questions/10158508/lose-vim-colorscheme-in-tmux-mode

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


function param () {
  echo $(echo $@ | sed -e 's/[^a-zA-Z0-9\-]/\-/g')
}


# GIT CLEANING
function merged_bwlocal {
  git branch --merged | grep "bw-"
}
function merged_bwremote {
  git branch -r --merged | grep "bw-"
}
function curr_branch {
  git branch | sed -n '/^\*/s/^\* //p'
}

function git_clean {
  echo "Checking against $fg_bold[red]$(curr_branch)$reset_color"

  if [ "$merged_bwlocal" != "" ]; then; echo "Merged locals:"; fi
  for branch in `merged_bwlocal`; do; echo "  $fg_bold[yellow]$branch$reset_color"; done

  for branch in `merged_bwlocal`
  do
    echo "Delete local branch $fg_bold[red]$branch$reset_color? (y/n)"
    read yes
    if [ "$yes" = "y" ]
    then
      git branch --delete $branch
    fi
  done

  if [ "$merged_bwremote" != "" ]; then; echo "Merged remotes:"; fi
  for branch in `merged_bwremote`; do; echo "  $fg_bold[yellow]$branch$reset_color"; done
  for branch in `merged_bwremote`
  do
    echo "Delete remote branch $fg_bold[yellow]$branch$reset_color? (y/n)"
    read yes
    if [ "$yes" = "y" ]
    then
      echo "$branch" | sed "s/ *origin\///" | xargs git push origin --delete
    fi
  done

}

# MISC UNUSED
# #brew install bash-completion
# if [ -f $(brew --prefix)/etc/bash_completion ]; then
#   . $(brew --prefix)/etc/bash_completion
# fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export TERM="xterm-256color"

# POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(time context dir vcs)
# POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status rbenv)
# POWERLEVEL9K_STATUS_VERBOSE=false
# POWERLEVEL9K_SHORTEN_STRATEGY="truncate_middle"
# POWERLEVEL9K_SHORTEN_DIR_LENGTH=3
# source  ~/projects/powerlevel9k/powerlevel9k.zsh-theme

PROMPT_SUCCESS_COLOR=$FG[117]
PROMPT_FAILURE_COLOR=$FG[124]
PROMPT_VCS_INFO_COLOR=$FG[242]
PROMPT_PROMPT=$FG[077]
GIT_DIRTY_COLOR=$FG[009]
GIT_CLEAN_COLOR=$FG[118]
GIT_PROMPT_INFO=$FG[003]

# SEGMENT_SEPARATOR="\ue0b0"

# robby:
local ret_status="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ )"
# PROMPT='${ret_status} %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)'
##
# PROMPT='%{$PROMPT_SUCCESS_COLOR%}%~%{$reset_color%} %{$GIT_PROMPT_INFO%}$(git_prompt_info)%{$GIT_DIRTY_COLOR%}$(git_prompt_status) %{$reset_color%}%{$PROMPT_PROMPT%}ᐅ%{$reset_color%} '
BW_FILE_COLOR=$FG[245]

PROMPT='${ret_status}% %{$BW_FILE_COLOR%}%c%{$reset_color%} %{$GIT_PROMPT_INFO%}$(git_prompt_info) %{$GIT_DIRTY_COLOR%}$(git_prompt_status) %{$reset_color%}%{$PROMPT_PROMPT%}%{$reset_color%} '

#RPS1="${return_code}"

ZSH_THEME_GIT_PROMPT_PREFIX="("
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$GIT_PROMPT_INFO%})"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$GIT_DIRTY_COLOR%}✘"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$GIT_CLEAN_COLOR%}✔"

ZSH_THEME_GIT_PROMPT_ADDED="%{$FG[082]%}✚%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{$FG[166]%}✹%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DELETED="%{$FG[160]%}✖%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_RENAMED="%{$FG[220]%}➜%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{$FG[082]%}═%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$FG[190]%}✭%{$reset_color%}"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/brent.wejrowski/.sdkman"
[[ -s "/Users/brent.wejrowski/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/brent.wejrowski/.sdkman/bin/sdkman-init.sh"

# The next line updates PATH for the Google Cloud SDK.
source '/Users/brent.wejrowski/Desktop/google-cloud-sdk/path.zsh.inc'

# The next line enables shell command completion for gcloud.
source '/Users/brent.wejrowski/Desktop/google-cloud-sdk/completion.zsh.inc'
