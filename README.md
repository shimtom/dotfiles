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
* git
* zsh
  - prezto
  - original prompt theme
* zplug
* python3
  - pip3
* neovim
  - original setting
  - useful plugins
* brew: only mac os

## Manually set up
### Mac
1. set up homebrew
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

3. set up zsh

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

5. install python3
    ```bash
    brew install python3
    ```

6. install neovim
    ```bash
    brew install neovim
    ```

## TODO
* [ ] add how to manually install in ubuntu/debian
* [ ] add how to setup neovim dotfiles
* [ ] latex
* [ ] latexmk
