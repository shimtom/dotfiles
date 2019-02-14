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
set -x XDG_CONFIG_HOME $HOME/.config

## anyenv
set -x PATH $HOME/.anyenv/bin $PATH
eval (anyenv init - | source)

## python
alias pip-upgrade-all 'pip freeze --local | grep -v "^\-e" | cut -d = -f 1 | xargs pip install -U'
