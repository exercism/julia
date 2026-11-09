# Instructions

You are a stage herald at an international conference.
It's your job to announce speakers, remind them when their time is up, and moderate the Q&A session.
You're given a list of speakers on your stage in advance and need to turn them into moderation cards.

Since the list follows a particular formatting, you decide to write a short program that parses the list you're given using regular expressions (regex) and automatically generates the moderation cards.

~~~~exercism/note
This exercise is **not** about learning regular expressions.
It's about learning to use regex within Julia.
The hints contain a regular expression that you can use if you don't want to write one yourself.
~~~~

The list you're given contains the following information for each talk:

- its title,
- the speaker's name,
- their pronouns (optional),
- their organisation (optional),
- the start time of the talk,
- the start of the Q&A session (optional),
- and the end time of the talk.

A full entry has the following format:

```text
»Speedrunning 101« – Sasha Duda Krall (they/them), from GDQU. Start: 13:00, Q&A: 13:20, End: 13:30
```

Here, the title is `Speedrunning 101`, the speaker is called `Sasha Duda Krall`, from `GDQU`, and uses `they/them` pronouns.
The talk starts at `13:00`, there will be a Q&A starting at `13:20`, and the entire session ends at `13:30`.

~~~~exercism/caution
Since names may contain regular dashes `-`, an en dash `–` is used to separate the speaker and talk name.
~~~~

The moderation card that your program should generate for that talk looks like this:

```text
- Our next speaker is Sasha Duda Krall, from GDQU
- Their talk is called »Speedrunning 101«
- They will answer your questions in the Q&A session at the end of the talk, starting at 13:20

13:00 - 13:20 - 13:30
```

The entire list may look like this:

```text
»Speedrunning 101« – Sasha Duda Krall (they/them), from GDQU. Start: 13:00, Q&A: 13:20, End: 13:30
»How I learned to say Farewell« – Madeline (she/her). Start: 13:40, Q&A: 14:00, End: 14:05
»How To Find a Good Title For Your Conference Talk« – Vítězslav Kruse (he/him). Start: 14:15, End: 14:40
»Why Emoji Matter❣« – Ash van Amelsvoort, from the University of 🧬🧪⚛. Start: 14:50, Q&A: 15:05, End: 15:10
»Can dogs look up?« – Kira "k1ralli" Sørensen. Start: 20:50, Q&A: 21:05, End: 21:10
```

The corresponding cards are:

```text
- Our next speaker is Madeline
- Her talk is called »How I learned to say Farewell«
- She will answer your questions in the Q&A session at the end of the talk, starting at 14:00

13:40 - 14:00 - 14:05
```

```text
- Our next speaker is Vítězslav Kruse
- His talk is called »How To Find a Good Title For Your Conference Talk«
- There will not be a Q&A session

14:15 - NO Q&A - 14:40
```

```text
- Our next speaker is Ash van Amelsvoort, from the University of 🧬🧪⚛
- Ash's talk is called »Why Emoji Matter❣«
- Ash will answer your questions in the Q&A session at the end of the talk, starting at 15:05

14:50 - 15:05 - 15:10
```

```text
- Our next speaker is Kira "k1ralli" Sørensen
- Kira's talk is called »Can dogs look up?«
- Kira will answer your questions in the Q&A session at the end of the talk, starting at 21:05

20:50 - 21:05 - 21:10
```

A few things to note here:

- If no organisation is given for a speaker, leave it out in the moderation card.
- If no time for the Q&A session is given, the speaker opted against answering questions.
- If the speaker does not specify pronouns, use the speaker's first name instead.
  Note that it is not always appropriate to abbreviate someone's name like this, e.g. many Chinese names are better abbreviated by keeping the last name.
  However, the abbreviate-to-first-name rule happens to work fine for everyone speaking on this stage.

## 1. Capture the information needed to generate the cards using regex

It's easiest to use a regex builder tool like [regex101](https://regex101.com/) or [RegExr](https://regexr.com/) to do this.

~~~~exercism/caution
Make sure to set the regex engine/flavour to PCRE.
~~~~

If you're new to regex or struggle with creating an expression that captures all required information at once, you can also define several smaller expressions that capture parts of the information, e.g.

```julia-repl
julia> get_org("»Speedrunning 101« – Sasha Duda Krall (they/them), from GDQU. Start: 13:00, Q&A: 13:20, End: 13:30")
"GDQU"
```

## 2. Generate the moderation card

Use the expression from the first part and implement a function that takes a line as input, captures the information from it, and returns the generated moderation card according to the spec above.

```julia-repl
julia> generate_card("»How I learned to say Farewell« – Madeline (she/her). Start: 13:40, Q&A: 14:00, End: 14:05")
"- Our next speaker is Madeline\n- Her talk is called »How I learned to say Farewell«\n- She will answer your questions in the Q&A session at the end of the talk, starting at 14:00\n\n13:40 - 14:00 - 14:05\n"
```
