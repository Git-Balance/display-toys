#!/usr/bin/env bash

source renamethisscript.sh

readTest() {
    declare -a myarray #TODO: check that read -a needs you to use a array variable

    read -a myarray <<< $1

    echo $myarray[0]
    echo $myarray[1]
}

awkBlockTest() {
    max_length=`cal | awk 'length >= max_length { max_length = length; longest_line = $0; print "N: " max_length " " longest_line "\\n"} END { print max_length " " longest_line "|"}'`
    echo $max_length
}

awkBlockTest cal
