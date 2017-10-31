# Dotfiles

## requirements
* zsh: version 4.3.9 or higher
* git: version 1.7 or higher
* awk: An AWK variant that's not mawk
* zplug
* nvim
* python3

## install
1. install zsh
    ```bash
    brew install zsh
    ```

2. set zsh default shell
    ```bash
    chsh -s /usr/local/bin/zsh
    ```

3. link zfiles
    ```bash
    ln -s /path/to/dotfiles/zsh/zlogin ~/.zlogin
    ln -s /path/to/dotfiles/zsh/zlogout ~/.zlogout
    ln -s /path/to/dotfiles/zsh/zpreztorc ~/.zpreztorc
    ln -s /path/to/dotfiles/zsh/zprofile ~/.zprofile
    ln -s /path/to/dotfiles/zsh/zshenv ~/.zshenv
    ln -s /path/to/dotfiles/zsh/zshrc ~/.zshrc
    ```

4. install zplug
```
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh| zsh
```

5. install zplugins
```
zplug install
```

6. link
    ```bash
    ln -s /path/to/dotfiles/zsh/prezto/module/prompt/functions/prompt_paradigm_setup ~/.zprezto/module/prompt/functions/prompt_paradigm_setup
    ```

7. install python3
```
brew install python3
```
8. install nvim
```
brew install neovim
```
```
sudo apt-get install neovim
sudo apt-get install python3-neovim
```
9.
