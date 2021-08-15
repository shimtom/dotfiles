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
        info "Creating symlink for $file"
        ln -sf "$file" "$target"
    done
}

setup_config() {
    title "Setting up config"

    XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-~/.config}

    info "Installing to $XDG_CONFIG_HOME"
    if [ ! -d "$XDG_CONFIG_HOME" ]; then
        info "Creating $XDG_CONFIG_HOME"
        mkdir -p "$XDG_CONFIG_HOME"
    fi

    while IFS= read -r -d '' config; do
        target="$XDG_CONFIG_HOME/$(basename "$config")"
        info "Creating symlink for $config"
        rm -rf "$target"
        ln -sf "$config" "$target"
    done <   <(find -H "$DOTFILES/config" -mindepth 1 -maxdepth 1 -print0)
}

setup_git() {
    title "Setting up Git"

    defaultName=$(git config user.name)
    defaultEmail=$(git config user.email)

    read -rp "Name [$defaultName]: " name
    read -rp "Email [$defaultEmail]: " email

    git config -f ~/.gitconfig_local user.name "${name:-$defaultName}"
    git config -f ~/.gitconfig_local user.email "${email:-$defaultEmail}"

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

backup() {
    BACKUP_DIR=$HOME/dotfiles-backup

    echo "Creating backup directory at $BACKUP_DIR"
    mkdir -p "$BACKUP_DIR" "$BACKUP_DIR/config"

    # backup bash
    for file in "$DOTFILES/bash/bashrc" "$DOTFILES/bash/bash_profile" "$DOTFILES/bash/bash_logout"; do
        filename=".$(basename "$file")"
        target="$HOME/$filename"
        if [ -f "$target" ]; then
            echo "backing up $filename"
            cp "$target" "$BACKUP_DIR"
        else
            warning "$filename does not exist at this location or is a symlink"
        fi
    done

    # backup xdg config
    XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-~/.config}

    while IFS= read -r -d '' config; do
        config=$(basename "$config")
        target="$XDG_CONFIG_HOME/$config"

        if [ -f "$target" ] || [ -d "$target" ]; then
            echo "backing up $config"
            cp -rf "$target" "$BACKUP_DIR/config"
        else
            warning "$config does not exist at this location or is a symlink"
        fi
    done <   <(find -H "./config" -mindepth 1 -maxdepth 1 -print0)

}


case "$1" in
    backup)
        backup
        ;;
    minimum)
        setup_bash
        ;;
    link)
        setup_bash
        setup_config
        ;;
    git)
        setup_git
        ;;
    all)
        backup
        setup_bash
        setup_config
        setup_git
        ;;
    *)
        echo -e $"\nUsage: $(basename "$0") {backup|minimum|link|git|all}\n"
        exit 1
        ;;
esac

echo -e
success "Done."
