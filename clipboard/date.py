import pyperclip # type: ignore
from datetime import date

pyperclip.copy(str(date.today()))
