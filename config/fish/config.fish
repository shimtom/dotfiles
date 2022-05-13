# ~/.config/fish/config.fish

# Inherite Environment Variables to keep path order
# c.f. https://github.com/fish-shell/fish-shell/issues/5456
if string length -q -- $INHERITED_PATH;
    set -x PATH $INHERITED_PATH
    set -e INHERITED_PATH
end

# User specific aliases and functions
## direnv
if type -q direnv
    eval (direnv hook fish)
end

## peco
if type -q peco; and not type -q fish_user_key_bindings
    function history_merge --on-event fish_preexec
        history --save
        history --merge
    end

    function peco_sync_select_history
        history_merge
        peco_select_history $argv
    end

    function fish_user_key_bindings
        bind \cr 'peco_sync_select_history (commandline -b)'
    end
end

## abbr
if type -q gls
    # ls
    alias ls='gls --color=auto --file-type --group-directories-first'
    alias exa='exa --group-directories-first'
end

## prompt theme: oh-my-fish/theme-bobthefish
set -g theme_color_scheme dracula
set -g theme_nerd_fonts yes

## terminal theme: dracula
set -g fish_color_normal normal
set -g fish_color_command green
set -g fish_color_quote yellow
set -g fish_color_redirection white
set -g fish_color_end white
set -g fish_color_error red
set -g fish_color_param normal
set -g fish_color_comment 6272a4
set -g fish_color_operator cyan
set -g fish_color_escape blue
set -g fish_color_autosuggestion brblack
set -g fish_color_cancel -r

set -g fish_pager_color_progress white --underline
set -g fish_pager_color_description yellow
