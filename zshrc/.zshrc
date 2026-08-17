# fastfetch with cutom image:
# fastfetch --kitty-direct /home/DROS/.config/fastfetch/Pictures/anime20width.png

fastfetch --logo "${FASTFETCH_LOGO:-auto}"

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

#editor:
export EDITOR="nvim"

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Platformtheme    
export QT_QPA_PLATFORMTHEME=qt6ct

export GDK_BACKEND=wayland,x11
export GS_DEBUG=1

ZSH_THEME="powerlevel10k/powerlevel10k"


# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
zstyle ':omz:update' mode reminder  # just remind me to update when it's time

ENABLE_CORRECTION="false"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="mm/dd/yyyy"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-syntax-highlighting fast-syntax-highlighting zsh-autosuggestions zsh-autocomplete)

source $ZSH/oh-my-zsh.sh

# User configuration

# Enable command auto-completion
autoload -U compinit
compinit

# Enable history
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh

#Custom key-bindings:
export FZF_DEFAULT_OPTS="--bind=tab:up,shift-tab:down"
bindkey '\ea' fzf-history-widget
bindkey -M vicmd '\ea' fzf-history-widget
bindkey -M viins '\ea' fzf-history-widget
bindkey -M emacs '^[;' autosuggest-accept
bindkey -M viins '^[;' autosuggest-accept

# Aliases
alias i="yay -S"
alias in="yay -S --needed"
alias r="yay -Rns"
alias u="yay -Syu"
alias s="yay -Ss"
alias q="yay -Q"

alias cat="bat --theme base16"

alias rm="trash"
alias nnn='nnn -x'

alias ls='lsd'
alias l='lsd -l'
alias la='lsd -a'
alias lla='lsd -la'
alias lt='lsd --tree'

alias ga='git add -A'
alias gm='git commit -m'
alias gp='git push'
alias gpp='aicommits -a -y && git push'

alias n='nvim'

alias y='yazi'
alias sy='sudo yazi'

alias st='stow -t ~'
alias dot='cd ~/Repos/MyArch/'

# To customize prompt, run `p10k configure` or edit ~/Repos/MyArch/p10k/.p10k.zsh.
[[ ! -f ~/Repos/MyArch/p10k/.p10k.zsh ]] || source ~/Repos/MyArch/p10k/.p10k.zsh
export AMD_VULKAN_ICD=RADV
export RADV_PERFTEST=llvm
export PATH=$PATH:/usr/lib/vinegar
export PATH=$PATH:/usr/lib/vinegar
export LIBVA_DRIVER_NAME=i965

# Autosuggestions color
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE=
export PATH=/home/DROS/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/var/lib/flatpak/exports/bin:/usr/lib/jvm/default/bin:/usr/bin/site_perl:/usr/bin/vendor_perl:/usr/bin/core_perl:/var/lib/snapd/snap/bin:/usr/lib/vinegar:/usr/lib/vinegar:$HOME/go/bin

# zoxide
eval "$(zoxide init --cmd cd zsh)"


# Added by Antigravity CLI installer
export PATH="/home/DROS/.local/bin:$PATH"
