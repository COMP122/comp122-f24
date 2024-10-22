#! /bin/bash

# Additional functionality for git

alias git="my_git "
function my_git () {

    case "$1" in 
      clone)
        my_git_clone
        ;;

      safe-to-switch)
        git-safe-to-switch
        ;;

      pull-request)
          shift 
          git-pull-request "$@"
          ;;

      repo-state)
          shift
          git-repo-state "$@"
          ;;
      *)
        'git' "$@"
        ;;
    esac
}

function my_git_clone () {
  local _URL="$2"
  local _dir="$3"

  'git' 'clone' "$_URL" $_dir

  [[ -z "$_dir" ]] && _dir=$(basename -s .git $_URL)
  cd $_dir
  touch .accepted_assignment
  git add .accepted_assignment
  git commit -m "Assignment Accepted" 
  git push

}

function git-pull-request () {
   local base=
   local repo=$(git config --get remote.origin.url)
   local url
   local branch

   if [[ ${1:0:1} == "-" ]] ; then


     echo "Usage: $0 [ first-commit repo-url ] [ branch ]"
     echo "   defaults:  "
     echo "     first-commit: $base "
     echo "     repo-url: ${repo}"
     echo "     branch: main"
     return
   fi

   case $# in 
      0)   ;;
      1)   branch="$1" ;;
      2|3) 
           base="$1"
           repo="$2"
           branch="$3"
           ;;
      *)   echo "Error in usage."
           return 1
   esac

   [[ -z "$branch" ]] && branch="main"
   
   local exists="$(git branch --list ${branch})"   ## -av to list local and remote
   if [[ -z "$exists" ]] ; then
      echo "Error branch, \"${branch}\", does not exist"
      return 1
   fi

   [[ -z "$base" ]] && base=$(git rev-list ${branch} 2>&1 | tail -1)
   [[ -z "$repo" ]] && repo=$(git config --get remote.origin.url)


   git-repo-state "$branch"
   'git' request-pull $base $repo $branch | tee pull-request.$(date +%b%d:%H:%M)
}

function git-safe-to-switch () {
  local _output=$(git status --untracked-files=no -s)
  if [[ -z $_output ]] ; then
    return 0
   else
     return 1
  fi
}

function git-repo-state () {
    local branch="$1"
    [[ -z "$branch" ]] && branch="main"

    git diff --exit-code HEAD  >/dev/null
    commit_diff="$?"
    if [[ ${commit_diff} != 0 ]] ; then
      echo "Warning: You have uncommitted files."
      echo "  (use \"git status\" for more information.)"
      echo
    fi
    git fetch
    git diff --exit-code ${branch} origin/${branch} >/dev/null
    remote_diff="$?"
    if [[ ${remote_diff} != 0 ]] ; then
      echo "Warning: Your local and remote repositories are NOT in sync."
      echo "  (use \"git pull\" to update your local repository.)"
      echo "  (use \"git push\" to update your remote repository.)"
      echo
    fi
    return_value=$(( commit_diff + remote_diff ))
    if [[ $return_value == 0 ]] ; then
       echo "Your local and remote repository share the same state for branch \"${branch}\""
    fi
    return ${return_value}
}

function git_commit_on_time () {
  date="$1"
  commit="$2"

  # Note that this requires the DATE to be in the format of: Nov 11 12:52
  due_date=$(date -j -f "%b %d %H:%M" "$date" +%s)

  # Note if the commit is empty, then it is equivalent to the last commit
  commit_date=$(git log "${commit}" -1 --date=unix --pretty=format:"%ad" 2>/dev/null)
  if [[ -z ${commit_date} ]] ; then
    # the ${commit} did not exist
    return 1
  fi

  if (( "${commit_date}" <= "${due_date}" )) ; then
    return 0    # on time 
  else
    return 1    # the commit did not occur before the due date
  fi
}
