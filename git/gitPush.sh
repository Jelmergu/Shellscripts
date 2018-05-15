#!/bin/bash

# Alias for git push which uses origin and current branch as default remote and branch
# 
# Made by: Jelmer Wijnja
# Made for: Personal use

function gitPush {
# offlimit options: -v,--verbose, -q, --quiet, --repo, --all, --mirror, -d, --delete, --tags, --n, -n, --dry-run, --porcelain, -f, --force, --force-with-lease,
#   --recurse-submodules, --thin, --receive-pack, --exec, -u, --set-upstream, --progress, --prune, --no-verify, --follow-tags, --signed, --atomic, -o, --push-option,
#   -4, --ipv4, -6, --ipv6
# Already used by git push
    branch=""
    remote=""

    upstream=$(git for-each-ref --format='%(upstream:short)' $(git symbolic-ref -q HEAD))
    IFS='/' read -ra ADDR <<< "$upstream"
    for i in "${ADDR[@]}"; do
        if [ -n ${remote} ]
        then
            remote="${i}"
        elif [ -n ${branch} ]
        then
            branch="${i}"
        else
            branch="${branch}/${i}"
        fi
    done

    if [ -n "${branch}" ]
    then
        branch=$(git rev-parse --abbrev-ref HEAD)
    fi

    if [ -n "${remote}" ]
    then
        remote="origin"
    fi

    next=""
    for var in $@
    do
        if [[ ${var} = "-ct" ]]
            then
            echo "On branch ${branch}"
            git status -s
            read -p "Continue: " choice
            if [[ ${choice} != "n" && ${choice} != "no" && ${choice} != "No" && ${choice} != "N" ]]
                then
                git add .
                git commit -F  $(git rev-parse --git-dir)/../gitCommit.txt
            else
                return 0
            fi
        
        elif [[ ${next} = "-b" ]]
            then
            branch=${var}
            next=""
        
        elif [[ ${next} = "-r" ]]
            then
            remote=${var}
            next=""
        
        else
            next=${var}
        fi
        
    done
    option="${option}${next}"
    if [[ ${option} == " " ]]
        then
        option=""
    fi

    if [ -n "${branch}" ]
    then
        remote="origin"
    fi
    git push "${option}""${remote}" "${branch}"
}