#!/bin/bash -eu

DOTDIR=$(cd $(dirname $0); pwd)

declare -a info=($(${DOTDIR}/bin/get_os_info))
OS_TYPE=${info[0]}
DIST=${info[1]}
BIT=${info[2]}

function status() {
  echo -e "\033[0;34m==>\033[0;39m ${@}"
}

function error(){
    status ${@}
    exit 1
}

function setup_pkg_manager() {
    status "Set up package manager"
    case ${OS_TYPE} in
        mac)
            status "Install homebrew"
            /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
            brew tap caskroom/cask
            brew update && brew upgrade ;;
        linux)
            case ${DIST} in
                ubuntu | debian)
                    status "Upgrade apt"
                    sudo apt update
                    sudo apt upgrade -y && sudo apt full-upgrade -y
                    sudo apt autoremove && sudo apt clean ;;
                *)  error "Unsupported DISTribution(${DIST})" ;;
            esac ;;
        *)  error "Unsupported os(${OS_TYPE})" ;;
    esac
}

function setup_curl() {
    case ${OS_TYPE} in
        mac) ;;
        linux)
            case ${DIST} in
                ubuntu | debian)
                    sudo apt update && sudo apt install -y curl ;;
                *) error "Unsupported DISTribution(${DIST})" ;;
            esac ;;
        *) error "Unsupported os(${OS_TYPE})" ;;
    esac
}

function setup_bash(){
    status "Link bash dotfiles"
    ln -s -f ${DOTDIR}/bash/bashrc ~/.bashrc
    ln -s -f ${DOTDIR}/bash/bash_profile ~/.bash_profile
    ln -s -f ${DOTDIR}/bash/bash_logout ~/.bash_logout
}

function setup_zsh(){
    # Install zsh
    status "Install zsh"
    case ${OS_TYPE} in
        mac)
            brew install zsh ;;
        linux)
            case ${DIST} in
                ubuntu | debian)
                    sudo apt update && sudo apt install -y zsh ;;
                *) error "Unsupported DISTribution(${DIST})" ;;
            esac ;;
        *) error "Unsupported os(${OS_TYPE})" ;;
    esac

    # Link zsh dotfiles
    status "Link zsh dotfiles"
    ln -s -f ${DOTDIR}/zsh/zlogin ~/.zlogin
    ln -s -f ${DOTDIR}/zsh/zlogout ~/.zlogout
    ln -s -f ${DOTDIR}/zsh/zprofile ~/.zprofile
    ln -s -f ${DOTDIR}/zsh/zshenv ~/.zshenv
    ln -s -f ${DOTDIR}/zsh/zshrc ~/.zshrc
}

function setup_zplug() {
    if type "zsh" > /dev/null 2>&1; then
        setup_zsh
    fi

    # Install zplug command
    status "Install zplug"
    if [ ! -d ~/.zplug ]; then
        if type "curl" > /dev/null 2>&1; then
            setup_curl
        fi
        curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
    fi

    # Install zplug plugins in zshrc
    if ! zsh -c "source ~/.zplug/init.zsh && zplug check"; then
        status "Install zplug plugins"
        zsh -c "source ~/.zplug/init.zsh && zplug install"
    fi
}

function setup_python(){
    status "Install python"
    case ${OS_TYPE} in
        mac)
            brew install python ;;
        linux)
            case ${DIST} in
                ubuntu | debian)
                    sudo apt update
                    sudo apt install -y python python-dev python-pip python-setuptools python-venv
                    sudo apt install -y python3 python3-dev python3-pip python3-setuptools python3-venv ;;
                *) error "Unsupported DISTribution(${DIST})" ;;
            esac ;;
        *) error "Unsupported os(${OS_TYPE})" ;;
    esac
}

