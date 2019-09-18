# Dotfiles

Install my dotfiles and dependencies.

## Usage

```bash
$ ./install.sh
```

## Support OS

* [Ubuntu/Debian](#ubuntu)
* [Mac](#mac)

## Feature
* package manager
    - brew (mac only)
    - apt (ubuntu only)
* peco
* imagemagick
* ffmpeg
* bash
* zsh
    - zplug
* fish
    - fisher
* tmux
* git
* anyenv
* python
    - pyenv
    - packages
* vim
    - neovim
    - dein.vim
* latex
    - texlive
    - latexmk
    - packages

## Manually set up

### <a name="ubuntu">Ubuntu

1. set up apt

    ```bash
    sudo apt update
    sudo apt upgrade
    sudo apt full-upgrade
    sudo apt autoremove
    sudo apt clean
    ```

2. set up git dotfiles

    1. install git

        ```bash
        sudo apt install -y git
        ```

    2. link dotfiles

        ```bash
        # ${DOTDIR}: dotfiles absolute path.
        ln -s -f ${DOTDIR}/git/gitignore_global ~/.gitignore_global
        ln -s -f ${DOTDIR}/git/gitconfig ~/.gitconfig
        ```

3. set up bash dotfiles

    ```bash
    # ${DOTDIR}: dotfiles absolute path.
    ln -s -f ${DOTDIR}/bash/bashrc ~/.bashrc
    ln -s -f ${DOTDIR}/bash/bash_profile ~/.bash_profile
    ln -s -f ${DOTDIR}/bash/bash_logout ~/.bash_logout
    ```

4. set up zsh dotfiles

    1. install zsh

        ```bash
        sudo apt update
        sudo apt install -y zsh
        ```

    2. (option) set zsh default shell

        ```bash
        chsh -s /usr/local/zsh
        ```

    3. link zsh dotfiles

        ```bash
        # ${DOTDIR}: dotfiles absolute path.
        ln -s -f ${DOTDIR}/zsh/zlogin ~/.zlogin
        ln -s -f ${DOTDIR}/zsh/zlogout ~/.zlogout
        ln -s -f ${DOTDIR}/zsh/zpreztorc ~/.zpreztorc
        ln -s -f ${DOTDIR}/zsh/zprofile ~/.zprofile
        ln -s -f ${DOTDIR}/zsh/zshenv ~/.zshenv
        ln -s -f ${DOTDIR}/zsh/zshrc ~/.zshrc
        ```

    4. set up zplug

        1. install zplug

            ```bash
            sudo apt update
            sudo apt install -y curl
            curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
            ```

        2. install zplugins

            ```bash
            zsh -c "source ~/.zplug/init.zsh && zplug check"
            ```

5. set up neovim dotfiles

    1. install neovim

        ```bash
        sudo apt update
        sudo apt install -y software-properties-common
        sudo add-apt-repository ppa:neovim-ppa/stable
        sudo apt update
        sudo apt install -y neovim
        ```

    2. install plugins

        ```bash
        sudo apt install -y python-dev python-pip python3-dev python3-pip
        pip3 install --upgrade neovim
        curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > /tmp/installer.sh
        mkdir -p ~/.cache/dein
        sh /tmp/installer.sh ~/.cache/dein
        ```

    3. link dotfiles

        ```bash
        mkdir -p ~/.config/nvim/plugins
        ln -s -f ${DOTDIR}/nvim/init.vim ~/.config/nvim/init.vim
        ln -s -f ${DOTDIR}/nvim/editor.vim ~/.config/nvim/editor.vim
        ln -s -f ${DOTDIR}/nvim/core.vim ~/.config/nvim/core.vim
        ln -s -f ${DOTDIR}/nvim/appearance.vim ~/.config/nvim/appearance.vim
        ln -s -f ${DOTDIR}/nvim/plugins/dein.toml ~/.config/nvim/plugins/dein.toml
        ln -s -f ${DOTDIR}/nvim/plugins/dein_lazy.toml ~/.config/nvim/plugins/dein_lazy.toml
        ln -s -f ${DOTDIR}/nvim/plugins/dein_theme.toml ~/.config/nvim/plugins/dein_theme.toml
        ln -s -f ${DOTDIR}/nvim/plugins/dein_python.toml ~/.config/nvim/plugins/dein_python.toml
        ```

6. set up powerline dotfiles
    1. install powerline

        ```bash
        sudo apt install -y python-dev python-pip
        pip install --upgrade neovim
        pip install powerline-status
        pip install powerline-gitstatus
        pip install powerline-exitstatus
        ```

    2. powerline font

        ```bash
        git clone https://github.com/powerline/fonts.git --depth=1 /tmp
        /tmp/fonts/install.sh "Source Code Pro"
        rm -rf /tmp/fonts
        ```

    3. link powerline config

        ```bash
        mkdir -p ~/.config/powerline
        mkdir -p ~/.config/powerline/themes/shell
        mkdir -p ~/.config/powerline/themes/tmux
        mkdir -p ~/.config/powerline/colorscheme
        # ${DOTDIR}: dotfiles absolute path.
        ln -s -f ${DOTDIR}/powerline/config.json ~/.config/powerline/config.json
        ln -s -f ${DOTDIR}/powerline/themes/shell/original.json ~/.config/powerline/themes/shell/original.json
        ln -s -f ${DOTDIR}/powerline/themes/tmux/original.json ~/.config/powerline/themes/tmux/original.json
        ln -s -f ${DOTDIR}/powerline/colorschemes/default.json ~/.config/powerline/colorschemes/default.json
        ```

7. set up tmux dotfile
    1. install tmux

        ```bash
        apt update && apt install -y tmux
        ```
    2. link tmux dotfile

        ```bash
        # ${DOTDIR}: dotfiles absolute path.
        ln -s -f ${DOTDIR}/tmux/tmux.conf ~/.tmux.conf
        ```

8. set up latex dotfiles

    1. install latex

        ```bash
        apt install -y texlive-full
        ```

    2. link latexmkrc

        ```bash
        # ${DOTDIR}: dotfiles absolute path.
        ln -s -f ${DOTDIR}/latexmkrc ~/.latexmkrc
        ```

### <a name="mac">Mac

1. set up homebrew for

    ```bash
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew tap caskroom/cask
    brew update && brew upgrade
    ```

2. set up git dotfiles

    1. install git

        ```bash
        brew install git
        ```

    2. link dotfiles

        ```bash
        # ${DOTDIR}: dotfiles absolute path.
        ln -s -f ${DOTDIR}/git/gitignore_global ~/.gitignore_global
        ln -s -f ${DOTDIR}/git/gitconfig ~/.gitconfig
        ```
3. set up fish

    1. install fish

        ```bash
        brew install fish
        ```

    2. install fisher

        ```bash
        curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish
        ```

    3. install plugins

        ```
        fisher add jethrokuan/z
        fisher add oh-my-fish/plugin-peco
        fisher add oh-my-fish/theme-bobthefish
        ```

    4. link dotfile

        ```bash
        ln -s -f ${DOTDIR}/fish/config.fish ~/.config/fish/config.fish
        ```

3. set up bash dotfiles

    ```bash
    # ${DOTDIR}: dotfiles absolute path.
    ln -s -f ${DOTDIR}/bash/bashrc ~/.bashrc
    ln -s -f ${DOTDIR}/bash/bash_profile ~/.bash_profile
    ln -s -f ${DOTDIR}/bash/bash_logout ~/.bash_logout
    ```

4. set up zsh dotfiles

    1. install zsh

        ```bash
        brew install zsh
        ```

    2. (option) set zsh default shell

        ```bash
        chsh -s /usr/local/bin/zsh
        ```

    3. link zsh dotfiles

        ```bash
        # ${DOTDIR}: dotfiles absolute path.
        ln -s -f ${DOTDIR}/zsh/zlogin ~/.zlogin
        ln -s -f ${DOTDIR}/zsh/zlogout ~/.zlogout
        ln -s -f ${DOTDIR}/zsh/zpreztorc ~/.zpreztorc
        ln -s -f ${DOTDIR}/zsh/zprofile ~/.zprofile
        ln -s -f ${DOTDIR}/zsh/zshenv ~/.zshenv
        ln -s -f ${DOTDIR}/zsh/zshrc ~/.zshrc
        ```

    4. set up zplug

        1. install zplug

            ```bash
            curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
            ```

        2. install zplugins

            ```bash
            zplug install
            ```

5. setup neovim

    1. install neovim

        ```bash
        brew install neovim
        ```

    2. install plugins

        ```bash
        brew install python3
        pip3 install --upgrade neovim
        mkdir -p ~/.config
        curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > /tmp/installer.sh
        sh /tmp/installer.sh ~/.cache/dein
        ```

    3. link dotfiles

        ```bash
        ln -s -f ${DOTDIR}/nvim/ ~/.config/nvim
        ```

6. set up powerline dotfiles
    1. install powerline

        ```bash
        brew install python
        pip install --upgrade neovim
        pip install powerline-status
        pip install powerline-gitstatus
        pip install powerline-exitstatus
        ```

    2. powerline font

        ```bash
        git clone https://github.com/powerline/fonts.git --depth=1 /tmp
        /tmp/fonts/install.sh "Source Code Pro"
        rm -rf /tmp/fonts
        ```

    3. link powerline config

        ```bash
        mkdir -p ~/.config/powerline
        mkdir -p ~/.config/powerline/themes/shell
        mkdir -p ~/.config/powerline/themes/tmux
        mkdir -p ~/.config/powerline/colorscheme
        # ${DOTDIR}: dotfiles absolute path.
        ln -s -f ${DOTDIR}/powerline/config.json ~/.config/powerline/config.json
        ln -s -f ${DOTDIR}/powerline/themes/shell/original.json ~/.config/powerline/themes/shell/original.json
        ln -s -f ${DOTDIR}/powerline/themes/tmux/original.json ~/.config/powerline/themes/tmux/original.json
        ln -s -f ${DOTDIR}/powerline/colorschemes/default.json ~/.config/powerline/colorschemes/default.json
        ```

7. set up tmux dotfile
    1. install tmux

        ```bash
        brew install reattach-to-user-namespace
        brew install tmux ;;
        ```

    2. link tmux dotfile

        ```bash
        # ${DOTDIR}: dotfiles absolute path.
        ln -s -f ${DOTDIR}/tmux/tmux.conf ~/.tmux.conf
        ```

7. set up latex

    1. install latex

        ```bash
        brew install ghostscript
        brew cask install basictex
        ```

    2. set paper size

        ```bash
        sudo tlmgr paper a4
        ```

    3. install packages

        ```bash
        sudo tlmgr update --self --all
        sudo tlmgr install collection-langjapanese latexmk
        ```

    4. link latexmkrc

        ```bash
        # ${DOTDIR}: dotfiles absolute path.
        ln -s -f ${DOTDIR}/latexmkrc ~/.latexmkrc
        ```

## TODO

* [ ] consider BSD or GNU
* [ ] add how to update
