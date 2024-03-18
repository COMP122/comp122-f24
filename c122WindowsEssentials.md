# Comp122 Windows Setup Guide

Since this class is geared towards MacOS/Linux machines, you need to do some extra work to bring Windows Machines up to spec. Not everything is covered in the setup.md file so here are all the commands that aren't shown. 

**This document is meant to be read alongside setup.md. This is not a replacement for setup.md**

## Installing WSL (line 17 on setup.md)

1. Open Powershell (x86) as an administrator
2. Run the following commands:
	```
	wsl --install -d ubuntu
	wsl --user root --exec sudo apt update
	wsl --user root --exec sudo apt upgrade -y
	``` 

## Installing required software (lines 27-35, 50, 54, 61 on setup.md)

**Note:** Some of these commands are duplicates of commands shown in setup.md. 

First you want to make sure your distro is up to date (it's a good habit to make sure your distro is up to date anytime you install software). Run the following commands in your terminal:

```bash
sudo apt-get update -y
sudo apt-get upgrade -y
```

Now that it's up to date, run the following commands to install all the needed software:

**Note:** The first block of commands is a duplicate from setup.md. If you already ran the commands there, you can skip them here.

```bash
sudo apt-get install build-essential    # provides essential tools for devs
sudo apt install retext -y              # markdown viewer, allows you to use the "open" command
sudo apt-get install sublime-text		# installs sublime
sudo apt install openjdk-19-jdk         # provides the Java JDK
```

```bash
sudo apt install xdg-utils
sudo apt install desktop-file-utils		# these two commands are needed to run sublime
sudo apt-get -y install ispell			# installs a spellchecker
```

**Note:** If you have an error downloading Java JDK, run the following commands:

```bash
sudo hwclock --hctosys
sudo apt install default-jre
sudo apt install openjdk-19-jdk
```

## Optional Software

### Visual Studio Code

While it is recomended by the professor to use Sublime and MARS to code Java & Mips, another ~~superior~~ potential coding software is Visual Studio Code, which comes free courtesy of your student Microsoft Account. To install it, do the following steps:

**Note:** Since this isn't a software reccomended by the professor, any errors you have with this software you will need to solve yourself.

1. Download VS Code for Windows using the link [here](https://code.visualstudio.com)
2. Download the WSL extension [here](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-wsl).
3. Make sure VS Code is closed, then run the following commands in the WSL terminal
	- ```bash
		cd ~/classes/comp122/deliverables
		code .
		```
	- If VS Code opens, you are golden
4. Navigate to the extensions menu (Ctrl + Shift + X) within VS Code, and download the following extensions
	- Better MIPS Support
	- Extension Pack for Java

## Related documentation:

- [ispell documentation](https://opensource.com/article/19/5/spelling-command-line-ispell)
- [VS Code documentation for WSL](https://code.visualstudio.com/docs/remote/wsl)
- [General documentation for VS Code](https://code.visualstudio.com/docs) 