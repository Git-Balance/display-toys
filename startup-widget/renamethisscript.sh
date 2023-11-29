#!/usr/bin/env bash

boxer()
{
    local boxType=$1
    local boxLength=$2
    local boxPrint="empty"
    local boxStart="empty"
    local boxEnd="empty"

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
    for (( i = 0; i < boxLength - 2; i++ ))
    do
        boxPrint=$boxPrint'─'
    done
    boxPrint=$boxPrint$boxEnd

    echo "$boxPrint"
}

cmdBox() {
    boxed=""
    width=-1
    height=-1
    while getopts "c:w:h:" option; do
        case $option in
            c)
                boxed=$OPTARG
                ;;
            w)
                width=$OPTARG
                ;;
            h)
                height=$OPTARG
                ;;
        esac
    done
    max_length=`$boxed | awk '{
        line=$0
        while (line ~ / $/) {
            line = substr(line, 1, length(line)-1)
        }
        if (length(line) >= max_length) {
            max_length = length(line)
        }
    }
    END { print max_length }'`
    boxer down $max_length+2
    $boxed | awk -v max_length=$max_length '{
        line=$0
        while (line ~ / $/) {
            line=substr(line, 1, length(line)-1)
        }
        add_length = max_length-length(line)
        while (add_length > 0) {
            line=line" "
            add_length=add_length-1
        }
        print "│" line "│"
    }'
    boxer up $max_length+2
}

strBox()
{
    len=${#1}
    boxer down $len+2
    echo "$1" | awk -v max_length=$len '{
        line=$0
        while (line ~ / $/) {
            line=substr(line, 1, length(line)-1)
        }
        add_length = max_length-length(line)
        while (add_length > 0) {
            line=line" "
            add_length=add_length-1
        }
        print "│" line "│"
    }'
    boxer up $len+2

}

fullBox()
{
    lines=()
    width=-1
    length=-1
    while getopts ":w:l:s:" option; do
        case $option in
            w)
                width=$OPTARG
                ;;
            l)
                width=$OPTARG
                ;;
            s)
                lines+=( $(awk '{
                    line = $0
                    while (line ~ / $/) {
                        line = substr(line, 1, length(line)-1)
                    }
                    print "\""line"\""
                }') )
                ;;
        esac
    done

    lines=( $( awk -f getLines.awk < awkpipe) )
    echo $lines
    echo $1
    echo $0
    for line in ${lines[@]}; do
        max_length=`awk -v line=$line -v max_length=$max_length '{ 
            if (length(line) >= max_length) {
                print length(line)
            }
        }'`
    done

    for line in ${lines[@]}; do
        echo $line
        awk -v max_length=$max_length -v line=$line '{
            add_length = max_length - length(line)
            while (add_length > 0) {
                line=line" "
                add_length=add_length-1
            }
            print "│" line "│"
        }' $line
    done
}

calendarWidget()
{
    cmdBox -c cal

    # local boxSize=22
    
    # boxer down $boxSize
    # cal | sed 's/^/ /' | cat
    # boxer up $boxSize
    
    # Just some tests that are here for reference 
    #
    # boxer down 22
    # cal 2 Jan 2022 | sed 's/^/ /' | cat
    # boxer up 20
    # echo "\ttest" | cat
}

statusWidget()
{
    # battery=`(cat /sys/class/power_supply/BAT0/capacity)`
    strBox "$(date "+%a, %b of %d | %H:%M") | Battery at 100%"
}

fullBox
statusWidget
calendarWidget
