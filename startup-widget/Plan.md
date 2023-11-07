# Plan for startup-widget

## General notes
- Make a ~~simple "widget"~~ have multiple widgets (like the one in `dunesh`) that run on the creation of a terminal
- It should look similar to `dunesh` or `neofetch`
## What it will have
- A calendar
- Current date and time
- Battery percentage
- Uptime
- ~~Wifi and bluetooth status~~
## Detailed ideas
### Improve the `boxer` function

Make `boxer` actually box the entered command.
[This command will get the largest line length](https://unix.stackexchange.com/a/24510)
```
awk 'length > max_length { max_length = length; longest_line = $0 } END { print longest_line }' ./text
```
Actually, this would be a great oprotunity to try the awk programming language (remember that awk IS a language)



- [ ] Try out the awk programming language
- [x] Research the `END` command of awk more
- [ ] Figure out how to pipe multiline output (like the output of the cal command)

#### Part 1: `awk` prototype

```bash
awk 'length > max_length {max_length = length; longest_line = $0} END { print longest_line " " max_length }' <<< $(cat)
```
Wait, what does the `END` is the above command do? I ASSUMED that it mearly ended the if statement. However, now I'm thinking that it executes something after it reaches a EOF.
Yep, `END` executes stuff after EOF

Also, minor issue
```
max_length=`cal | awk 'length >= max_length { max_length = length; longest_line = $0; print "N: " max_length " " longest_line "\n"} END { print max_length " " longest_line "|"}'`
```
`awk` should be printing newlines. However, the output of `awk` is being assigned to a variable, and variables usually get rid of newlines. Therefor, echoing `$max_length` will not be outputed on multiple lines

##### Pseudocode planning

```
for each line in input
	if length > max_length
		max_length = length
		longest_line = $0
boxer down max_length+2
for each line in input
	--- method 1
	Add " " until the line is the length of max_length
	--- method 2
	while length < max_length
		Append " " to the end of the line
	--- this is the current main problem
	Add "|" to start and end of line
boxer up max_length+2
```

#### Part 2: Add parameters

Using [this article](https://www.redhat.com/sysadmin/arguments-options-bash-scripts) as a guide on how to implement args in bash

`getopts` and `getopt` are *not* the same thing. You want `getopts` only

```
while getopts ":hn:" option; do
   case $option in
      h) # display Help function (should be declared already)
	     Help
         exit;;
	  n) # get user input
	     argThing=$OPTARG # to have a default argThing value, declare the variable before this argument code
             # $OPTARG is the argument that is being read (-n "entered stuff")
		 ;;
	  \?) # invalid options run this
	     echo "parametersTest.sh error: Invalid Option: "$OPTARG
		 exit;;
   esac
done
```

Here is an interesting fact about arguments
```
~/Scripts/display-toys/startup-widget$ cat test.sh
echo $1 $2 $3
~/Scripts/display-toys/startup-widget$ ./test.sh test2 test3 test4 test5
test2 test3 test4
~/Scripts/display-toys/startup-widget$ ./test.sh -n test2 test3 test4 test5
test2 test3~/Scripts/display-toys/startup-widget$
```
Yeah, bash does this. IDK why

#### Part 3-1: Putting it all together

2 function had to be created
- cmdBox - box a specific command
- strBox - box a string

Long story short, they both work using a mix of the combined widget test code and parameters test code, but it doesn't work particularily well. I get a glitched output if I run cmdBox in a weird way

Also, strBox should be getting rid of empty space, but it just removes it and readds it

Actually, now that I think about it, couldn't I just make one function that relies on piping to work?

#### Part 3-2: Putting it together properly

Get rid of the 2 existing functions, and replace them with one well made function
**fullBox**

It will have the following syntax
fullBox [-w widthNum] [-l lengthNum] inputStr

`-w` will lock in the width of the box 
	add empty lines or remove existing ones when needed
`-l` will lock in the length of the box
`inputStr` should be self explanatory
```
> fullBox -w 5 -l 2 "a\nb\nc"
-----
|a  |
|b  |
-----
```

Each line will be stored in an index of a array variable
Call it lines or something

#### Part 4: Getting the arguments working (LATER)

### Fix the error with the `source` command
Whenever you try to use `source` to get functions, this message pops up
```
❯ source renamethisscript.sh
boxer:8: = not found
```
The issue seems to be caused by [this](https://stackoverflow.com/q/12468889/18442885) 

The following commands give more context
```
project-5402aa23-eb64-4757-8f9f-7771fda58164% cat -n filetest.py
     1  import re
     2  from datetime import date
     3
     4  string = "* TODO 3"
     5  f = open("fileread.txt", "r")
     6  a = open("edited.txt", "a")
     7  t = date.today()
     8  print("Today is " + t.strftime("%d %b %Y"))
     9  for x in f:
    10      nx = ""
    11      nx = x.replace("\n", "")
    12    
    13
    14      """
    15      search = re.search("^\* \w* ?\d+", nx)
    16      if search:
    17          print("Search successful")
    18          print(nx)
    19      """
    20
    21  f.close
project-5402aa23-eb64-4757-8f9f-7771fda58164% source filetest.py 
import-im6.q16: unable to open X server `' @ error/import.c/ImportImageCommand/346.
filetest.py:2: command not found: from
filetest.py:4: command not found: string
filetest.py:5: invalid mode specification
filetest.py:6: unknown file attribute:  
filetest.py:10: command not found: nx
filetest.py:11: unknown file attribute: \
filetest.py:14: no matches found: w*
filetest.py:21: command not found: f.close
```

### DONE Make a script run at start with Alacritty
`alacritty --hold -e neofetch` will open a new alacritty window with the output of `neofetch`
HOWEVER, it only displays the output of `neofetch`. It will NOT allow the user to input anything
Additionally, `alacritty --hold -e "neofetch; zsh"` will not work.
The error code of `neofetch; zsh`:
```
Error: Failed to spawn command 'neofetch; zsh': No such file or directory (os error 2)
Error: "Event loop terminated with code: 1"
```
NVM, just adding the script to the start of the .zsh works well enough. IDK where I got the idea that I had to make the terminal emulator run the script

## Future Plans
- [ ] Make a function that places multiline commands like `cal` side by side, so that the widgets are able to be placed better
EX:
|---------| |------------|
 24 of May   100% Battery
|---------| |------------|

- [ ] After making the previous plan's function, separate statusWidget into 2 separate widgets
