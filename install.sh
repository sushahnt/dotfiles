if output=$(which pacman); then
    yes | sudo pacman -S neovim \
      git vim zsh tmux \
      python-pynvim \
      the_silver_searcher \
      docker docker-compose

    sudo systemctl enable docker
    sudo usermod -aG docker $USER
elif output=$(which apt-get); then
    sudo apt-get update -y
    sudo apt-get install neovim \
      python-dev python-pip python3-dev \
      python3-pip git zsh  silversearcher-ag \
      curl build-essential tmux -y
elif output=$(which brew); then
    brew install tmux \
      zsh neovim the_silver_searcher
else
    printf 'Update the code for os\n'
    exit 0
fi

# Make zsh as default shell
sudo chsh -s $(which zsh)

# Install vim-plug
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

mkdir -p ~/.config/nvim
mkdir -p ~/.config/nvim/backup

# link the vim, nvim, zsh, bash and tmux rc file
ln -sf ~/dotfiles/.vimrc ~/.config/nvim/init.vim
ln -sf ~/dotfiles/.vimrc ~/.vimrc
rm ~/.zshrc
ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.tmux.conf ~/.tmux.conf

# link vim custom snippet
ln -sf ~/dotfiles/snippets ~/.config/nvim/UltiSnips

# Install nvm & node
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.35.3/install.sh | bash
source ~/.zshrc
nvm install node
nvm use node

# Install Oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Git Configuration
touch ~/.gitignore_global
echo "tags" >> ~/.gitignore_global
git config --global core.excludesfile ~/.gitignore_global

git config --global user.email "sushant.shh@gmail.com"
git config --global user.name "Sushant Shah"
