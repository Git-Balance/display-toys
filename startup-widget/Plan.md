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

### Make a script run at start with Alacritty
`alacritty --hold -e neofetch` will open a new alacritty window with the output of `neofetch`
HOWEVER, it only displays the output of `neofetch`. It will NOT allow the user to input anything
Additionally, `alacritty --hold -e "neofetch; zsh"` will not work.
The error code of `neofetch; zsh`:
```
Error: Failed to spawn command 'neofetch; zsh': No such file or directory (os error 2)
Error: "Event loop terminated with code: 1"
```
## Future Plans
- [ ] Make a function that places multiline commands like `cal` side by side, so that the widgets are able to be placed better
EX:
|---------| |------------|
 24 of May   100% Battery
|---------| |------------|

- [ ] After making the previous plan's function, separate statusWidget into 2 separate widgets
