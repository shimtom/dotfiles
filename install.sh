#!/bin/bash -eux

DOTDIR=$(cd $(dirname $0); pwd)

declare -a info=($(${DOTDIR}/bin/get_os_info))
os=${info[0]}
dist=${info[1]}
bit=${info[2]}

function _pkg-manager() {
    case ${os} in
        mac)
            /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
            brew tap caskroom/cask
            brew update && brew upgrade
            ;;
        linux)
            case ${dist} in
                ubuntu | debian)
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

function _bash() {
    ln -s -f ${DOTDIR}/bash/bashrc ~/.bashrc
    ln -s -f ${DOTDIR}/bash/bash_profile ~/.bash_profile
    ln -s -f ${DOTDIR}/bash/bash_logout ~/.bash_logout
}

function _zsh(){
    case ${os} in
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

function _zplug() {
    if [ ! -d ~/.zplug ]; then
      curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
    fi
    if ! zsh -c "source ~/.zplug/init.zsh && zplug check"; then
      zsh -c "source ~/.zplug/init.zsh && zplug install"
    fi
    ln -s -f ~/.zplug/repos/sorin-ionescu/prezto ~/.zprezto
    ln -s -f ${DOTDIR}/zsh/prezto/module/prompt/functions/prompt_paradigm_setup ~/.zprezto/modules/prompt/functions/prompt_paradigm_setup
}

function _neovim() {
    case ${os} in
        mac)
            brew install neovim ;;
        linux)
            case ${dist} in
                ubuntu | debian)
                    sudo add-apt-repository ppa:neovim-ppa/unstable
                    sudo apt update
                    sudo apt install neovim ;;
                *)  echo "unsupported distribution(${dist})"
                    return 1 ;;
            esac ;;
        *)  echo "unsupported os(${os})"
            return 1 ;;
    esac

    # link neovim config
    mkdir -p ~/.config
    ln -s -f ${DOTDIR}/nvim/ ~/.config/nvim
    # install neovim python package
    pip3 install --upgrade neovim
}


# _pkg-manager
# _bash
# _zsh
# _python3
_zplug
_neovim

echo "finish set up"
