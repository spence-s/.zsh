# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias ll="eza -T -L=1 -la --icons=auto --git --color=auto ."
alias tree="tree -I 'node_modules'"
alias vim=nvim
alias pc=procs
alias ncu="ncu -i"
alias tx="rsync -avz --exclude=node_modules --exclude=dist --exclude=.history"
alias tf=terraform

# Pull a project from the other computer over SSH into ~/Projects.
# Use a generic SSH host alias configured in each computer's ~/.ssh/config
# to keep machine-specific hostnames and usernames out of this shared file.
txp() {
	[[ $# -eq 1 ]] || { echo "Usage: txp <project>" >&2; return 1; }
	tx "sync-peer:~/Projects/$1/" "$HOME/Projects/$1/"
}

# Transfer native Pi sessions without deleting destination-only files.
# Pull before starting Pi and push after exiting it. The SSH alias is
# resolved by each machine's SSH config; newer destination files are kept.
# This does not merge sessions continued independently on both machines.
pi-sync() {
  local peer='sync-peer'

  case "${1:-}" in
    pull)
      rsync -avzu "${peer}:.pi/agent/sessions/" "${HOME}/.pi/agent/sessions/" \
        && echo "Pi sessions pulled successfully from ${peer}."
      ;;
    push)
      rsync -avzu "${HOME}/.pi/agent/sessions/" "${peer}:.pi/agent/sessions/" \
        && echo "Pi sessions pushed successfully to ${peer}."
      ;;
    *)
      printf 'Usage: pi-sync pull|push\n' >&2
      return 2
      ;;
  esac
}

# iterm tab title
# https://gist.github.com/phette23/5270658#gistcomment-3530342
if [ $ITERM_SESSION_ID ]; then
	DISABLE_AUTO_TITLE="true"
	precmd() {
		# sets the tab title to current dir
		echo -ne "\e]1;${PWD##*/}\a"
	}
fi

listening() {
	if [ $# -eq 0 ]; then
		lsof -iTCP -sTCP:LISTEN -n -P
	elif [ $# -eq 1 ]; then
		lsof -iTCP -sTCP:LISTEN -n -P | grep -i --color $1
	else
		echo "Usage: listening [pattern]"
	fi
}

brewd() {
	GREEN=$(tput setaf 2)
	BLUE=$(tput setaf 4)
	ENDCOLOR=$(tput sgr0)

	echo "${BLUE}updating homebrew...${ENDCOLOR}"
	brew update
	echo "${GREEN}updating homebrew finished in $SECONDS seconds${ENDCOLOR}\n"

	START=$SECONDS
	echo "${BLUE}upgrading homebrew...${ENDCOLOR}"
	brew upgrade
	echo "${GREEN}upgrading homebrew finished in $((SECONDS - START)) seconds${ENDCOLOR}\n"

	START=$SECONDS
	echo "${BLUE}cleaning up homebrew..."
	brew cleanup
	echo "${GREEN}cleaning up homebrew finished in $((SECONDS - START)) seconds${ENDCOLOR}"
}
