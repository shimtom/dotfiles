# Dotfiles

[![lint](https://github.com/shimtom/dotfiles/actions/workflows/lint.yml/badge.svg)](https://github.com/shimtom/dotfiles/actions/workflows/lint.yml) [![macos](https://github.com/shimtom/dotfiles/actions/workflows/macos.yml/badge.svg)](https://github.com/shimtom/dotfiles/actions/workflows/macos.yml)

Install my dotfiles.

## Installation

```bash
git clone https://github.com/shimtom/dotfiles.git
cd dotfiles
./install.sh all
```

## Optional Set Up
### MacOS

```bash
# install brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# install font
brew tap homebrew/cask-fonts
brew install font-hackgen font-hackgen-nerd

# install fish and fisher plugins
brew install fish
echo /usr/local/bin/fish | sudo tee -a /etc/shells
chsh -s /usr/local/bin/fish

# install tmux
brew install tmux reattach-to-user-namespace
git clone https://github.com/tmux-plugins/tpm $XDG_CONFIG_HOME/tmux/plugins/tpm

# install neovim
brew install neovim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# install commands
brew install bat coreutils exa fd fzf git-delta hexyl peco procs ripgrep tree
```

### Ubuntu 20.04

```bash
# install hackgen fonts
for url in $(curl -s https://api.github.com/repos/yuru7/HackGen/releases/latest | grep "browser_download_url.*\.zip" | cut -d : -f 2,3 | tr -d \"); do
       filename=$(basename $url)
       wget $url
       unzip $filename
       mv ${filename%.zip} ~/.local/share/fonts/${filename%_*}
       rm $filename
done

# install fish and fisher plugins
sudo apt-add-repository ppa:fish-shell/release-3
sudo apt update
sudo apt install -y fish
chsh -s /usr/bin/fish

# install tmux
sudo apt install -y tmux

# install neovim
sudo apt install -y neovim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# install commands
sudo apt install bat fd-find fzf peco ripgrep tree unzip
# see https://github.com/sharkdp/bat/issues/938
sudo apt install -o Dpkg::Options::="--force-overwrite" hexyl ripgrep
# bat
sudo ln -sf /usr/bin/batcat /usr/local/bin/bat
# exa
EXA_VERSION=0.10.1
wget "https://github.com/ogham/exa/releases/download/v${EXA_VERSION}/exa-linux-x86_64-v${EXA_VERSION}.zip"
unzip exa-linux-x86_64-v"$EXA_VERSION".zip
sudo chown -R root:root exa-linux-x86_64 man completions
sudo mv -f bin/exa /usr/local/bin/exa
sudo mv -f man/* /usr/share/man/man1/
sudo mv -f completions/exa.bash /etc/bash_completion.d/
sudo mv -f completions/exa.fish /usr/share/fish/vendor_completions.d/
rm -rf exa-linux-x86_64-v"$EXA_VERSION".zip man completions
unset EXA_VERSION
# delta
url=$(curl -s https://api.github.com/repos/dandavison/delta/releases/latest | grep -E "browser_download_url.*git-delta_[0-9]+\.[0-9]+\.[0-9]+_amd64\.deb" | cut -d : -f 2,3 | tr -d \")
wget $url
sudo dpkg -i $(basename $url)
rm $(basename $url)

# procs
url=$(curl -s https://api.github.com/repos/dalance/procs/releases/latest | grep -E "browser_download_url.*procs-v[0-9]+\.[0-9]+\.[0-9]+-x86_64-lnx\.zip" | cut -d : -f 2,3 | tr -d \")
wget $url
unzip $(basename $url)
sudo chown root:root procs
sudo mv procs /usr/local/bin/procs
```
