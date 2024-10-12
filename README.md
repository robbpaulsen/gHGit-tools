# __gHGit-tools__

A couple of tools to integrate on any project's workflow, inspired by Erik Dubois, hope you live forever. With a couple of minor changes and additions to each script, to properly integrate this scripts and benefit from them the requirements are:

- git
- gh-cli
- core-utils
- Github account
- Editor of your choice
- A very little knowledge of the shell, linux and markdown

## Prerequisites

gh-cli/github-cli expects the user to already have a pre generated acces token from his/her account, there are 3 common used ways to pass the token to the gh-cli helper:

1. Copy paste the token in the interactive method from gh-cli
2. Start the authentication from scratch choose "HTTPS" which will give you
   a provisional 6 alpha numeric code from the browser, get into your account
   account settings, generate the token from there and copy paste into terminal
3. Declare the environment variable `GH_TOKEN` or `GITHUB_TOKEN` inside your bashrc,
   zshrc, zshenv, profile or whatever config file you may use to declare your variables/aliases/path's

## __Creating your github repository approach 1__

`setup-repoOnGit.sh`

This script will ask you for 2 parameters, the name you want to give to your project and a brief description for the README.md file. When giving the 
description the maximum character count that you can pass in the command line to the github api cannot exceed 240 ish for a description on github.

In conclusion script will name your project, create local project directory, creaste remote project on github with the same name, cd into
new projects root directory, create a README.md with a brief description, commit this README.md as the first one and push it to remote (GitHub.com) 

### Creating your github repository approach 2

`repoFrom-local.sh`

### Differences between `setup-repoOnGit.sh` and `repoFrom-local.sh`

* Approach 1 creates the repository from 0, this literally means you don't have a README.md, no directory containing project initialized with git and 0 commits have been made
* approach 2 will create a repository taking into account the name of the root directory you are currently at the moment and in this root directory reside all your project files
ready to commit and push for the first time.

###### _TAKE INTO ACCOUNT THAT COMMITING SEVERAL TIMES WITHOUT PUSHING WILL EFF THE EFF-OUT OF YOUR PROJECT AND WILL HAVE A VERY BAD TIME STASHING, REBASING, MERGING AND HOPE GOD WILL BE ON YOUR SIDE ON THAT DAY._

`setup-ssh.sh`

This script will create an ed25519 ssh key with a custom identifier/name and will store the key pair under your `${HOME}/.ssh` directory

`setup-ssh2.sh`

The same as 1, but mainly uses the simplified functions made in this project.

`git-setup.sh`

This script will configure the most essential parameters to quickly clone your project on any machine and start adding/commenting/committing/pushing

`up.sh`

This script will be the only one that is gonna be reused every time you push any new line of code or changes within your project.

`one-git`

___

# __Warning__

`one-git` combines all the simplified functions into an interactive menu to choose what the user wants to do.
Before execuritn arbitrary code/scripts on your machine please read the source code, maybe it will go and do
something you might not like. The other little detail is that english is not my native language
and most likely I name things that will not make sense to you, so again please read the source bash scripts.

___

`one-git` is a terminal user interface, menu driven for all the simplified functions, and other functions that
are the sub product of breaking down certain parts of the scripts. This script contains a lot of lines in bash
and bash is certainly not perfect.

## "So have I tested all this bash bloat ??"

Yes, since the first commit I made to this project I've tested and used my scripts. And all the undesired
behavior, issues and depression from accidentally blowing something up has come from my lack of knowledge
in git, but the scripts work. I currently use this project for all my workflow and other projects.