function setup_neovim() {
    # Install neovim
    status "Install neovim"
    case ${OS_TYPE} in
        mac)
            brew install neovim ;;
        linux)
            case ${DIST} in
                ubuntu)
                    sudo apt update && sudo apt install -y software-properties-common
                    sudo add-apt-repository -y ppa:neovim-ppa/stable
                    sudo apt update && sudo apt install -y neovim ;;
                *) error "Unsupported DISTribution(${DIST})" ;;
            esac ;;
        *) error "Unsupported os(${OS_TYPE})" ;;
    esac

    # set up neovim
    status "Set up neovim packages"
    pip3 install --upgrade neovim
    # install dein.vim
    if type "curl" > /dev/null 2>&1; then
        setup_curl
    fi
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

function setup_texlive() {
    case ${OS_TYPE} in
        mac)
            brew install ghostscript
            brew cask install basictex
            sudo tlmgr paper a4
            sudo tlmgr update --self --all
            sudo tlmgr install collection-langjapanese latexmk ;;
        linux)
            case ${DIST} in
                ubuntu | debian)
                    sudo apt install -y texlive-full ;;
                *) error "Unsupported DISTribution(${DIST})" ;;
            esac ;;
        *) error "Unsupported os(${OS_TYPE})" ;;
    esac

}

function setup_latexmk(){
    setup_texlive
    status "Set up latexmk"
    ln -s -f ${DOTDIR}/latexmk/latexmkrc ~/.latexmkrc
}

function setup_git() {
    status "Install git"
    case ${OS_TYPE} in
        mac)
            brew install git ;;
        linux)
            case ${DIST} in
                ubuntu | debian)
                    sudo apt update && sudo apt install -y git ;;
                *) error "Unsupported DISTribution(${DIST})" ;;
            esac ;;
        *) error "Unsupported os(${OS_TYPE})" ;;
    esac

    status "Set up git"
    ln -s -f ${DOTDIR}/git/gitignore_global ~/.gitignore_global
    cp -f ${DOTDIR}/git/gitconfig ~/.gitconfig
}

function setup_powerline() {
    # Install powerline
    status "Install powerline"
    case ${OS_TYPE} in
        mac|linux)
            pip install powerline-status
            pip install powerline-gitstatus
            pip install powerline-exitstatus
            pip install psutil ;;
        *) error "Unsupported os(${OS_TYPE})" ;;
    esac

    # Install powerline font
    status "Install powerline font"
    git clone https://github.com/powerline/fonts.git --depth=1 /tmp/fonts
    /tmp/fonts/install.sh "Source Code Pro"
    rm -rf /tmp/fonts/
    status "set powerline font!"

    # link powerline dotfiles
    status "Link powerline dotfiles"
    mkdir -p ~/.config/powerline
    mkdir -p ~/.config/powerline/themes/shell
    mkdir -p ~/.config/powerline/themes/tmux
    mkdir -p ~/.config/powerline/colorschemes
    ln -s -f ${DOTDIR}/powerline/config.json ~/.config/powerline/config.json
    ln -s -f ${DOTDIR}/powerline/themes/shell/original.json ~/.config/powerline/themes/shell/original.json
    ln -s -f ${DOTDIR}/powerline/themes/tmux/original.json ~/.config/powerline/themes/tmux/original.json
    ln -s -f ${DOTDIR}/powerline/colorschemes/default.json ~/.config/powerline/colorschemes/default.json

}

function setup_tmux() {
    status "Install tmux"
    case ${OS_TYPE} in
        mac)
            brew install reattach-to-user-namespace
            brew install tmux ;;
        linux)
            apt update && apt install -y tmux ;;
        *) error "Unsupported os(${OS_TYPE})" ;;
    esac

    ln -s -f ${DOTDIR}/tmux/tmux.conf ~/.tmux.conf
}

function setup_anyenv() {
    status "Install anyenv"
    git clone https://github.com/riywo/anyenv ~/.anyenv
    mkdir -p ~/.anyenv/plugins
    git clone https://github.com/znz/anyenv-update.git ~/.anyenv/plugins/anyenv-update
    exec $SHELL -l
    anyenv install pyenv 
    exec $SHELL -l
    pyenv install 3.6.6

}

status "OS is ${OS_TYPE}"
setup_pkg_manager
setup_git
setup_bash
setup_zsh
setup_zplug
setup_python
setup_neovim
setup_latexmk
setup_powerline
setup_tmux
setup_anyenv
