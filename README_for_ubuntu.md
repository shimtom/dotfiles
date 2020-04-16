# Dotfiles for ubuntu

Install dotfiles and dependencies for ubuntu.


## Feature
* bash
* fish
* git
* direnv
* peco
* anyenv
* python
* powerline
* tmux
* vim
* latex


## Set up
### prepare

```bash
sudo apt update
sudo apt upgrade -y
sudo apt full-upgrade -y
sudo apt autoremove -y
sudo apt clean -y
export DOTFILES ~/dotfiles
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


### git

```bash
# install git
sudo apt update
sudo apt install -y git git-lfs
# just copy because `.gitconfig` needs user setting
cp -f ${DOTFILES}/git/gitignore_global ~/.gitignore_global
# link other config files
ln -s -f ${DOTFILES}/git/gitignore_global ~/.gitignore_global
ln -s -f ${DOTFILES}/git/gitmessage ~/.gitmessage
```


### direnv

```bash
sudo apt update
sudo apt install -y direnv
```


### peco

```bash
sudo apt update
sudo apt install -y peco
```


### anyenv
depend on `git`

```bash
git clone https://github.com/riywo/anyenv ~/.anyenv
~/.anyenv/bin/anyenv init
mkdir -p $(~/.anyenv/bin/anyenv root)/plugins
git clone https://github.com/znz/anyenv-update.git $(~/.anyenv/bin/anyenv root)/plugins/anyenv-update
```


### python
depend on `anyenv`

```bash
sudo apt update
sudo apt install -y python3 python3-pip python3-venv
# install pipx for global packages
pip3 install pipx
# install pyenv
~/.anyenv/bin/anyenv install pyenv
# install poetry
pipx install poetry
poetry config virtualenvs.in-project true
```


### powerline
depend on `python`

```bash
# install powerline with pipx
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
sudo apt install -y xclip tmux
# config tmux
mkdir -p ~/.config/tmux/
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
