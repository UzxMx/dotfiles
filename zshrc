# Zsh 5.3.1 is required.

source ~/.zsh_plugins.sh

PURE_PROMPT_VICMD_SYMBOL="[VIM]❯"

bindkey -v
bindkey "^A" beginning-of-line
bindkey "^E" end-of-line
bindkey "^P" up-line-or-search
bindkey "^N" down-line-or-search
bindkey '^F' forward-char
bindkey '^B' backward-char
bindkey '^R' history-incremental-search-backward
bindkey '^W' backward-kill-word
bindkey "^V" edit-command-line

# By default, there is a 0.4 second delay after you hit the <ESC> key and when
# the mode change is registered. This results in a very jarring and frustrating
# transition between modes. Let's reduce this delay to 0.1 seconds.
# This can result in issues with other terminal commands that depended on this
# delay. If you have issues try raising the delay.
export KEYTIMEOUT=1

# load custom executable functions
for function in ~/.zsh/functions/*; do
  source $function
done

# If you come from bash you might have to change your $PATH.
export PATH=$HOME/.local/bin:$HOME/.bin:$HOME/bin:/usr/local/bin:$PATH

# Disable pry in rails console by default.
export DISABLE_PRY_RAILS=1

_load_settings() {
  _dir="$1"
  if [ -d "$_dir" ]; then
    if [ -d "$_dir/pre" ]; then
      for config in "$_dir"/pre/**/*(N-.); do
        if [ ${config:e} = "zwc" ] ; then continue ; fi
        . $config
      done
    fi

    for config in "$_dir"/**/*(N-.); do
      case "$config" in
        "$_dir"/pre/*)
          :
          ;;
        "$_dir"/post/*)
          :
          ;;
        *)
          if [[ -f $config && ${config:e} != "zwc" ]]; then
            . $config
          fi
          ;;
      esac
    done

    if [ -d "$_dir/post" ]; then
      for config in "$_dir"/post/**/*(N-.); do
        if [ ${config:e} = "zwc" ] ; then continue ; fi
        . $config
      done
    fi
  fi
}
_load_settings "$HOME/.zsh/configs"

unsetopt share_history

# Change directory without prefix cd
setopt AUTO_CD

# Bash like completion
setopt noautomenu

file="/usr/share/autojump/autojump.sh"
if [ -e $file ]; then
  source $file
fi

[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local

# aliases
[[ -f ~/.aliases ]] && source ~/.aliases

export SDKMAN_DIR="$HOME/.sdkman"
load_sdkman() {
  [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
}

export PATH="$HOME/.rbenv/bin:$PATH"
if type rbenv >/dev/null; then
  rbenv() {
    eval "$(command rbenv init -)"
    [ -s /etc/profile.d/rbenv.sh ] && . /etc/profile.d/rbenv.sh
    rbenv "$@"
  }
fi

load_lua() {
  [ -s ~/.luaver/luaver ] && . ~/.luaver/luaver
}

# So as not to be disturbed by Ctrl-S ctrl-Q in terminals
stty -ixon

load_kubectl() {
  if [ $commands[kubectl] ]; then
    source <(kubectl completion zsh)
  fi
}

nvm() {
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
  nvm $@
}
