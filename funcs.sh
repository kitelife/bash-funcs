#!/usr/bin/env bash

prefix_log() {
    level=$1
    msg=$2
    echo "$(date +'%D %H:%M:%S') ${level} ${msg}"
}

log_debug() {
    prefix_log "DEBUG" $1
}

log_info() {
    prefix_log "INFO" $1
}

log_warn() {
    prefix_log "WARN" $1
}

log_error() {
    prefix_log "ERROR" $1
}

true_then_run() {
    condition=$1
    action=$2

    (${condition})
    if [ $? -eq 0 ]
    then
        (${action})
    else
        log_info "'$1' is false, don't run '$2'"
    fi
}

false_then_run() {
    condition=$1
    action=$2

    (${condition})
    if [ $? -ne 0 ]
    then
        (${action})
    else
        log_info "'$1' is true, don't run '$2'"
    fi
}

map() {
    for item in $2
    do
        ($1 ${item})
    done
}

reduce() {
    operator=$1
    #
    list=($2)
    list_len=${#list[@]}
    #
    result=""
    if [ ${list_len} -gt 0 ]
    then
        result=${list[0]}
    fi
    #
    if [ ${list_len} -gt 1 ]
    then
        for item in ${list[@]:1}
        do
            result=$(${operator} ${result} ${item})
        done
    fi
    echo ${result}
}

filter() {
    for item in $2
    do
        ($1 ${item})
        if [ $? -eq 0 ]
        then
            echo ${item}
        fi
    done
}

sum() {
    v=0
    for arg in "$@"
    do
        v=$(($v+${arg}))
    done
    echo $v
}
