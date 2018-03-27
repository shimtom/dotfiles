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
    status "Set up package manager"
    case ${os} in
        mac)
            status "Install homebrew"
            /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
            brew tap caskroom/cask
            brew update && brew upgrade
            ;;
        linux)
            case ${dist} in
                ubuntu | debian)
                    status "Upgrade apt"
                    sudo apt update
                    sudo apt upgrade -y && sudo apt full-upgrade -y
                    sudo apt autoremove && sudo apt clean
                    ;;
                *)  status "Unsupported distribution(${dist})"
                    return 1 ;;
            esac ;;
        *)  status "Unsupported os(${os})"
            return 1 ;;
    esac

    return 0
}

function preparation() {
    case ${os} in
        linux)
            case ${dist} in
                ubuntu | debian)
                    sudo apt install -y curl
                    ;;
            esac ;;
    esac
}

function bash() {
    status "Link bash dotfiles"
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
    status "Set up zsh dotfiles"

    status "Install zsh"
    case ${os} in
        mac)
            brew install zsh ;;
        linux)
            case ${dist} in
                ubuntu | debian)
                    sudo apt install -y zsh ;;
                *)  echo "unsupported distribution(${dist})"
                    return 1 ;;
            esac ;;
        *)  echo "unsupported os(${os})"
            return 1 ;;
    esac

    status "Link zsh dotfiles"
    ln -s -f ${DOTDIR}/zsh/zlogin ~/.zlogin
    ln -s -f ${DOTDIR}/zsh/zlogout ~/.zlogout
    ln -s -f ${DOTDIR}/zsh/zpreztorc ~/.zpreztorc
    ln -s -f ${DOTDIR}/zsh/zprofile ~/.zprofile
    ln -s -f ${DOTDIR}/zsh/zshenv ~/.zshenv
    ln -s -f ${DOTDIR}/zsh/zshrc ~/.zshrc

    status "Install zplug"
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
                    sudo apt install -y python-qt4 python-dev python-pip python3-dev python3-pip python3-setuptools python3-venv ;;
                *)  status "unsupported distribution(${dist})"
                    return 1 ;;
            esac ;;
        *)  status "unsupported os(${os})"
            return 1 ;;
    esac
}

function neovim() {
    status "Install neovim"
    case ${os} in
        mac)
            brew install neovim ;;
        linux)
            case ${dist} in
                ubuntu)
                    sudo add-apt-repository ppa:neovim-ppa/stable
                    sudo apt update
                    sudo apt install neovim ;;
                *)
                    curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage -o /usr/local/bin/nvim
                    chmod u+x /usr/loca/bin/nvim ;;
            esac ;;
        *)  echo "unsupported os(${os})"
            return 1 ;;
    esac

    status "Set up neovim packages"
    # install neovim python package
    _python3
    pip3 install --upgrade neovim
    # install dein.vim
    curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > /tmp/installer.sh
    mkdir -p ~/.cache/dein
    sh /tmp/installer.sh ~/.cache/dein
    # link neovim dotfiles
    status "Link neovim dotfiles"
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
}

function _texlive() {
    case ${os} in
        mac)
            brew install ghostscript
            brew cask install basictex
            sudo tlmgr paper a4
            sudo tlmgr update --self --all
            sudo tlmgr install collection-langjapanese latexmk ;;
        linux)
            case ${dist} in
                ubuntu | debian)
                    sudo apt install -y texlive-full ;;
                *)  status "Unsupported distribution(${dist})"
                    return 1 ;;
            esac ;;
        *)  status "Unsupported os(${os})"
            return 1 ;;
    esac
}

function latexmk() {
    status "Set up latexmk"
    _texlive
    ln -s -f ${DOTDIR}/latexmkrc ~/.latexmkrc
}

function git() {
    status "Set up git"
    ln -s -f ${DOTDIR}/git/gitignore_global ~/.gitignore_global
    ln -s -f ${DOTDIR}/git/gitconfig ~/.gitconfig
}

status "OS is ${os}"
_pkg-manager
preparation
bash
zsh
neovim
tex
git
