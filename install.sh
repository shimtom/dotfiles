#!/usr/bin/env bash

set -u


show_spinner() {
    local -r frames='/-\|'
    local -r n=${#frames}

    local -r pid="$1"
    local -r msg="$2"

    local i=0
    local frame_text=""

    # Provide more space so that the text hopefully
    # doesn't reach the bottom line of the terminal window.
    #
    # This is a workaround for escape sequences not tracking
    # the buffer position (accounting for scrolling).
    #
    # See also: https://unix.stackexchange.com/a/278888
    echo -e "\n\n"
    tput cuu 3
    tput sc

    # Display spinner while the commands are being executed.
    while kill -0 "$pid" &> /dev/null; do
        frame_text="[${frames:i++%n:1}] $msg"

        # print frame text.
        echo -n "$frame_text"
        sleep 0.2

        # clear frame text.
        echo -ne "\r"
    done

}

print_title() {
    echo -e "${COLOR_PURPLE}$1${COLOR_NONE}"
}

print_warning() {
    echo -e "[${COLOR_YELLOW}!${COLOR_NONE}] $1"
}

print_skip() {
    echo -e "[ ] $1  ${COLOR_YELLOW}... skipped${COLOR_NONE}"
}

print_error() {
    echo -e "[${COLOR_RED}✖${COLOR_NONE}] $1" 1>&2
}

error_stream() {
    while read -r line; do
        echo -e "↳ ${COLOR_RED}ERROR: $line${COLOR_NONE}" 1>&2
    done
}

print_result() {
    if [ "$1" -eq 0 ]; then
        # success
        echo -e "[${COLOR_GREEN}✔${COLOR_NONE}] $2"
    elif [ "$1" -eq 1 ]; then
        print_error "$2"
    else
        print_skip "$2"
    fi

    return "$1"
}

ask() {
    echo -e -n "[${COLOR_YELLOW}?${COLOR_NONE}] $1: "
    read -r
}

ask_for_confirmation() {
    echo -e -n "[${COLOR_YELLOW}?${COLOR_NONE}] $1 (y/n): "
    read -r
}

kill_all_subprocesses() {
    local pid=""
    jobs -p

    for pid in $(jobs -p); do
        kill "$pid"
        wait "$pid" &> /dev/null
    done
}

execute() {
    local -r cmd="$1"
    local -r msg="${2:-$1}"
    local -r tmp_file="$(mktemp /tmp/dotfiles.XXXXX)"

    local exit_code=0
    local cmd_pid=""

    # If the current process is ended,
    # also end all its subprocesses.
    trap -p "EXIT" | grep "kill_all_subprocesses" &> /dev/null \
        || trap 'kill_all_subprocesses' "EXIT"

    # Execute commands in background
    # shellcheck disable=SC2261
    # eval "$cmd" &> /dev/null 2> "$tmp_file" &
    eval "$cmd" \
        &> /dev/null \
        2> "$tmp_file" &
    cmd_pid=$!

    # Show a spinner if the commands
    # require more time to complete.
    show_spinner "$cmd_pid" "$msg"

    # Wait for the commands to no longer be executing
    # in the background, and then get their exit code.
    wait "$cmd_pid" &> /dev/null
    exit_code=$?

    # Print output based on what happened.
    print_result $exit_code "$msg"

    if [ $exit_code -ne 0 ]; then
        error_stream < "$tmp_file"
    fi

    rm -rf "$tmp_file"

    return $exit_code
}

get_unique_name() {
    local -r original_name="$1"
    local n=0
    local name="$original_name"

    while [ -e "$name" ]; do
        name="$original_name-$((++n))"
    done
    echo "$name"
}

link() {
    local -r source="$1"
    local -r target="$2"

    if "$FORCE"; then
        execute "ln -sf $source $target" "link '$source' → '$target'"
    else
        if [ -e "$target" ] && [ ! -L "$target" ]; then
            if "$BACKUP"; then
                backup_target="$(get_unique_name "$BACKUP_DIR"/"$(basename "$target" | sed -e "s/^\.//")")"
                execute "mv $target $backup_target" "backup '$target' → '$backup_target'"
                execute "ln -s $source $target" "link '$source' → '$target'"
            elif "$INTERACTIVE"; then
                ask_for_confirmation "'$target' already exists, do you want to overwrite it?"
                if [[ $REPLY =~ ^([Yy])$ ]]; then
                    execute "ln -sf $source $target" "link '$source' → '$target'"
                else
                    print_skip "link '$source' → '$target'"
                fi
            else
                print_error "link '$source' → '$target'"
                echo "'$target' already exists." | error_stream
            fi
        else
            execute "ln -s $source $target" "link '$source' → '$target'"
        fi
    fi

    return 0
}

setup_sh() {
    local -r file="$DOTFILES/sh/profile"
    local -r target="$HOME/.$(basename "$file")"

    print_title "Shell"
    link "$file" "$target"
}

setup_bash() {
    print_title "Bash"

    for file in "$DOTFILES/bash/bashrc" "$DOTFILES/bash/bash_logout"; do
        target="$HOME/.$(basename "$file")"

        link "$file" "$target"
    done
}

setup_zsh() {
    local -r file="$DOTFILES/zsh/zshrc"
    local -r target="$HOME/.$(basename "$file")"

    print_title "Zsh"
    link "$file" "$target"
}

setup_config() {
    local -r XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-~/.config}
    local target

    print_title "\$XDG_CONFIG_HOME/config"

    if [ ! -d "$XDG_CONFIG_HOME" ]; then
        execute "mkdir -p $XDG_CONFIG_HOME" "make \$XDG_CONFIG_HOME directory: '$XDG_CONFIG_HOME'"
    fi

    while IFS= read -r -d '' config; do
        target="$XDG_CONFIG_HOME/$(basename "$config")"
        link "$config" "$target"
    done <   <(find -H "$DOTFILES/config" -mindepth 1 -maxdepth 1 -print0)

}

