# ~/.config/fish/config.fish

switch $TERM
    case linux
        set -x LANG C
    case '*'
        set -x LANG ja_JP.UTF-8
end

## peco
function fish_user_key_bindings
  bind \cr 'peco_select_history (commandline -b)'
end

## go
set -x GOPATH $HOME/go
set -x PATH $PATH $GOPATH/bin

## neovim
if type "nvim" > /dev/null 2>&1
    set -x XDG_CONFIG_HOME $HOME/.config
end

## anyenv
if type "anyenv" > /dev/null 2>&1
    set -x PATH $HOME/.anyenv/bin $PATH
    eval (anyenv init - | source)
end

## openframeworks
set -x OF_ROOT /usr/local/lib/openframeworks/0.10.1

## python
alias pip-upgrade-all 'pip freeze --local | grep -v "^\-e" | cut -d = -f 1 | xargs pip install -U'

## ~/.local/bin
set -x PATH $HOME/.local/bin $PATH
set -g fish_user_paths "/usr/local/sbin" $fish_user_paths
set -g fish_user_paths "/usr/local/opt/texinfo/bin" $fish_user_paths

## oh-my-fish/theme-bobthefish
set -g theme_color_scheme dracula
