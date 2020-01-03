# Zsh 5.3.1 is required.

autoload -Uz compinit
if [[ "$OSTYPE" =~ ^darwin.* ]]; then
  [[ $(date +'%j') == $(stat -f '%Sm' -t '%j' ~/.zcompdump) ]]
else
  [[ $(date +'%j') == $(date -d "`stat -c '%z' ~/.zcompdump`" +'%j') ]]
fi
if [[ $? != 0 ]]; then
  compinit
  # On mac, it seems that ~/.zcompdump modification time is not updated when
  # executing `compinit`, so we force updating it.
  touch ~/.zcompdump
else
  compinit -C
fi

source ~/.zsh_plugins.sh
source ~/.zsh/configs.zsh
source ~/.zsh/completions.zsh

# Load library scripts
source ~/.dotfiles/scripts/lib/prompt.sh
source ~/.dotfiles/scripts/lib/fzf.sh

# Load custom functions
for function in ~/.zsh/functions/*; do
  source $function
done

[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh
[[ -f ~/.zsh/history.zsh ]] && source ~/.zsh/history.zsh
[[ -f ~/.asdf/asdf.sh ]] && source ~/.asdf/asdf.sh

[[ -f ~/.zshrc.platform ]] && source ~/.zshrc.platform
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
