# Dotfiles
Install my dotfiles and dependencies.

## Usage
```bash
$ ./install.sh
```

## Supported OS
* Mac
* Ubuntu/Debian

## Feature
* automatically install dependencies
* bash dotfiles
* zsh dotfiles
  - zplug
  - prezto
  - original prompt theme
* neovim dotfiles
  - python3
  - original setting
  - useful plugins
* latexmk dotfiles
  - texlive
* git dotfiles

## Manually set up
### Ubuntu
1. set up apt
    ```bash
    sudo apt update
    sudo apt upgrade
    sudo apt full-upgrade
    sudo apt autoremove
    sudo apt clean
    ```

2. set up bash dotfiles
    ```bash
    # ${DOTDIR}: dotfiles absolute path.
    ln -s -f ${DOTDIR}/bash/bashrc ~/.bashrc
    ln -s -f ${DOTDIR}/bash/bash_profile ~/.bash_profile
    ln -s -f ${DOTDIR}/bash/bash_logout ~/.bash_logout
    ```

3. set up zsh dotfiles
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

        3. link original zprezto prompt theme
            ```bash
            ln -s -f ~/.zplug/repos/sorin-ionescu/prezto ~/.zprezto
            ln -s -f ${DOTDIR}/zsh/prezto/modules/prompt/functions/prompt_paradigm_setup ~/.zprezto/modules/prompt/functions/prompt_paradigm_setup
            ```

4. set up neovim dotfiles
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

5. set up latex dotfiles
    1. install latex
        ```bash
        apt install -y texlive-full
        ```
    2. link latexmkrc
        ```bash
        # ${DOTDIR}: dotfiles absolute path.
        ln -s -f ${DOTDIR}/latexmkrc ~/.latexmkrc
        ```


### Mac
1. set up homebrew for
    ```bash
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew tap caskroom/cask
    brew update && brew upgrade
    ```

2. set up bash dotfiles
    ```bash
    # ${DOTDIR}: dotfiles absolute path.
    ln -s -f ${DOTDIR}/bash/bashrc ~/.bashrc
    ln -s -f ${DOTDIR}/bash/bash_profile ~/.bash_profile
    ln -s -f ${DOTDIR}/bash/bash_logout ~/.bash_logout
    ```

3. set up zsh dotfiles
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

        3. link original zprezto prompt theme
            ```bash
            ln -s -f ~/.zplug/repos/sorin-ionescu/prezto ~/.zprezto
            ln -s -f ${DOTDIR}/zsh/prezto/modules/prompt/functions/prompt_paradigm_setup ~/.zprezto/modules/prompt/functions/prompt_paradigm_setup
            ```

4. setup neovim
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

5. set up latex
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
* [ ] add how to manually install in ubuntu/debian
* [ ] add how to setup neovim dotfiles
* [ ] latex
* [ ] latexmk
