# Enable command auto-completion
autoload -U compinit
compinit

# Enable history
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000

# Prompt (basic)
PROMPT='%n@%m %1~ %# '

# Enable suggestions and syntax highlighting (if installed)
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

