# Path to oh-my-zsh installation.
export ZSH=~/.oh-my-zsh

# Name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
ZSH_THEME=""

# TMUX
# Automatically start tmux
ZSH_TMUX_AUTOSTART=true

# Automatically connect to a previous session if it exists
ZSH_TMUX_AUTOCONNECT=true

# Enable command auto-correction.
ENABLE_CORRECTION="true"

# Display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git node brew tmux lwb)

# User configuration
# Hide user@hostname if it's expected default user
DEFAULT_USER="ctay20"
prompt_context(){}

# Setting rg as the default source for fzf
export FZF_DEFAULT_COMMAND='rg --files'

# Apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Set location of z installation
. /usr/local/etc/profile.d/z.sh

## FZF FUNCTIONS ##

# fo [FUZZY PATTERN] - Open the selected file with the default editor
#   - Bypass fuzzy finder if there's only one match (--select-1)
#   - Exit if there's no match (--exit-0)
fo() {
  local files
  IFS=$'\n' files=($(fzf-tmux --query="$1" --multi --select-1 --exit-0))
  [[ -n "$files" ]] && ${EDITOR:-vim} "${files[@]}"
}

# fh [FUZZY PATTERN] - Search in command history
fh() {
  print -z $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed 's/ *[0-9]* *//')
}

# fbr [FUZZY PATTERN] - Checkout specified branch
# Include remote branches, sorted by most recent commit and limited to 30
fgb() {
  local branches branch
  branches=$(git for-each-ref --count=30 --sort=-committerdate refs/heads/ --format="%(refname:short)") &&
  branch=$(echo "$branches" |
           fzf-tmux -d $(( 2 + $(wc -l <<< "$branches") )) +m) &&
  git checkout $(echo "$branch" | sed "s/.* //" | sed "s#remotes/[^/]*/##")
}

# tm [SESSION_NAME | FUZZY PATTERN] - create new tmux session, or switch to existing one.
# Running `tm` will let you fuzzy-find a session mame
# Passing an argument to `ftm` will switch to that session if it exists or create it otherwise
ftm() {
  [[ -n "$TMUX" ]] && change="switch-client" || change="attach-session"
  if [ $1 ]; then
    tmux $change -t "$1" 2>/dev/null || (tmux new-session -d -s $1 && tmux $change -t "$1"); return
  fi
  session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0) &&  tmux $change -t "$session" || echo "No sessions found."
}

# tm [SESSION_NAME | FUZZY PATTERN] - delete tmux session
# Running `tm` will let you fuzzy-find a session mame to delete
# Passing an argument to `ftm` will delete that session if it exists
ftmk() {
  if [ $1 ]; then
    tmux kill-session -t "$1"; return
  fi
  session=$(tmux list-sessions -F "#{session_name}" 2>/dev/null | fzf --exit-0) &&  tmux kill-session -t "$session" || echo "No session found to delete."
}

# fuzzy grep via rg and open in vim with line number
fgr() {
  local file
  local line

  read -r file line <<<"$(rg --no-heading --line-number $@ | fzf -0 -1 | awk -F: '{print $1, $2}')"

  if [[ -n $file ]]
  then
     vim $file +$line
  fi
}

# git add, commit and push in one
gacp() {
    git add .
    git commit -a -m "$1"
    git push
}

# Enabled zsh-autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# Set default editor to nvim
export EDITOR='nvim'

# Enabled true color support for terminals
export NVIM_TUI_ENABLE_TRUE_COLOR=1

# Aliases
alias vim="nvim"
alias top="vtop --theme=wizard"

source $ZSH/oh-my-zsh.sh

# Set Spaceship as prompt
autoload -U promptinit; promptinit
prompt spaceship
SPACESHIP_PACKAGE_SHOW=false
SPACESHIP_NODE_SHOW=false
SPACESHIP_GIT_STATUS_STASHED=''

# Load nvm
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

# A place to to store api key and such
source $HOME/.secrets

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /Users/sheakelly/code/lwb/cloudfront/node_modules/tabtab/.completions/serverless.zsh ]] && . /Users/sheakelly/code/lwb/cloudfront/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /Users/sheakelly/code/lwb/cloudfront/node_modules/tabtab/.completions/sls.zsh ]] && . /Users/sheakelly/code/lwb/cloudfront/node_modules/tabtab/.completions/sls.zsh

# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[[ -f /Users/sheakelly/code/lwb/www-lwb-org-au/node_modules/tabtab/.completions/slss.zsh ]] && . /Users/sheakelly/code/lwb/www-lwb-org-au/node_modules/tabtab/.completions/slss.zsh

eval "$(pyenv init -)"

export LWB_USER='shea.kelly@lwb.org.au'
export AWS_DEFAULT_PROFILE='lwb'
export AWS_PROFILE='lwb'

[ -f "/Users/sheakelly/.ghcup/env" ] && source "/Users/sheakelly/.ghcup/env" # ghcup-env
