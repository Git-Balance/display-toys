#!/usr/bin/env bash

source renamethisscript.sh

readTest() {
    declare -a myarray #TODO: check that read -a needs you to use a array variable

    read -a myarray <<< $1

    echo $myarray[0]
    echo $myarray[1]
}

awkBlockTest() {
    while getopts ":h:" option; do
        case $option in
            h) # display help
                echo "Usage: awkBlockTest [OPTION] [COMMAND]"
                echo "Box [COMMAND]"
                echo "|"
                echo "It is recommended to use a command that has a consistent output, as this function assumes that the length of the command will not change between two calls"
                echo "|"
                echo "-h        print help text"

                exit;;
        esac
    done
    
    # TODO: Fix my reliance on using stuff like $1. It doesn't work well with parameters
    max_length=`$1 | awk 'length >= max_length { max_length = length; longest_line = $0 } END { print max_length }'`
    echo "|"$max_length"|"
    boxer down $max_length+2
    $1 | awk -v max_length=$max_length '{

        line=$0
        add_length=max_length-length

        # add blank text to a line that isnt long enough
        while (add_length > 0) {
            line=line" "
            add_length=add_length-1
        }

        # Print the completed line
        print "│" line "│"
    }'
    boxer up $max_length+2
}

awkBlockTest cal
awkBlockTest 'echo -e testtest\ntest\n test \nlongest line here'
awkBlockTest cal -h
