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
