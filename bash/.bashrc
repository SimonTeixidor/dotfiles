export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME=$HOME/.local/share
export XDG_CACHE_HOME=$HOME/.cache
export XENVIRONMENT="$XDG_CONFIG_HOME/X11/Xresources"
export VIMINIT='let $MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc" | source $MYVIMRC'
export VIMDOTDIR="$XDG_CONFIG_HOME/vim"
export HISTFILE="$XDG_DATA_HOME"/bash/history
export GNUPGHOME=${XDG_CONFIG_HOME}/gnupg
export INPUTRC="$XDG_CONFIG_HOME/readline/inputrc"
export PASSWORD_STORE_DIR="$XDG_CONFIG_HOME/pass/"
export LESSHISTFILE=-
export CARGO_HOME="$XDG_CACHE_HOME/cargo/"
export RUSTUP_HOME="$XDG_CACHE_HOME/rustup/"
export SQLITE_HISTORY="$XDG_DATA_HOME/sqlite_history"
export XINITRC="$XDG_CONFIG_HOME"/X11/xinitrc

eval `dircolors $XDG_CONFIG_HOME/dircolors/config`
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'
bind '"\C-[OA": history-search-backward'
bind '"\C-[OB": history-search-forward'

HISTSIZE=
HISTFILESIZE=
HISTCONTROL=ignoredups:ignorespace
if [ -n "$SSH_CLIENT" ]; then
	export PS1="\u@\h \w> "
else 
	export PS1="\[\e[1;32m\]\w \\$\[$(tput sgr0)\] \[\e[0m\]"
fi
export EDITOR='vim'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias sbt="sbt -ivy \"$XDG_DATA_HOME\"/ivy2 -sbt-dir \"$XDG_DATA_HOME\"/sbt"

export PATH=$PATH:~/bin:~/.cache/cargo/bin/

function ccat() {
	cat "$@" | xclip -i -selection clipboard
}
