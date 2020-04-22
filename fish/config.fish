# ~/.config/fish/config.fish

# Change locale depending on environment
switch $TERM
    case linux
        set -x LANG C
    case '*'
        set -x LANG ja_JP.UTF-8
end


# Enable sbin
if test -d /usr/local/sbin; and not contains /usr/local/sbin $PATH
    set -x PATH /usr/local/sbin $PATH
end


# Enable local bin
if test -d $HOME/.local/bin; and not contains $HOME/.local/bin $PATH
    set -x PATH $HOME/.local/bin $PATH
end


# Set XDG_CONFIG_HOME
if set -q XDG_CONFIG_HOME ;and test -d $HOME/.config
    set -x XDG_CONFIG_HOME $HOME/.config
end


# User specific aliases and functions
## theme: oh-my-fish/theme-bobthefish
set -g theme_color_scheme dracula

## direnv
if type -q direnv
    eval (direnv hook fish)
end

## peco
if type -q peco; and not type -q fish_user_key_bindings
    function fish_user_key_bindings
        bind \cr 'peco_select_history (commandline -b)'
    end
end

## anyenv
if type -q anyenv ;and test -d $HOME/.anyenv
    if not contains $HOME/.anyenv/bin $PATH
        set -x PATH $HOME/.anyenv/bin $PATH
    end
    eval (anyenv init - | source)
end

## latex
if test -d /usr/local/opt/texinfo/bin
    set -x PATH /usr/local/opt/texinfo/bin $PATH
end

## go
if type -q go; and test -d $HOME/go
    set -x GOPATH $HOME/go
    set -x PATH $PATH $GOPATH/bin
end

## openframeworks
if test -d /usr/local/lib/openframeworks/0.10.1
    set -x OF_ROOT /usr/local/lib/openframeworks/0.10.1
end
