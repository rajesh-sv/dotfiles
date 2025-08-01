PROMPT_EOL_MARK=""

# history
HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=2000

# Prevent blinking cursor.
function __set_beam_cursor {
    echo -ne '\e[6 q'
}

function __set_block_cursor {
    echo -ne '\e[2 q'
}

function zle-keymap-select {
  case $KEYMAP in
    vicmd) __set_block_cursor;;
    viins|main) __set_beam_cursor;;
  esac
}
zle -N zle-keymap-select

precmd_functions+=(__set_beam_cursor)

# vi editing mode
bindkey -v
bindkey "^H" backward-delete-char
bindkey "^?" backward-delete-char
bindkey "^n" expand-or-complete
bindkey "^p" reverse-menu-complete

# starship
eval "$(starship init zsh)"

# plugins
source ~/.config/zsh-plugins/fsh/fast-syntax-highlighting.plugin.zsh
source ~/.config/zsh-plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.config/zsh-plugins/fzf-history-search/zsh-fzf-history-search.zsh

# zsh-autosuggestions keybinds
bindkey "" forward-word
bindkey "" autosuggest-accept

# alias
alias ls='ls -A --color=auto --group-directories-first'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
alias ip='ip --color=auto'
alias y='yazi'
