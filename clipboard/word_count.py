import pyperclip

while True:
    text = pyperclip.waitForNewPaste()
    print("----------")
    print(text)
    print()
    print("Words: " + str(len(text.split())))

