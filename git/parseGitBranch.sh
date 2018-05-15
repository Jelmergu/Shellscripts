function parseGitBranch {
    branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null) 
    
    if [[ "${branch}" == "" ]] # do not execute script if PWD is no git repo
        then
        return 0
    fi
    
    declare -A counter
    declare -A prefix
    declare -A stPrefix

    counter=([modified]=0 [new]=0 [deleted]=0 [both]=0 [untracked]=0)
    prefix=([modified]=M [new]=N [deleted]=D [both]=BM [untracked]=U)
    stPrefix=(["M"]=modified ["A"]=new ["D"]=deleted ["UU"]=both ["N"]=untracked)

    # detect changed, new, deleted, mergin and untracked files
    while read -r -d '' state file; do
        lPrefix="${state}"
        [ "${state}" = '??' ] && lPrefix="N"
        change="${stPrefix[$lPrefix]}"
        ((counter[${change}]++))
    done < <(git status -z)

    count=0 # for the index of both arrays
    result=""
    for C in "${!counter[@]}"; do #iterate through array
        if [ ${counter[${C}]} != 0 ] # when any of the changes are detected generate a result
            then
            result="${result}${prefix[${C}]}:${counter[${C}]} " # the previous result+one of {M,N,D,BM,U}+amount of changes
        fi
        echo "${C} --- ${counter[${C}]}"
    done

    echo "git branch->${branch}{${result}}"
}

# v2 sneller door gebruik van numerieke index
# function parseGitBranch {
#     branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null) 
#     if [[ "${branch}" == "" ]] # do not execute script if PWD is no git repo
#         then
#         return 0
#     fi

#     counter=(0 0 0 0 0)
#     prefix=(M N D BM U)
#     #detect changed, new, deleted and mergin files
#     while IFS='' read -r line || [[ -n "$line" ]]; do
#         for C in ${line}; do

#             if [[ ${C} == *modified* ]]
#                 then
#                     ((counter[0]++))
#             elif [[ ${C} == *new* ]]
#                 then
#                     ((counter[1]++))
#             elif [[ ${C} == *deleted* ]]
#                 then
#                     ((counter[2]++))
#             elif [[ ${C} == *both* ]]
#                 then
#                     ((counter[3]++))
#             fi
#         done
#     done < <(git status)

#     # detect untracked files
#     while IFS='' read -r line || [[ -n "$line" ]]; do
#         for C in ${line}; do
#             ((counter[4]++))
#         done
#     done < <(git ls-files --others --exclude-standard)

#     count=0 # for the index of both arrays

#     for C in ${counter[@]}; do #iterate through array
#         if [[ ${C} != 0 ]] # when any of the changes are detected generate a result
#             then
#             result="${result}${prefix[${count}]}:${counter[${count}]} " # the previous result+one of {M,N,D,BM,U}+amount of changes
#         fi
#         ((count++)) # increase the count for the index
#     done
    
#     echo "git branch->${branch}{${result}}"
# }