# gHGit-tools

A couple of tools to integrate on any project's workflow, inspired by Erik Dubois, hope you live forever. With a couple of minor changes and additions to each script, to properly integrate this scripts and benefit from them the requirements are:

- git
- gh-cli
- core-utils
- Github account
- Editor of your choice
- A very little knowledge is the shell, linux and markdown

## Prerequisites

gh-cli/github-cli expects the user to already have a pre generated acces token from his/her account, there are 3 common used ways to pass the token to the gh-cli helper:

1. Copy paste the token in the interactive method from gh-cli
2. Start the authentication from scratch choose "HTTPS" which will give you
   a provisional 6 alpha numeric code from the browser, get into your account
   account settings, generate the token from there and copy paste into terminal
3. Declare the environment variable `GH_TOKEN` or `GITHUB_TOKEN` inside your bashrc,
   zshrc, zshenv, profile or whatever config file you may use to declare your variables/aliases/path's

# Creating your github repository approach 1

## `setup-repoOnGit.sh`

This script will ask you for 2 parameters, the name you want to give to your project and a brief description for the README.md file

# Creating your github repository approach 2

## repoFrom-local.sh

Approach 1 creates the repository from 0, that means you don't have a README.md, initialize a local direcotry as your git project with `git init` and or 0 commits have been made, approach 2 will create a repository taking into account the name of the directory you are in that moment and directory contains all your project files and you are all set to commit and push for the first time.

#### TAKE INTO ACCOUNT THAT COMMITING SEVERAL TIMES WITHOUT PUSHING WILL EFF THE EFF-OUT OF YOUR PROJECT AND WILL HAVE A VERY BAD TIME STASHING, REBASING, MERGING AND HOOPE GOD WILL BE ON YOUR SIDE ON THAT DAY.

# `setup-ssh.sh`

This script will create an ed25519 ssh key with a custom identifier/name and will store the key pair under your `$HOME/.ssh` directory

# `git-setup.sh`

This script will configure the most essential parameters to quickly clone your project on any machine and start adding/commenting/committing/pushing

# `up.sh`

This script will be the only one that is gonna be reused every time you push any new line of code or changes within your project
