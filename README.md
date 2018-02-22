# Dotfiles
Install my dotfiles and dependencies.

## Usage
```bash
$ sudo sh -c "./install.sh"
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
    - pip3
  - original setting
  - useful plugins
* latex dotfiles

## Manually set up
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
* [ ] add how to manually install in ubuntu/debian
* [ ] add how to setup neovim dotfiles
* [ ] latex
* [ ] latexmk
