# Instructions append

## Bonus tasks

If you attempt these tasks please write your own tests for them in your solution file!

* Define a string macro so that `isbn"3-598-21507-X" == ISBN("3-598-21507-X")`.

* Let the constructor accept ISBN-13s as well. The same ISBN should compare equal regardless of format: `ISBN("1-234-56789-X") == ISBN("978-1-234-56789-7")`.

* Define a function or iterator to generate a valid ISBN, maybe even from a given starting ISBN.

 Can you store the ISBN as an integer rather than a string and would that ever be a good idea?
 If you did, could you still print the ISBN (including check-digit) as a string?
