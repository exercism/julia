# Hints

## 1. Write a regex that captures the information you need to generate the cards

- `\p{L}` will match any kind of letter from any language.
- You can use `^»(?P<title>.+)« – (?P<speaker>[\p{L} ]+)(?:\s+\(?(?P<pronouns>[a-z\/]+)?\))?(?:, from (?P<org>[^.]+))?\. Start: (?P<start>[\d:]+)(?:, Q&A: (?P<qanda>[\d:]+))?, End: (?P<end>[\d:]*)$` as the regex.

## 2. Write a function that takes a line and returns the generated moderation card
