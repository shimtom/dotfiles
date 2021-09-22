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
# install font
HACKGEN_VERSION=2.4.1
wget https://github.com/yuru7/HackGen/releases/download/v$HACKGEN_VERSION/HackGen_v$HACKGEN_VERSION.zip
wget https://github.com/yuru7/HackGen/releases/download/v$HACKGEN_VERSION/HackGenNerd_v$HACKGEN_VERSION.zip
unzip HackGen_v$HACKGEN_VERSION.zip
unzip HackGenNerd_v$HACKGEN_VERSION.zip
mv HackGen_v$HACKGEN_VERSION /usr/local/share/fonts/HackGen
mv HackGenNerd_v$HACKGEN_VERSION /usr/local/share/fonts/HackGenNerd
rm -rf HackGen_v$HACKGEN_VERSION.zip HackGenNerd_v$HACKGEN_VERSION.zip
unset HACKGEN_VERSION

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
DELTA_VERSION=0.8.3
wget -O - https://github.com/dandavison/delta/releases/download/"$DELTA_VERSION"/delta-"$DELTA_VERSION"-x86_64-unknown-linux-gnu.tar.gz | tar zxvf -
sudo chown root:root delta-"$DELTA_VERSION"-x86_64-unknown-linux-gnu/delta
sudo mv -f delta-"$DELTA_VERSION"-x86_64-unknown-linux-gnu/delta /usr/local/bin/
rm -rf delta-"$DELTA_VERSION"-x86_64-unknown-linux-gnu/
unset DELTA_VERSION
# procs
PROCS_VERSION=0.11.9
wget "https://github.com/dalance/procs/releases/download/v$PROCS_VERSION/procs-v$PROCS_VERSION-x86_64-lnx.zip"
unzip procs-v$PROCS_VERSION-x86_64-lnx.zip
sudo chown root:root procs
sudo mv procs /usr/local/bin/procs
rm -rf procs-v$PROCS_VERSION-x86_64-lnx.zip
unset PROCS_VERSION
```
