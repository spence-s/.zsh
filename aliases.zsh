# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias ll="eza -T -L=1 -la --icons --git --color=always"
alias tree="tree -I 'node_modules'"
alias vim=nvim
alias pc=procs
# alias find=gfind
alias mongo=mongosh
alias ncu="ncu -i"
alias llb-token=llbToken

llbToken() {
	echo "\ngcloud auth login --update-adc --verbosity=info\n"
	gcloud auth login --update-adc --verbosity=info
	sleep 2
	export NPM_TOKEN=$(gcloud auth print-access-token)
	echo "\nSuccessfully updated NPM_TOKEN with gcp access token $NPM_TOKEN"
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
