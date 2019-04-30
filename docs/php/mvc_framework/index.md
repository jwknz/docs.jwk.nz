# Basic MVC Framework 

This MVC framework is written in PHP and is based on an opensource framework by [Brad Traversy](http://traversymedia.com) 

## Quick use:

You can use this framework in 2 ways:

1. Full PHP MVC => Views are written in here and saved in the app/views folder.

2. Partial PHP MVC (Only Model and Controller) => The controller has api endpoints which output JSON data and the Views are written in another language. Could even be hosted in another container or server. This would purely serve as the backend.

!!! note "Requirements" tab="macoS"

    This setup uses php composer and that can be installed in the following way:

    ``` bash tab="macoS"
    # Install homebrew (https://brew.sh) (if you haven't already)
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

    # Install composer
    brew install composer
    ```

    ``` cmd tab="windows"
    # Install chocolatey (https://chocolatey.org) (if you haven't already)
    # Run this command in the CMD.exe (Command Prompt) with administrator priviledges

    @"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

    # OR

    # Run this command in Powershell with administrator priviledges

    Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

    # Install composer
    chocolatey install composer -y
    ```

    ``` bash tab="linux (using apt-get)"
    # linux already comes with a package manager (apt-get), so just type in the following

    sudo apt update
    sudo apt install curl php-cli php-mbstring git unzip
    cd ~ && curl -sS https://getcomposer.org/installer -o composer-setup.php
    sudo php composer-setup.php --install-dir=/usr/local/bin --filename=composer
    ```

    ``` bash tab="linux (using homebrew)"
    # install homebrew in your homedirectory

    sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"

    test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
    test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
    test -r ~/.bash_profile && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.bash_profile
    echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.profile

    # Install composer
    brew install composer
    ```

!!! tip
    After you install 1 or more programs in the command line, it always pays to restart your terminal to refresh all the PATH variables

## Docker containers

This repository **does not** include the docker-compose file to setup a LAMP stack. [You can find those instructions here](/php/container_setup/install/) 

Note that the credentials that are stored in this repository for the LAMP stack refer to the docker setup in that link. However you are free to change those to what you require.