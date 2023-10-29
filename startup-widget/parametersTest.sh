#!/usr/bin/env bash

argThing="default"
argtwo="default2"
            # remember that all the valid arguments are between 2 ":" here
            # NOPE, the ":" are there to represent if an argument allows for an optional argument
            # "h" has no need for an optional argument, so it does not need a ":"
            # "n" and "a" need an optional argument, so they do need a ":"
while getopts "hn:a:" option; do
    case $option in
        h) # display Help
            echo 'Help'
            exit;;
        n) #get user input
            argThing=$OPTARG
            ;;
        a)
            argtwo=$OPTARG
            ;;
        \?) # invalid option
            echo "parametersTest.sh error: Invalid Option: "$OPTARG
            exit;;
    esac
done

source renamethisscript.sh

boxer down 10
echo $argThing $argtwo
echo $1 $2 $3
boxer up 10
