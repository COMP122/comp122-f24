# Git Command List Cheat-sheet


## Variable Definition

 | Variable Name | Description                                                    |
 |---------------|----------------------------------------------------------------|
 | {name}        | The name of the student                                        |
 | {account}     | The github account name for the student                        |
 | {email}       | The student's email address                                    |
 | {assignment}  | The name of the assignment                                     |
 | {git-url}     | A ssh-style URL of the form `git@github.com/COMP122/...`       |
 | {dir}         | A directory on the student's computer                          |
 | {file}        | A file on the student's computer                               |
 | {src}         | The name of the source file                                    |
 | {dst}         | The name of the destination file                               |
 | {tag}         | A friendly name associated with a commit                       |
 | {commit}      | A point in time of a repository                                |
 | {remote}      | The name of a remote repository, default is `origin`
 | HEAD          | The current point in time being viewed with the reposition     |


---
## General Shell Commands

 | Command            | Description                      |
 |--------------------|----------------------------------|
 | `open {file}`      | Launch appropriate application   |
 | `cp {src} {dst}`   | Makes {dst} a copy of {src}      |
 | `rm {file}`        | Removes {file}                   |
 | `cd {work-dir}`    | Changes the working directory    |
 | `make`             | Used to maintain software        |
 | `subl {file}`      | Edit {file} using Sublime        |
 | `git {sub} --help` | Obtain help on a git subcommand  |


## Remote Repository Related Commands

 | Command                     | Description                          |
 |-----------------------------|--------------------------------------|
 | `git clone {git-url}`       | Creates a living copy of remote repo |
 | `git pull`                  | Updates the local from the remote    |
 | `git push`                  | Updates the remote from the local    |
 | `git push --tags`           | Publish all tags                     |
 | `git push --force --tags`   | Republish all tags                   |

### Branch Related Commands

 | Command                                 | Description                          |
 |-----------------------------------------|--------------------------------------|
 | `git branch -c {branch}`                | Create a branch                      |
 | `git --set-upstream-to=origin {branch}` | Define where to publish the branch   |
 | `git switch {branch}`                   | Change to work on alternate branch   |
 | `git merge  {branch}`                   | Merge {branch} into current branch   |
 | `git pull {remote} {branch}`            | Update the branch from the remote    |
 | `git push {remote} {branch}`            | Publish the branch                   |


## Configuration Information

 | Command                                  | Description                        |
 |------------------------------------------|------------------------------------|
 | `git config --list`                      | List all configuration information |
 | `git config --list --global`             | List all global information        |
 | `git config --list --local`              | List all local information         |
 | `git config --global pull.rebase false ` | Set default merge method           |
 | `git config --global user.email {email}` | Sets the user's email              |
 | `git config --global user.name {name}`   | Sets the user's name               |

## Obtain Information

 | Command                     | Description                         |
 |-----------------------------|-------------------------------------|
 | `git status`                | List files with changes             |  
 | `git diff {filename}`       | See changes to filename             |
 | `git commit`                | Commit to pending changes           |
 | `git log`                   | See log entries of past changes     |


## Making Changes to Files

 | Command                     | Description                          |
 |-----------------------------|--------------------------------------|
 | `subl {file}`               | Edit the {file}                      |
 | `git add {file}`            | Stage file to be added               |
 | `git rm {file}`             | Stage file to be removed             |
 | `git commit -m '{message}'` | Commit to all staged activities      |


## Local Tag Management

 | Command                  | Description                  |
 |--------------------------|------------------------------|
 | `git tag`                | `git tag --list`             |
 | `git tag {tag}`          | Create a tag named at HEAD   |
 | `git tag {tag} {commit}` | Set a tag at {commit}        |
 | `git tag --list`         | List all tags                |
 | `git tag --delete {tag}` | Delete a tag                 |
 | `git show {tag}`         | View the tag's commit        |


## Publishing Tags

 | Command                             | Description           |
 |-------------------------------------|-----------------------|
 | `git push origin {tag}`             | Publish a tag         |
 | `git ls-remote --tags origin {tag}` | List published tags   |
 | `git push --delete origin {tag}`    | Unpublish a tag       |

## Oops I made a mistake!

 | Command                       | Description                       |
 |-------------------------------|-----------------------------------|
 | `git restore -- {filename}`   | Undo the edits you made on a file |
 | `git log --oneline`           | Review past commits               |
 | `git reset {commit}`          | Removes commits after {commit}    |
 | `git reset --hard {commit}`   | And restores working files        |

