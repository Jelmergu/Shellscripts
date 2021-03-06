#!/bin/bash

# This function can clone a git repo to the specified destination. Unspecified destination will put the repo in current directory
# Also creates gitCommit and .gitignore file
# 
# Made by: Jelmer Wijnja
# Made for: Personal use

function gitClone {
    local destination=${2}
    local fullpath=""

    if [ -z "${1}" ]
    then
        if [ -z "${1}" ]
        then
            echo "No repository specified"
        fi

    else
        if [ -z "${2}" ]
        then
            destination="."
        fi

        git clone "${1}" ${destination}
        echo "" > ${destination}/gitCommit.txt

        if  [ -f ${destination}/.gitignore ]
        then
            echo "gitignore exists in repository"



        elif [[ -e ${destination}/.git/gitIgnoreTemplate.txt || $(contains "${option[@]}" "--no-gitignore") != "false" ]]
        then
            cat ${destination}/.git/gitIgnoreTemplate.txt > ${destination}/.gitignore

        fi

        if [ -e ${destination}/.git/gitIgnoreTemplate.txt ]
            then
                rm ${destination}/.git/gitIgnoreTemplate.txt
            fi

        if [ ${destination} == "." ]
        then
            fullPath=${PWD}
        else
            fullPath="${PWD}/${destination}"
        fi

        echo "${fullPath}" >> ~/gitrepos.txt
    fi
}