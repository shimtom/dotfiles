#!/bin/bash -eu

DOTDIR=$(cd $(dirname $0); pwd)

declare -a info=($(${DOTDIR}/bin/get_os_info))
os=${info[0]}
dist=${info[1]}
bit=${info[2]}

function status() {
  echo -e "\033[0;34m==>\033[0;39m ${@}"
}

function _pkg-manager() {
    case ${os} in
        mac)
            status "set up homebrew to install dependencies"
            /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
            brew tap caskroom/cask
            brew update && brew upgrade
            ;;
        linux)
            case ${dist} in
                ubuntu | debian)
                    status "upgrade apt to install dependencies"
                    sudo apt update && sudo apt upgrade -y
                    sudo apt install -y software-properties-common
                    ;;
                *)  echo "unsupported distribution(${dist})"
                    return 1 ;;
            esac ;;
        *)  echo "unsupported os(${os})"
            return 1 ;;
    esac

    return 0
}

function bash() {
    status "set up bash dotfiles"
    ln -s -f ${DOTDIR}/bash/bashrc ~/.bashrc
    ln -s -f ${DOTDIR}/bash/bash_profile ~/.bash_profile
    ln -s -f ${DOTDIR}/bash/bash_logout ~/.bash_logout
}

function _zplug() {
    if [ ! -d ~/.zplug ]; then
      curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
    fi
    if ! zsh -c "source ~/.zplug/init.zsh && zplug check"; then
      zsh -c "source ~/.zplug/init.zsh && zplug install"
    fi
    ln -s -f ~/.zplug/repos/sorin-ionescu/prezto ~/.zprezto
    ln -s -f ${DOTDIR}/zsh/prezto/modules/prompt/functions/prompt_paradigm_setup ~/.zprezto/modules/prompt/functions/prompt_paradigm_setup
}

function zsh(){
    case ${os} in
        status "set up zsh dotfiles"
        mac)
            brew install zsh ;;
        linux)
            case ${dist} in
                ubuntu | debian)
                    sudo apt install zsh ;;
                *)  echo "unsupported distribution(${dist})"
                    return 1 ;;
            esac ;;
        *)  echo "unsupported os(${os})"
            return 1 ;;
    esac

    ln -s -f ${DOTDIR}/zsh/zlogin ~/.zlogin
    ln -s -f ${DOTDIR}/zsh/zlogout ~/.zlogout
    ln -s -f ${DOTDIR}/zsh/zpreztorc ~/.zpreztorc
    ln -s -f ${DOTDIR}/zsh/zprofile ~/.zprofile
    ln -s -f ${DOTDIR}/zsh/zshenv ~/.zshenv
    ln -s -f ${DOTDIR}/zsh/zshrc ~/.zshrc

    _zplug

    return 0
}

function _python3(){
    case ${os} in
        mac)
            brew install python3 ;;
        linux)
            case ${dist} in
                ubuntu | debian)
                    sudo apt install -y python-qt4 python3-dev python3-pip python3-setuptools python3-venv ;;
                *)  echo "unsupported distribution(${dist})"
                    return 1 ;;
            esac ;;
        *)  echo "unsupported os(${os})"
            return 1 ;;
    esac
}

function neovim() {
    status "Install neovim"
    case ${os} in
        mac)
            brew install neovim ;;
        linux)
            curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage -o /usr/local/bin/nvim
            chmod u+x /usr/loca/bin/nvim ;;
        *)  echo "unsupported os(${os})"
            return 1 ;;
    esac

    status "Set up neovim packages"
    # install neovim python package
    _python3
    pip3 install --upgrade neovim
    # install dein.vim
    curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > /tmp/installer.sh
    mkdir -p ~/.cache
    sh /tmp/installer.sh ~/.cache/dein
    # link neovim dotfiles
    mkdir -p ~/.config/nvim/plugins
    ln -s -f ${DOTDIR}/nvim/init.vim ~/.config/nvim/init.vim
    ln -s -f ${DOTDIR}/nvim/editor.vim ~/.config/nvim/editor.vim
    ln -s -f ${DOTDIR}/nvim/core.vim ~/.config/nvim/core.vim
    ln -s -f ${DOTDIR}/nvim/appearance.vim ~/.config/nvim/appearance.vim
    ln -s -f ${DOTDIR}/nvim/plugins/dein.toml ~/.config/nvim/plugins/dein.toml
    ln -s -f ${DOTDIR}/nvim/plugins/dein_lazy.toml ~/.config/nvim/plugins/dein_lazy.toml
    ln -s -f ${DOTDIR}/nvim/plugins/dein_theme.toml ~/.config/nvim/plugins/dein_theme.toml
    ln -s -f ${DOTDIR}/nvim/plugins/dein_python.toml ~/.config/nvim/plugins/dein_python.toml

    status "Neovim packages installed for the first startup"
    echo
}

function tex() {
    status "Set up tex"
    case ${os} in
        mac)
            brew install ghostscript
            brew cask install basictex
            sudo tlmgr paper a4
            sudo tlmgr update --self --all
            sudo tlmgr install collection-langjapanese latexmk ;;
        *)  echo "unsupported os(${os})"
            return 1 ;;
    esac
    ln -s -f ${DOTDIR}/latexmkrc ~/.latexmkrc
    echo
}

function git() {
    status "Set up git"
    ln -s -f ${DOTDIR}/git/gitignore_global ~/.gitignore_global
    ln -s -f ${DOTDIR}/git/gitconfig ~/.gitconfig
}

status "os is ${os}"
_pkg-manager
bash
zsh
neovim
tex
git
