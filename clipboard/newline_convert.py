import pyperclip as pc
import re

# This took 20 minutes to write

text = pc.paste()
newline_regex = re.compile(r'\n')
sub = newline_regex.sub(' ', text)
print(sub)
pc.copy(sub)
