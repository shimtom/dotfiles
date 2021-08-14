#!/usr/bin/env bash

set -ue

DOTFILES="$(pwd)"
COLOR_GRAY="\033[1;38;5;243m"
COLOR_BLUE="\033[1;34m"
COLOR_GREEN="\033[1;32m"
COLOR_RED="\033[1;31m"
COLOR_PURPLE="\033[1;35m"
COLOR_YELLOW="\033[1;33m"
COLOR_NONE="\033[0m"

title() {
    echo -e "\n${COLOR_PURPLE}$1${COLOR_NONE}"
    echo -e "${COLOR_GRAY}==============================${COLOR_NONE}\n"
}

error() {
    echo -e "${COLOR_RED}Error: ${COLOR_NONE}$1"
    exit 1
}

warning() {
    echo -e "${COLOR_YELLOW}Warning: ${COLOR_NONE}$1"
}

info() {
    echo -e "${COLOR_BLUE}Info: ${COLOR_NONE}$1"
}

success() {
    echo -e "${COLOR_GREEN}$1${COLOR_NONE}"
}

setup_bash() {
    title "Setting up Bash"

    for file in "$DOTFILES/bash/bashrc" "$DOTFILES/bash/bash_profile" "$DOTFILES/bash/bash_logout"; do
        target="$HOME/.$(basename "$file")"
        if [ -e "$target" ]; then
            info "~${target#$HOME} already exists... Skipping"
        else
            info "Creating symlink for $file"
            ln -s "$file" "$target"
    done
}

setup_config() {
    title "Setting up config"

    XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-~/.config}

    info "installing to $XDG_CONFIG_HOME"
    if [ ! -d "$XDG_CONFIG_HOME" ]; then
        info "Creating $XDG_CONFIG_HOME"
        mkdir -p "$XDG_CONFIG_HOME"
    fi

    for config in $(find -H "$DOTFILES/config" -depth 1); do
        target="$XDG_CONFIG_HOME/$(basename "$config")"
        if [ -e "$target" ]; then
            info "~${target#$XDG_CONFIG_HOME} already exists... Skipping"
        else
            info "Creating symlink for $config"
            ln -s "$config" "$target"
        fi
    done
}

setup_git() {
    title "Setting up Git"

    defaultName=$(git config user.name)
    defaultEmail=$(git config user.email)

    read -rp "Name [$defaultName]: " name
    read -rp "Email [$defaultEmail]: " email

    git config -f ~/.gitconfig-local user.name "${name:-$defaultName}"
    git config -f ~/.gitconfig-local user.email "${email:-$defaultEmail}"

    if [[ "$(uname)" == "Darwin" ]]; then
        git config --global credential.helper "osxkeychain"
    else
        read -rn 1 -p "Save user and password to an unencrypted file to avoid writing? [y/N]: " save
        if [[ $save =~ ^([Yy])$ ]]; then
            git config --global credential.helper "store"
        else
            git config --global credential.helper "cache --timeout 3600"
        fi
    fi
}


case "$1" in
    minimum)
        setup_bash
        ;;
    link)
        setup_bash
        setup_config
        ;;
    git)
        setup_git
    all)
        setup_bash
        setup_config
        setup_git
        ;;
    *)
        echo -e $"\nUsage: $(basename "$0") {minimum|link|git|all}\n"
        exit 1
        ;;
esac

echo -e
success "Done."
