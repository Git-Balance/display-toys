#!/usr/bin/env bash

# Plan
# - get input from paremeter
# - print top rows
# - use ~~paste~~ column to attach lines to each end
#   - alternatively, use awk
#   https://unix.stackexchange.com/questions/442227/aligning-output-in-linux-paste-command
# - print output
#

paste file1 file2 | awk -F '\t' -v len=$(awk -F '\t' 'length > m { m = length } END { print m }' file1 file2) '{ printf("|%*s|%*s|\n", len, $1, len, $2 ) }'
