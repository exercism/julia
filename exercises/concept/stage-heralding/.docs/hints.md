# Hints

## 1. Write a regex that captures the information you need to generate the cards

- `\p{L}` will match any kind of letter from any language.
- You can use the following expression to capture the information:
  ```julia
  re = r"""»(.*)«                     # title
           \ –\ (.*?)                 # name
           (?:\ \((.*?)\)|)           # optional pronouns
           (?:,\ from\ (.*?)|).       # optional organisation
           \ Start:\ (.*?),\          # start time
           (?:Q&A:\ (.*?),\ |)        # optional Q&A time
           End:\ (.*)                 # end time
        """x
  ```

## 2. Write a function that takes a line and returns the generated moderation card
