import re
from datetime import date

string = "* TODO 3"
f = open("fileread.txt", "r")
a = open("edited.txt", "a")
t = date.today()
print("Today is " + t.strftime("%d %b %Y"))
for x in f:
    nx = ""
    nx = x.replace("\n", "")
  

    """
    search = re.search("^\* \w* ?\d+", nx)
    if search:
        print("Search successful")
        print(nx)
    """

f.close
