# Dotfiles for ubuntu

Install my dotfiles and dependencies.

## Feature
* package manager (apt)
* bash
* fish
* peco
* tmux
* vim
* git
* imagemagick
* ffmpeg
* python
* latex

## Set up
### set `DOTFILES` environment variable that indicate `dotfiles/` path

```bash
export DOTFILES /path/to/dotfiles
```

### package manager (apt)

```bash
sudo apt update
sudo apt upgrade -y
sudo apt full-upgrade -y
sudo apt autoremove -y
sudo apt clean -y
```

### git

```bash
# install git
sudo apt update
sudo apt install -y git
# just copy because `.gitconfig` needs user setting
cp -f ${DOTFILES}/git/gitignore_global ~/.gitignore_global
# link other config files
ln -s -f ${DOTFILES}/git/gitignore_global ~/.gitignore_global
ln -s -f ${DOTFILES}/git/gitmessage ~/.gitmessage
```

### bash

```bash
ln -s -f ${DOTFILES}/bash/bashrc ~/.bashrc
ln -s -f ${DOTFILES}/bash/bash_profile ~/.bash_profile
ln -s -f ${DOTFILES}/bash/bash_logout ~/.bash_logout
```

### fish

```bash
# install fish shell
sudo apt update
sudo apt install -y fish curl
# config fish
mkdir -p ~/.config/fish
mkdir -p ~/.config/fish/functions
ln -s -f ${DOTFILES}/fish/config.fish ~/.config/fish/config.fish
# install fisher
curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
fisher add jethrokuan/z
fisher add oh-my-fish/plugin-peco
fisher add oh-my-fish/theme-bobthefish
```

### peco

```bash
sudo apt update
sudo apt install -y peco
```

### powerline

```bash
# install powerline with dependencies
sudo apt install -y python3-pip python3-venv
pip3 install pipx
pipx install powerline-status
# install powerline-fonts
wget https://github.com/mzyy94/RictyDiminished-for-Powerline/archive/3.2.4-powerline-early-2016.zip -O /tmp/ricty.zip
unzip ricty.zip
mv /tmp/RictyDiminished-for-Powerline-3.2.4-powerline-early-2016/*.ttf ~/.local/share/fonts
mv /tmp/RictyDiminished-for-Powerline-3.2.4-powerline-early-2016/powerline-fontpatched/*.ttf ~/.local/share/fonts
rm -f /tmp/ricty /tmp/ricty.zip
# config powerline
mkdir -p ~/.config/powerline
ln -s -f ${DOTFILES}/powerline/config.json ~/.config/powerline/
ln -s -f ${DOTFILES}/powerline/colorscheme ~/.config/powerline/colorscheme
ln -s -f ${DOTFILES}/powerline/themes ~/.config/powerline/themes
```

### tmux

```bash
# install tmux
sudo apt update
sudo apt install -y tmux
# config tmux
mkdir -p ~/.config/tmux/bin/
ln -s -f ${DOTFILES}/tmux/tmux.conf ~/.tmux.conf
ln -s -f ${DOTFILES}/tmux/bin ~/.config/tmux/bin
```

### vim

```bash
# install neovim
sudo apt update
sudo apt install -y neovim
```

### latex

```bash
# install latex
sudo apt update
sudo apt install -y texlive-full ghostscript evince
# install tex packages
tlmgr update --self --all
tlmgr install collection-langjapanese latexmk texdoc latexindent \
    chktex cite siunitx helvetic courier fontaxes boondox txfonts \
    kastrup tex-gyre newtx preprint
# config
tlmgr paper a4
ln -s -f ${DOTFILES}/latexmkrc ~/.latexmkrc
```

### python

```bash
sudo apt update
sudo apt install -y python3-pip python3-venv pipenv
pip3 install pipx
```

### powerline

```bash
# depend on python
pipx install powerline-status
```
