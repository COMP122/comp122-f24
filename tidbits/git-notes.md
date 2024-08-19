# Notes for using GIT

## Development Process

   * `open <URL>`:  accept an assignment via an invitation URL
   * `git clone <URL>`:  create a local development environment for a remote repository
   * `git add/rm/mv <filename>`: declare changes to be made to your local repository
   * `git commit`: carry out all the declared changes to your local repository
   * `git fetch`: obtain a copy of your remote repository
   * `git merge origin/main`: incorporate origin/main branch into the current branch of the local repository
   * `git pull`: obtain a copy of your remote repository and merge it with your local repository
   * `git push`: update the remote repository to be in sync with your local repository
   * `git pull-request`: generate a file that enumerates all changes to the repository from a given commit

---
## Inquiry
   * `git <command> --help`: obtain more information about a git command
   * `git status`: Show the state of the working directory as compared to...
   * `git diff`: Enumerate the differences between the working directory and the local repository
   * `git log`: Enumerate all past commits
   * `git repo-state *`: Show differences between the local and remote repositories


---
## Oops, Undo
   * `git restore <filename>` : bring back a previous version of `<filename>`
   * `git reset --hard  <commit>` : undoes a set of commits in the local repository
   * `git revert <commit>` : perform a set of new commits that effectively removes changes since the noted `<commit>`


## Branches and Tags
---
   * `git checkout [tag | commit]`: to obtain a copy of the repository or a file at a given point in time.
   * `git branch`: list the known branches 
   * `git branch [-u origin] <branch>`: allow for branch track in the upstream/remote repository
   * `git branch -d <branch>`: delete a branch
   * `git switch <branch>`:  update your working directory to reflect the status of a branch
   * `git stash`: temporary save modified files in your working directory
   * `git tag`: list the known tags
   * `git tag <tag>`: associated a tag with the current commit 
   * `git tag -d <tag>`: delete a tag


## Terminology
---
   - branch: a set of commits that are an offset of the "main" line of code development
   - commit: either a hash or a tag that uniquely identifies a point in time
   - hash: a globally unique value associated with a commit
   - HEAD: the reference to the current version of the repository as it is reflected in the working directory
   - index: a list of pending changes that are to be made upon the next "commit"
   - tag: a human readable string used as an alias to a hash
   - working-directory: a directory in your file-system in which you developed your code
