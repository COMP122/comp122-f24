# The Setup Process
---
## Tasks: To be completed ASAP
  First, take steps to upgrade your computer to the latest version of your OS (operating system).  Without a current version, you may run into a number of compatibility issues, which can lead to you not being successful in completing the following tasks. 


### Computer and Account Setup  
  1. Update your OS (operating system) to be the most current version, you may run into a number of compatibility issues, which can lead to you not being successful in this class.
     - The list of suggested OS versions are as follows:
       ```
       MacOS: Venture 13.3 or newer
       Windows: Windows 11 or newer
       Linux: Ubuntu 20.04.6 LTS
       ```

  1. For Windows Users:
     - Install the Windows Subsystem (WSL) for Linux: https://learn.microsoft.com/en-us/windows/wsl/about <br>
        - Use the default OS, which is Ubuntu


     Note that this is the first semester in which I have required students to use WSL.  Hence, be on the lookout for issues that might arise due to the particular setup of your computer.

     - Ensure you set things up to allow for gui-apps
       - https://learn.microsoft.com/en-us/windows/wsl/tutorials/gui-apps
      

     - After you have Ubuntu working, perform the install:
       1. launch an terminal via ubuntu
       1. update your Ubuntu environonment by running the following commands
          ```
          sudo apt-get update
          sudo apt-get upgrade
          sudo apt-get install build-essential    # provides essential tools for devs
          sudo apt install retext -y              # provides the "open" command
          sudo apt install openjdk-19-jdk         # provides the Java JDk
          ```


  1. Establish Accounts:
     - https://slack.com: 
       - Your account needs to be associated with your @my.csun.edu address.
       - All off-line class discussions are conducted via Slack

     - https://github.com: 
       - Your account name should be clearly identify yourself in a professional manner.
       - Your account needs to be associated with your @my.csun.edu address.
       - All deliverables are submitted via GitHub Classrooms.

  1. Install Software on your personal computer environment:
     - Sublime Text Editor: https://www.sublimetext.com
       - MacOS User: Move the `Sublime Text` application from the Downloads folder to the Applications folder.
       - Windows Users: You can install this software on your Windows side.  Via the instructions above it has already been installed on you Ubuntu side

     - A Markdown View: (for example)
       - https://apps.microsoft.com/store/detail/markdown-view/9PJ021LR0M3G
       - https://apps.apple.com/us/app/one-markdown/id1507139439

     - Slack: https://slack.com  <br />   
       * Consider installing the mobile application as well

     - Java JDK: https://www.oracle.com/java/technologies/downloads/



  1. Join the Slack COMP122 work space:
     - Accept the invitation <br/> via https://join.slack.com/t/comp122-csun/signup using your @my.csun.edu address.
     - Add the '#fitzgerald-f23' channel, this is where all class discussions are held.
     - Respond to the 'Hello Class!' post via the 'reply to thread' option 
       - do NOT "Also send to #fitzgerald-f23"


### Your Local Comp122 environment
  1. Launch a terminal, and then execute the following commands.
     - MacOS: the "terminal" app is located in Applications/Utilities
     - WinOS: the terminal you open must be associated with WSL
       * That is to say, don't use PowerShell nor the cmd shell.

  1. Note on using a CLI (Command Line Interface)
     - Take extra care to type in the commands correctly.  
     - Read the error messages carefully to determine what you did wrong
     - Presume that you made a typo -- 
       - punctuation, capitalization, spaces, and other linguistic elements all important


  1. Validate that you are using the bash shell

     1. Execute the following command:
        ```
        echo $SHELL
        ```
     1. If the output is not `/bin/bash`, then change your shell to bash, via the following command
        ```
        chsh -s /bin/bash
        ```
        - close the current terminal window
        - launch a new terminal window

     1. Create the canonical folder for the class: \~/classes/comp122 
        ```
         cd
         mkdir -p classes/comp122
         ```
     1. Setup your git global configuration: <br />
        (update the following command to reflect your name and email address)
        ```
        git config --global user.name "John Doe"
        git config --global user.email johndoe@my.csun.edu
        git config --global pull.rebase false 
        ```

     1. Clone a copy of this repository:
        ```
        cd classes
        git clone https://github.com/COMP122/comp122-f23.git comp122
        ```
     1. Update the appropriate startup file to source COMP122's `.profile.comp122.`   For example:
        ```
        cd
        touch .profile
        mv .profile .profile.orig
        echo 'source ~/classes/comp122/.profile.comp122'  >> .profile
        source .profile
        ```

  1. Quick Access Setup
     *  For Windows Users:
        1. Open File Explorer
        1. Navigate to the file:  `Linux/users/{username}/classes/`
        1. Pin the folder `comp122` to Quick Access
           - Right-click on the comp122 folder
           - Select `Pin to Quick access`
           - See: https://www.guidingtech.com/how-to-use-quick-access-in-windows-11/
        1. Reposition comp122 in the Quick Access folder to match your preference
      * For Mac Users:
        1. Open Finder
        1. Navigate to the file:  /{username}/classes/`
        1. Drag the comp122 folder to the Favorites part of the Finder menu

### Test Your Local Environment

   1. Validate Mars_4_5 is appropriately registered. For System Security reasons, you may need to register the MARS IDE with the Operating System.
      - Open up File Explorer (Windows) or Finder (Mac)
      - Navigate to the COMP122 bin directory: ~/classes/comp122/bin/
      - First double-click the Mars4_5.jar icon
      - If you receive the following message,
        ```
        "Mars4_5.jar” cannot be opened because it is from an unidentified developer.
        ```

        1. Control-click the Mars4_5.jar icon
        1. Choose Open from the shortcut menu
        1. Hereafter, you can Double-click the Mars4_5.jar icon to open the application.

  1. Create a short-cut on your Desktop for Comp122 for easy access
     - Open File Explorer or Finder
     - Navigate to `classess` folder
     - Copy the comp122 folder
     - Paste the path to the Desktop # to make a shortcut
       <!-- But sigh this does not work on Windows /WSL  -->

  1. Validate CLI tools for COMP122.<br/>  
     First open a new terminal and execute the following commands:
     ```
     cd $COMP122_HOME
     cd mips
     mars add4.s
     mips_subroutine add4 2 4 6 8
     ```
     
     Ensure your terminal has the following output:
     ```
     dwarf:~ steve$ cd $COMP122_HOME
     dwarf:comp122 steve$ cd mips
     dwarf:mips steve$ mars add4.s
     MARS 4.5  Copyright 2003-2014 Pete Sanderson and Kenneth Vollmar
     
     10
     dwarf:mips steve$ mips_subroutine add4 2 4 6 8
     #########################################
     # Above is the output from your program
     #########################################

     v0:         20; 0x00 00 00 14; 0b0000 0000 0000 0000 0000 0000 0001 0100;
     
     dwarf:mips steve$ 
     ```
     Note that the substring `dwarf: steve$ ` is my prompt. Your prompt will differ.

If you have any problems completing these tasks, post a message in the #fitzgerald-f23 channel.



