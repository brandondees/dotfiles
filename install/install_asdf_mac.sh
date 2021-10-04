

# TODO: make this check (working install) first and not duplicate
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.1

# TODO: make this check first and not duplicate unnecessarily
echo ". $HOME/.asdf/asdf.sh" >> ~/.zshrc

# Optional for when not relying on oh-my-zsh plugin
# append completions to fpath
# fpath=(${ASDF_DIR}/completions $fpath)
# initialise completions with ZSH's compinit
# autoload -Uz compinit && compinit

