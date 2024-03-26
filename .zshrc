#--------------------------------------------------------------------------
# Oh My Zsh
#--------------------------------------------------------------------------
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"
HYPHEN_INSENSITIVE="true"
COMPLETION_WAITING_DOTS="true"
HIST_STAMPS="yyyy-mm-dd"
VI_MODE_SET_CURSOR=true
VI_MODE_RESET_PROMPT_ON_MODE_CHANGE=true

plugins=(
    npm
    vi-mode
    ssh-agent
    zsh-z
    zsh-autosuggestions
    docker
    docker-compose
    git
    tmux
)

source $ZSH/oh-my-zsh.sh
# export PATH="$HOME/.tmuxifier/bin:$PATH"
# eval "$(tmuxifier init -)"
#--------------------------------------------------------------------------
# Aliases
#--------------------------------------------------------------------------

alias vim="nvim"
alias copy="xclip -selection clipboard"
alias paste="xclip -o -selection clipboard"

# PHP
alias a="php artisan"

# Git
alias g="git"
alias gs="git s"
alias nah="git reset --hard;git clean -df"
alias co="git checkout"
alias pull="git pull"
alias push="git push"
alias main='git checkout $([ `git rev-parse --quiet --verify master` ] && echo "master" || echo "main")'
alias lg="lazygit"

# Docker
alias d="docker"
alias dc="docker compose"

# NPM
alias serve="npm run serve"
alias install="npm run install"
alias testu="npm run test:unit"

#
alias ssh="kitty +kitten ssh"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# export PATH="$HOME/.rbenv/bin:$PATH"
# eval "$(rbenv init -)"
export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"
eval $(/home/linuxbrew/.linuxbrew/Homebrew/bin/brew shellenv)

if [[ $- == *i* && $0 == '/usr/bin/zsh' ]]; then
    ~/code/eriklennstrom/dotfiles/scripts/login.sh
fi

export PATH=$PATH:/home/e18m/.spicetify
export PATH=$PATH:/usr/local/go/bin:/home/e18m/go/bin
export PATH=$PATH:/home/e18m/.local/bin

# bun completions
[ -s "/home/e18m/.bun/_bun" ] && source "/home/e18m/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
# composer
export PATH=~/.config/composer/vendor/bin:$PATH
# pnpm
export PNPM_HOME="/home/e18m/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
