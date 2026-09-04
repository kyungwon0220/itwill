message = 'ab4690cfvg342가1나1다0'

word = []
for ch in message:
    if ch.isdigit():
        word.append(ch)

print(word)

# print(list(filter(lambda ch: ch.isdigit(), message)))
