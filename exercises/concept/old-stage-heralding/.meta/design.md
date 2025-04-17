# Design

## Learning objectives

### Primary objectives

- Know what the `r` in `r""` means; in other words: know how to use string literals as a shortcut to define an instance of a type.
- Know about the `r""` string literal.
- Know how to match a string against a regex.
- Know how to access information from a `RegexMatch` object.

### Secondary objectives

- Be aware about false assumptions about people, e.g. not assuming ASCII names, by having test cases that won't work under such assumptions.

## Out of scope

- Learning regex themselves.
- Implementing custom string literals.
- Understand how string literals can be used for more complex metaprogramming.

## Concepts

The Concepts this exercise unlocks are:

- `regex`
- `string-literals-using`: This may change in the future

## Test cases

Potential future test cases should conform to the following guidelines:

- The delimiters must be unambiguous. For example, a talk title should not contain `»«`, a name should not contain commas.
- The test cases should be ordered based on the optionality of certain information. The first case should contain all potential information, the next case should make exclude one piece of capturable information, etc.
- Solutions using `[a-zA-Z]` or the likes for the name, title or org should not be able to pass the tests.


## Analyzer

The analyzer should disregard most of the regex defined by the student.
The regex itself is out of scope of the exercise and does not need to be mentored.
This should be clearly communicated to both mentors and students.

The analyzer may suggest alternative approaches to writing the regex, e.g. using named capture groups or writing multi-line expressions, but this is not a priority.

## Representer

The regex itself is not in the scope of the exercise and does not need to be mentored.
Solutions where the regex differs but the rest is identical should be considered identical by the representer.
This should be clearly communicated to both mentors and students.
