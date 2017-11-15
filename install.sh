#!/bin/bash -eu

DOTDIR=$(cd $(dirname $0); pwd)

declare -a info=($(${DOTDIR}/bin/get_os_info))


function status() {
    echo "---> ${@}"
}

function _pkg-manager() {
    status "pkg-manager"
    case ${info[0]} in
        ubuntu | debian)
            sudo apt update && sudo apt upgrade -y
            sudo apt install -y software-properties-common
            ;;
        mac)
            /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
            brew tap caskroom/cask
            brew update && brew upgrade
            ;;
        *)
            echo "unsupported distribution(${info[0]})"
            return 1
            ;;
    esac

    return 0
}

function _bash() {
    ln -s -f ${DOTDIR}/bash/bashrc ~/.bashrc
    ln -s -f ${DOTDIR}/bash/bash_profile ~/.bash_profile
    ln -s -f ${DOTDIR}/bash/bash_logout ~/.bash_logout
}

function _zsh(){
    case ${info[0]} in
        ubuntu | debian)
            sudo apt install zsh ;;
        mac)
            brew install zsh ;;
        *)
            echo "unsupported distribution(${info[0]})"
            return 1
            ;;
    esac

    ln -s -f ${DOTDIR}/zsh/zlogin ~/.zlogin
    ln -s -f ${DOTDIR}/zsh/zlogout ~/.zlogout
    ln -s -f ${DOTDIR}/zsh/zpreztorc ~/.zpreztorc
    ln -s -f ${DOTDIR}/zsh/zprofile ~/.zprofile
    ln -s -f ${DOTDIR}/zsh/zshenv ~/.zshenv
    ln -s -f ${DOTDIR}/zsh/zshrc ~/.zshrc

    return 0
}

function _python3(){
    case ${info[0]} in
        ubuntu | debian)
            sudo apt install -y python-qt4 python3-dev python3-pip python3-setuptools python3-venv
            ;;
        mac)
            brew install python3
            ;;
        *)
            echo "unsupported distribution(${info[0]})"
            return 1
            ;;
    esac
}

function _zplug() {
    curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh

    zplug install
    ln -s -f zsh/prezto/module/prompt/functions/prompt_paradigm_setup ~/.zprezto/module/prompt/functions/prompt_paradigm_setup
}

function _neovim() {
    case ${info[0]} in
        ubuntu | debian)
            if ! type "add-apt-repository" > /dev/null 2>&1; then
                _pkg-manager
            fi
            sudo add-apt-repository ppa:neovim-ppa/unstable
            sudo apt update
            sudo apt install neovim
            ;;
        mac)
            if ! type "brew" > /dev/null 2>&1; then
                _pkg-manager
            fi
            brew install python3
            ;;
        *)
            echo "unsupported distribution(${info[0]})"
            return 1
            ;;
    esac
    # link neovim config
    ln -s -f ${DOTDIR%/}/nvim/ ~/.config/nvim

    if ! type "pip3" > /dev/null 2>&1; then
        _python3
    fi
    # install neovim python package
    pip3 install --upgrade neovim
}


_pkg-manager
_bash
_zsh
_python3
_zplug
_neovim
