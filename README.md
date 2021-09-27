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
cat <<EOF > /usr/local/bin/fishlogin
#!/bin/bash -l
exec -l fish "$@"
EOF
sudo chmod a+rx /usr/local/bin/fishlogin
echo /usr/local/bin/fishlogin | sudo tee -a /etc/shells
chsh -s /usr/local/fishlogin $USER
curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher
fish -c "curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher"
fisher update

# install tmux
brew install tmux reattach-to-user-namespace
git clone https://github.com/tmux-plugins/tpm ${XDG_CONFIG_HOME:-$HOME/.config}/tmux/plugins/tpm

# install neovim
brew install neovim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# install commands
brew install bat coreutils exa fd fzf git-delta hexyl peco procs ripgrep tree
```

### Ubuntu
* Support: Ubuntu 20.04, 21.04

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
sudo cat <<EOF > /usr/local/bin/fishlogin
#!/bin/bash -l
exec -l fish "$@"
EOF
sudo chmod a+rx /usr/local/bin/fishlogin
echo /usr/local/bin/fishlogin | sudo tee -a /etc/shells
chsh -s /usr/local/fishlogin $USER
fish -c "curl -sL https://git.io/fisher | source && fisher install jorgebucaran/fisher"
fisher update

# install tmux
sudo apt install -y tmux
git clone https://github.com/tmux-plugins/tpm ${XDG_CONFIG_HOME:-$HOME/.config}/tmux/plugins/tpm

# install neovim
sudo apt install -y neovim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# install commands
sudo apt install -y bat fd-find fzf peco ripgrep tree

# bat, hexyl, ripgrep
## Ubuntu 21.04
sudo apt install -y hexyl ripgrep
## Ubuntu 20.04
# # see https://github.com/sharkdp/bat/issues/938
# sudo apt install -o Dpkg::Options::="--force-overwrite" hexyl ripgrep

sudo ln -sf $(which batcat) /usr/local/bin/bat
sudo ln -sf $(which fdfind) /usr/local/bin/fd
# exa
## Ubuntu 21.04
sudo apt install -y exa
## Ubuntu 20.04
# url=$(curl -s https://api.github.com/repos/ogham/exa/releases/latest | grep -E "browser_download_url.*exa-linux-x86_64-v[0-9]+\.[0-9]+\.[0-9]+\.*\.zip" | cut -d : -f 2,3 | tr -d \")
# wget $url
# unzip $(basename $url) -d exa
# sudo chown -R root:root exa
# sudo mv -f exa/bin/exa /usr/local/bin/exa
# sudo mv -f man/* /usr/share/man/man1/
# sudo mv -f exa/completions/exa.bash /etc/bash_completion.d/
# sudo mv -f exa/completions/exa.fish /usr/share/fish/vendor_completions.d/
# rm -rf $(basename $url) exa

# delta
url=$(curl -s https://api.github.com/repos/dandavison/delta/releases/latest | grep -E "browser_download_url.*git-delta_[0-9]+\.[0-9]+\.[0-9]+_amd64\.deb" | cut -d : -f 2,3 | tr -d \")
wget $url
sudo dpkg -i $(basename $url)
rm -f $(basename $url)

# procs
url=$(curl -s https://api.github.com/repos/dalance/procs/releases/latest | grep -E "browser_download_url.*procs-v[0-9]+\.[0-9]+\.[0-9]+-x86_64-lnx\.zip" | cut -d : -f 2,3 | tr -d \")
wget $url
unzip $(basename $url)
sudo chown root:root procs
sudo mv procs /usr/local/bin/procs
rm $(basename $url)
```
