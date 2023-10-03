#!/usr/bin/env bash

argThing="default"
            # remember that all the valid arguments are between 2 ":" here
while getopts ":hn:" option; do
    case $option in
        h) # display Help
            echo 'Help'
            exit;;
        n) #get user input
            argThing=$OPTARG
            ;;
        \?) # invalid option
            echo "parametersTest.sh error: Invalid Option: "$OPTARG
            exit;;
    esac
done

source renamethisscript.sh

boxer down 10
echo $argThing
echo $1 $2 $3
boxer up 10
