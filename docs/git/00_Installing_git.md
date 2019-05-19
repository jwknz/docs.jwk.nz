# Installing git

Git be installed in several ways and it depends on your operating system and other tooling you have installed.

## Git Bash

The simplest way would probably be to download the executable from:
[https://git-scm.com/download](https://git-scm.com/download) and choose your operating system

## GitHub App

GitHub provides an extensive crossplatform app that installs git on the command line.

You can get the app from: [https://desktop.github.com](https://desktop.github.com)

For Windows 10 Home edition and older versions of windows, those are pretty much your only options.

For Windows 10 Pro and higher, you can also install WSL (Windows Subsystem for Linux) and then you can install git using a Linux Package Manager.

## Chocolatey (for Windows)

Chocolatey is a cli tool for windows that can be used to install applications, instead of using GUI setups.

You can find git on there by click [here](https://chocolatey.org/search?q=git)

You will need to install Chocolatey first, and those instructions are [here](https://chocolatey.org/install)

## Xcode CLI Tools (for Mac)

On a mac, you can install xcode command line tools, which installs git, by typing the following into the terminal:

```
xcode-select --install
```

## Brew (for Mac)

Brew is a cli tool for macOS that can be used to install applications, instead of using GUI setups.

You can install Brew using:

```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

Brew installs the xcode cli tool, which also installs git.

However if you want to update or explicitly install Git, then run:

```
brew install git
```

## Linux (Debian based)

Use the following command from the terminal:

```
sudo apt-get update && sudo apt-get install -y git
```