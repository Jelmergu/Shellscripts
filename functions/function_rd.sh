#!/bin/bash

# This function can delete a directory and all files in that directory
# If no directory is specified it will delete current working directory
# 
# Made by: Jelmer Wijnja
# Made for: Personal use

function rd {
    local directory="${1}"

    if [ -z "${directory}" -o "${directory}" = "." ]
        then
        read -p "Delete current directory? [y/n]: " choice
        choice=$(strictChoice "${choice}")

        if [ "$choice" = "y" ]
            then
            directory="${PWD##*/}"
            cd ../
            rm -Rf "${directory}"
            echo "${directory} deleted"
        fi

    else
        read -p "Delete ${directory}? [y/n]: " choice
        choice=$(strictChoice "${choice}")
        if [ "$choice" = "y" ]
            then
            rm -Rf "${directory}"
            echo "${directory} deleted"
        fi
        echo "${directory} deleted"
    fi
}