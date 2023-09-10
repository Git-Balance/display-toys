#!/usr/bin/env bash

boxer()
{
    local boxType=$1
    local boxLength=$2
    local boxPrint=''
    local boxStart=''
    local boxEnd=''

    if [ "$boxType" == "up" ]
    then
        boxStart='└'
        boxEnd='┘'
    elif [ "$boxType" == "down" ]
    then
        boxStart='┌'
        boxEnd='┐'
    else
        echo 'Invalid box type'
    fi

    boxPrint=$boxStart
    for (( i = 0; i < $boxLength - 2; i++ ))
    do
        boxPrint=$boxPrint'─'
    done
    boxPrint=$boxPrint$boxEnd

    echo $boxPrint
}

calendarWidget()
{
    local boxSize=22
    
    boxer down $boxSize
    cal | sed 's/^/ /' | cat
    boxer up $boxSize
    
    # Just some tests that are here for reference 
    #
    # boxer down 22
    # cal 2 Jan 2022 | sed 's/^/ /' | cat
    # boxer up 20
    # echo "\ttest" | cat
}

statusWidget()
{
    local boxSize=42

    boxer down $boxSize
    echo "$(date "+ %a, %b of %d | %H:%M") | Battery at $(cat /sys/class/power_supply/BAT0/capacity)%"
    boxer up $boxSize
}

statusWidget
calendarWidget
