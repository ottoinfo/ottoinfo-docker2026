### [⬅ Back](../README.md)

# LOCAL Setup

> "I just want to get things running!"

**Hopefully you read the README.md, but oh well. Let go!!!**

### Warning

You will need to _QUIT_ your terminal program during the setup process. So if you have something your working on please make sure this won't cause you problems.

### Checklist

What we NEED to do:
- [] Setup Project
- [] Upgrade bash via Terminal
- [] Quit Terminal; Open Terminal; Check bash version

### Setup Project

> You should have the flexibility to arrange the folders however you want, but it would be a good idea that we all have the same folder structure. This ensures that the commands you copy and paste will work. This is the folder structure currently. Feel Free to suggest changes and as a team we can decide.

**Prefer using `$HOME` over `~`. So make sure you have this as a ENV in your terminal.

- Check $HOME env
```
# Paste and Run in Terminal
echo $HOME
```

- Create Project Folder
```
# Paste and Run in Terminal
mkdir $HOME/Sites/do2026
cd $HOME/Sites/do2026
```

- Clone the REPO where you are finding this README
```
# Paste and Run in Terminal
git clone REPO
```

### Upgrade bash

> Mac's come with a older version of bash ( V3.2 from 2015 ). You need to run this script in a Terminal. Please close all Terminal windows after update.

- Open a Terminal ( Ex: Terminal, iTerm, Ghossty, etc... )
```code
# Paste and Run in Terminal
./scripts/setup.sh
```

What should happen:
- [] download brew
- [] upgrade bash

**Please kill/restart your Terminal program. Bash will not be updated in existing windows**

- Did it work? Did it update bash?
```code
# Paste and Run in Terminal
bash --version
```

_Old Version_ - `GNU bash, version 3.2.57(1)-release (arm64-apple-darwin24)
Copyright (C) 2007 Free Software Foundation, Inc.`

_New Version_ - `GNU bash, version 5.3.3(1)-release (aarch64-apple-darwin24.4.0)
Copyright (C) 2025 Free Software Foundation, Inc.`

> You should see a version for bash of 5+, something like the New Version above


### Brew Update/Upgrade

**Optional:** I did not want to add `brew update && brew upgrade` into our setup scripts. Developers should have the option to decide if they want to update/upgrade.

Brew will sometimes have notes for adding code to files or you need to run a script.

We do have a script ( `scripts/brewCheck.sh` ), if we ever want to add into the flow, but Developers should choose.

```code
# Paste and Run in Terminal
brew update && brew upgrade

// You can also check your system is working correctly
brew doctor
```

### Run setup

> We Will have a script that should install everything for you, but lets keep track if something goes wrong. Where did it go wrong? Please report issues.

**NOTE:** You should be prompted on each step, we will check if things exist else we will prompt the developer to install/setup certain apps/features. Somethings are optional so please read the Terminal messages.

```code
# Paste and Run in Terminal
cd $HOME/Sites/do2026
./scripts/setup.sh
```

What should happen:
- [] download brew
- [] upgrade bash ( if you did not )
- [] brew install --cask orbstack
- []


### Different Scripts

Want to make a way to create scripts for different features or setups.

```code
# Paste and Run in Terminal
./scripts/choose.sh
```

This will prompt the user through options of scripts the user can run

scriptList=(setup newMachine brew githubTokens sslCerts hosts bashUpgrade )

| Option | Scripts |  Description |
| ----------- | ----------- | ----------- |
| 1 | setup.sh | Initial Setup: this will prompt you through scripts and get your local machine running |
| 2 | newMachine.sh | New Machine: this will prompt you with common applications you may want to use |
| 3 | brew.sh | Brew - Install cmd 'brew' also give an prompt to update & upgrade applications |
| 4 | githubTokens.sh | Github Tokens: this will do basic setup for your github account and create auth tokens |
| 5 | sslCerts.sh | SSL Certs: this will create SSL certs for the Traefik Proxy Service |
| 6 | hosts.sh | Hosts: this will add domain names of 'do2026' to your '/etc/hosts' file |
| 7 | bashUpgrade.sh | Bash Upgrade - Macs ship with bash V3.2 from 2007, lets get new features |
| 8 | Quit | -- |


### Adding New/Modifying Scripts

Some scripts will require other scripts to try and improve the process and also to add safe guards and chain scripts together. This will also allow to easily add _NEW_ scripts or features down the line.

**Keep Scripts Small | Only Minimal Requirements**

**Use the `builtin source` and NOT `source`; You will get errors**

- Example on `startup.sh`, we make sure dev has brew installed
```bash
builtin source "${currentScriptPath}/orbStack.sh"
# Inside of "orbstack.sh" file
##### Check Dev has `brew` setup
##### builtin source "${currentScriptPath}/brew.sh"
```
