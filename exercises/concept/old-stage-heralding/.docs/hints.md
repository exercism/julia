# Hints

## 1. Capture the information needed to generate the cards using regex

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

## 2. Generate the moderation card
