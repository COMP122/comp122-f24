#  Programming Workflow Cheatsheet

## To Start an Assignment:
  ```bash
  open {web-url}
  # get the {git-url}
  cd ~/classes/comp122/deliverables
  git clone {git-url}
  cd ~/classes/comp122/deliverables/{assignment}
  ```

   You can now work, in turn, each of the tasks:  java, java_tac, and mips.
   The following three subsections, outlines the commands you need to execute

### To Start the {task} Task

  ```bash
  git branch {task}
  git branch --set-upstream-to=origin {task}
  touch {task}/{file}
  git add {task}/{file}
  git commit -m '{creating file}' 
  git push origin {task}
  ```

### Incrementally Work on the {task} Task

  ```bash
  git switch {task}
  for(( ; ; )) ; do 
    subl .
    make test_{task}
    git commit -m '{insert message}' -a
    if [[ done or need a drink ]] ; then
       break;
    fi
  done
  git pull origin {task} ; git push origin {task}
  make validate_{task}
  ```

### To Finish the {task} Task

  ```bash
  git switch main
  git merge {task}
  git tag {task}_submitted
  git pull ; git push
  git push origin {task}_submitted
  make confirm_{task}
  ```

## To Finish the assignment

  ```bash
  git switch main
  make confirm
  ```

## To Reset and to Republish a Tag

  * To reset your tag:
     ```bash
     git tag --delete {task}_submitted       # to delete the tag
     git tag {task}_submitted                # to set the tag at the current commit, i.e., HEAD
     # git tag {task}_submitted {commit}     # to set the tag at a specific commit 
     ```
  * To republish the Tag
    ```bash
    git push origin :{task}_submitted        # to unpublish the tag
    git push origin {task}_submitted         # to publish the tag
    ```


## To Obtain your Grade Report

  After the Professor announces, via slack, that grades are available.
  ```bash
  git pull
  cat grade.report
  ```


#  [Git Command List Cheatsheet](git_cheatsheet.md)

