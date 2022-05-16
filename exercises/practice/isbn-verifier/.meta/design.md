# Design

This exercise differs from the upstream problem-specifications one because we're trying to teach "[parse don't validate](https://lexi-lambda.github.io/blog/2019/11/05/parse-don-t-validate/)".

Implementations of tests for the bonus tasks are deliberately excluded and instead we encourage the student to write their own. If you are thinking of changing this, maybe review the newer solutions and see if students did actually start defining their own tests (we started suggesting writing your own tests in May 2022).

I (@cmcaine) wasn't sure if the better interface was `ISBN(s)` or `parse(ISBN, s)`. I went with the former to keep things simple, but there's a clear argument in the standard library for defining both (e.g. `Dates.Date` and `Base.UUID`).

It might have been better to require `ISBN(s)` to throw `ArgumentError`, as e.g. `Dates(2022, 13, 1)` or `parse(Int, 'a')` do, but earlier versions of this exercise use `DomainError`, so whatever. Mostly this is Julia's fault for having two exception types with similar uses.
