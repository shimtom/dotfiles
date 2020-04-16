# Dotfiles for mac

Install dotfiles and dependencies for mac.


## Feature
* brew
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
export DOTFILES ~/dotfiles
```


### brew

```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap caskroom/cask
brew update && brew upgrade
export DOTFILES ~/dotfiles
```


### bash

```bash
ln -s -f ${DOTFILES}/bash/bashrc ~/.bashrc
ln -s -f ${DOTFILES}/bash/bash_profile ~/.bash_profile
ln -s -f ${DOTFILES}/bash/bash_logout ~/.bash_logout
```


### fish
depend on `brew`

```bash
# install fish shell
brew install fish curl
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
depend on `brew`

```bash
# install git
brew install git git-lfs
# just copy because `.gitconfig` needs user setting
cp -f ${DOTFILES}/git/gitignore_global ~/.gitignore_global
# link other config files
ln -s -f ${DOTFILES}/git/gitignore_global ~/.gitignore_global
ln -s -f ${DOTFILES}/git/gitmessage ~/.gitmessage
```


## direnv
depend on `brew`

```bash
brew install direnv
```


### peco
depend on `brew`

```bash
brew install peco
```


### anyenv
depend on `brew` and `git`

```bash
brew install anyenv
~/.anyenv/bin/anyenv init
mkdir -p $(~/.anyenv/bin/anyenv root)/plugins
git clone https://github.com/znz/anyenv-update.git $(anyenv root)/plugins/anyenv-update
```


### python
depend on `brew` and `anyenv`

```bash
brew install python3
# install pipx for global packages
pip3 install pipx
# install pyenv
anyenv install pyenv
# install poetry
pipx install poetry
poetry config virtualenvs.in-project true
```


### powerline
depend on `brew` and `python`

```bash
# install powerline with pipx
pipx install powerline-status
# install powerline-fonts
brew install wget
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
depend on `brew`

```bash
# install tmux
brew install tmux reattach-to-user-namespace
# config tmux
mkdir -p ~/.config/tmux/
ln -s -f ${DOTFILES}/tmux/tmux.conf ~/.tmux.conf
ln -s -f ${DOTFILES}/tmux/bin ~/.config/tmux/bin
```


### vim
depend on `brew`

```bash
# install neovim
brew install neovim
```


### latex
depend on `brew`

```bash
# install latex
brew cask install basictex
brew install ghostscript
# install tex packages
sudo tlmgr update --self --all
sudo tlmgr install collection-langjapanese latexmk texdoc latexindent \
    chktex cite siunitx helvetic courier fontaxes boondox txfonts \
    kastrup tex-gyre newtx preprint
# config
sudo tlmgr paper a4
ln -s -f ${DOTFILES}/latexmkrc ~/.latexmkrc
```
