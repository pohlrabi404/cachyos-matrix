# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
  if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
  fi

  source /usr/share/cachyos-zsh-config/cachyos-config.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
  [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

#
# Utilities
#
  function stowcurrent() {
    local dir=$(basename $(pwd))
    cd ..
    stow -v $dir
    cd $dir
  }

  function rebosedit() {
    nvim ~/.config/rebos/imports/system.toml
  }
  function rebosinstall() {
    rebos gen commit "$1"
    rebos gen current build
  }

  function szsh() {
    source ~/.zshrc
  }

  ### Config repo
  function pconfig() {
    eval $(ssh-agent -s) 
    ssh-add $HOME/.ssh/id_matrix
    cd $HOME/dotfiles/pohlrabi/.config
  }
  # function pwiki() {
  #   eval $(ssh-agent -s)
  #   ssh-add $HOME/.ssh/id_wiki
  #   cd $HOME/wiki/knowledge
  # }
  function pobsidian() {
    eval $(ssh-agent -s)
    ssh-add $HOME/.ssh/id_obsidian
    cd $HOME/vaults/
  }

#
# Alias
#
  alias ls='ls -la'
  alias ..='cd ..'
  alias ...='cd ...'
  alias ....='cd ....'

#
# Vi mode
#
  bindkey -v

#
# FZF keybind
#
  source <(fzf --zsh)

#
# Nvim Profiles
#
  alias jvim="NVIM_PROFILE=jupyter nvim"
  alias pvim="NVIM_PROFILE=python nvim"
