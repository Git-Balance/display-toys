#!/usr/bin/env bash

source renamethisscript.sh

readTest() {
    declare -a myarray #TODO: check that read -a needs you to use a array variable

    read -a myarray <<< $1

    echo $myarray[0]
    echo $myarray[1]
}

awkBlockTest() {
    max_length=`$1 | awk 'length >= max_length { max_length = length; longest_line = $0 } END { print max_length }'`
    echo "|"$max_length"|"
    boxer down $max_length+2
    $1 | awk -v max_length=$max_length '{
        line=$0
        add_length=max_length-length
        while (add_length > 0) {
            line=line" "
            add_length=add_length-1
        }
        print "│" line "│"
    }' #TODO:
    boxer up $max_length+2
}

awkBlockTest cal
awkBlockTest 'echo -e testtest\ntest\n test \nlongest line here'

