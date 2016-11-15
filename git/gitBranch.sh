#!/bin/bash

# This function is a extension on git branch.
# It will change to a new branch once it is created
# It will switch to master branch if it is ordered to delete a branch

function gitBranch {

    if [ "${1}" = "-d" ]
        then
        git checkout master
        git branch "${1}" "${2}"
    elif [ -z "${1}" ]
        then
        git branch
    else
        git branch "${1}"
        git checkout "${1}"
    fi
}