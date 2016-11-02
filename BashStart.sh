#!/bin/bash

fileLoc=$(dirname "${BASH_SOURCE[0]}")

# General functions
. ${fileLoc}/function_md.sh
. ${fileLoc}/function_up.sh
. ${fileLoc}/function_rd.sh
. ${fileLoc}/function_addAlias.sh
. ${fileLoc}/function_rebash.sh



# Git functions
. ${fileLoc}/git/gitInit.sh
. ${fileLoc}/git/gitClone.sh
. ${fileLoc}/git/gitPush.sh
. ${fileLoc}/git/gitPull.sh
. ${fileLoc}/git/gitBranch.sh
. ${fileLoc}/git/gitFirstRun.sh
. ${fileLoc}/git/toWiki.sh
. ${fileLoc}/git/parseGitBranch.sh
