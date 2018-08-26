#!/usr/bin/env bash

work_dir=$(pwd)
args="$@"

if [ -f ${work_dir}/gradlew ]
then
    bash=$(which bash)
    gradle="${bash} ${work_dir}/gradlew"
else
    gradle=$(which gradle)
fi

${gradle} ${args[@]:1}

# 可以软链接成 gradle