setup_git() {
    local -r default_name=$(git config user.name)
    local -r default_email=$(git config user.email)

    print_title "Git"

    ask "Enter git user name [$default_name]"
    name="${REPLY:-$default_name}"
    ask "Enter git user email [$default_email]"
    email="${REPLY:-$default_email}"

    execute "git config -f ~/.gitconfig.local user.name $name" "set git user name: '$name'"
    execute "git config -f ~/.gitconfig.local user.email $email" "set git user email: '$email'"

    if [ "$(uname -s)" == "Darwin" ]; then
        execute "git config -f ~/.gitconfig.local credential.helper 'osxkeychain'" "set git credential helper: 'osxkeychain'"
    else
        ask_for_confirmation "Save user and password to an unencrypted file to avoid writing?"
        if [[ $REPLY =~ ^([Yy])$ ]]; then
            execute "git config -f ~/.gitconfig.local credential.helper 'store'" "set git credential helper: 'store'"
        else
            execute "git config -f ~/.gitconfig.local credential.helper 'cache --timeout 3600'" "set git credential helper: 'cache --timeout 3600'"
        fi
    fi
}


# shellcheck disable=SC2034 disable=SC2155
{
    MINIMUM=false
    BACKUP=false
    FORCE=false
    INTERACTIVE=false

    readonly DOTFILES="$(pwd)"
    readonly BACKUP_DIR="$(get_unique_name "$HOME/dotfiles.backup")"

    readonly COLOR_GRAY="\033[1;38;5;243m"
    readonly COLOR_BLUE="\033[1;34m"
    readonly COLOR_GREEN="\033[1;32m"
    readonly COLOR_RED="\033[1;31m"
    readonly COLOR_PURPLE="\033[1;35m"
    readonly COLOR_YELLOW="\033[1;33m"
    readonly COLOR_NONE="\033[0m"
}


for opt in "$@"; do
    case "$opt" in
        --minimum)
            MINIMUM=true
            ;;
        -b | --backup)
            BACKUP=true
            ;;
        -f | --force)
            FORCE=true
            ;;
        -i | --interactive)
            INTERACTIVE=true
            ;;
        -h | --help)
            echo "Usage:"
            echo "  install.sh [OPTION]"
            echo "  install.sh --minimum [OPTION]"
            echo
            echo "Install dotfiles."
            echo
            echo " --minimum          install only standard shell dotfiles"
            echo " -b, --backup       make a backup of each existing destnation"
            echo " -i, --interactive  prompt whether to remove destinations"
            echo " -f, --force        remove existing destinations"
            echo " -h, --help         display this help and exist"
            exit 0
            ;;
        *)
            echo "illegal option or syntax: '$opt'" 1>&2
            exit 1
    esac
done


if "$BACKUP" &&  [ ! -e "$BACKUP_DIR" ]; then
    print_title "Backup Preparation"
    execute "mkdir -p $BACKUP_DIR" "make backup directory: '$BACKUP_DIR'"
fi

if "$MINIMUM"; then
    setup_sh
    if [ "$(uname -s)" == "Darwin" ]; then
        setup_zsh
    else
        setup_bash
    fi
else
    setup_sh
    if [ "$(uname -s)" == "Darwin" ]; then
        setup_zsh
    else
        setup_bash
    fi
    setup_config
    setup_git
fi
