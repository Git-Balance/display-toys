#!/usr/bin/env bash

source renamethisscript.sh

readTest() {
    declare -a myarray #TODO: check that read -a needs you to use a array variable

    read -a myarray <<< $1

    echo $myarray[0]
    echo $myarray[1]
}

read -a myarray <<< `calendarWidget`

echo $myarray[0]
echo $myarray[1]
