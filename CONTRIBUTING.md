# Contributing

This is the Julia track, one of the many tracks on [exercism.io][web-exercism].
It holds all the _exercises_ that are currently implemented and available for students to complete.
The track consists of various **core** exercises, the ones a student _must_ complete, and each **core** exercise may unlock various _side_ exercises.
You can find this in the [`config.json`][file-config].
It's not uncommon that people discover incorrect implementations of certain tests, have a suggestion for a track specific hint to aid the student on the _Julia specifics_, report missing edge cases, factual errors, logical errors, and, implement exercises or develop new exercises.

We welcome contributions of all sorts and sizes, from reporting issues to submitting patches, as well as joining the current [discussions 💬][issue-discussion].

---

This guide covers several common scenarios pertaining to **improving the Julia track**. There are several other guides about contributing to other parts of the Exercism ecosystem, that are similar to this repository.

* [Generic information about track-contributing][contributing-generic]

There are track-independent guides on how to use git and GitHub available:

* [Git Basics][contributing-git-basics]
* [Pull Request Guidelines][contributing-pr-guidelines]

## Code of Conduct

Help us keep Exercism welcoming. Please read and abide by the [Code of Conduct][coc].

## Exercises

Before contributing code to any existing exercise or any new exercise, please have a thorough look at the current exercises and dive into [open issues][issue-open].

### New exercise

There are two ways to implement new exercises.

1. Pick one from [the list of exercises][list-of-exercises]
2. Create a new, track-specific exercise from scratch.

#### Implementing existing exercise

Let's say you want to implement a new exercise, from the list of exercises, because you've noticed that this track could benefit from this exercise, really liked it in another track, or just because you find this interesting; the first step is to [check for an open issue][issue-new-exercise].
If it's there, make sure no one is working on it, and most of all that there is not an open Pull Request towards this exercise.

If there is no such issue, you may open one. The baseline of work is as follows:

1. Open a new issue, we'll label it with `new exercise ✨`
2. We'll assign the issue to you, so you get to work on this exercise
3. Create a new folder `exercises/$slug`
   - `$slug` refers to the exercise slug, the machine-readable name that is listed in [the list of exercises][list-of-exercises]
4. Create a `$slug.jl` stub file.
5. Create a `runtests.jl` test file. Here add the tests, per [canonical data][problem-specifications] if possible.
   - Add a comment on top of the test file that contains the canonical data version you've used: `# canonical data version: x.y.z`
6. Create a `example.jl` file. Place a working implementation, assuming it's renamed to `$slug.jl`
   - The example solution is meant to show that the test suite works properly. It doesn't have to be an ideal or optimised solution!
7. Run the tests locally, by running `julia runtests.jl $slug` from the root of the repository.
8. Add the exercise to `config.json`. You can generate the entry interactively by running `julia bin/new-exercise.jl` and answering the prompts. If you're unsure about the difficulty, progression or topics, just guess and we will discuss it in the Pull Request.
   - You may have to install the [`configlet`](#fetch-configlet) first, if you haven't already.

Instead of manually creating a `runtests.jl` file, you may also add a generator script that takes the `canonical-data.json` for the exercise as input and generates a test suite from it.
Eventually we will create a framework for this but for now, individual scripts are fine.

The final step is opening a Pull Request, with these items all checked off.
Make sure the tests pass and the config linter doesn't complain.
They will run automatically on your PR.

#### Creating a track-specific exercise

The steps for a track-specific exercise are similar to those of implementing an established, existing exercise. The differences are:

- You'll have to write a README.md and test-suite from scratch
- You'll have to come up with a unique _slug_.
- We need to require an icon for it. (optional)
- Generate a UUID, for example using [configlet][configlet].

Open a new issue with your proposal, and we'll make sure all these steps are correctly taken.
Don't worry!
You're not alone in this.

### Existing exercises

There are always improvements possible on existing exercises. 

#### Improving the README.md

`README.md`: the description that shows up on the student's exercise page, when they are ready to start.
It's also downloaded as part of the exercise's data.
The `README.md`, together with the `runtests.jl` file form the contract for the implementation of the exercise.
No test should _force_ a specific implementation, no `README.md` explanation should _give away_ a certain implementation.
The `README.md` files are [generated][doc-readme], which is explains [here][doc-readme].

  - This file may need to be _regenerated_ in order to sync with the latest canonical data.
  - You may contribute track specific `hints.md`, as listed in that [document][doc-readme]
  - You may improve the track specific `exercise-readme-insert.md`, and regenerate all the readmes.

#### Syncing the exercise

Syncing an exercise with _canonical data_: There is a [problem-specifications][problem-specifications] repository that holds test data in a standardised format.
These tests are occasionally fixed, improved, added, removed or otherwise changed.
Each change also changes the _version_ of that canonical data.
Syncing an exercise consists of:

  - updating or adding the `version` comment on top of the `runtests.jl` file, 
  - updating the `runtests.jl` file,
  - match the `example.jl` file to still work with the new tests, and 
  - regenerate the `README.md`, should there be any changes.

#### Improving or adding mentor notes

[Mentor notes][mentor-notes] are the notes that are given to the mentors to guide them with mentoring.
These notes _do not live in this repository_, but instead in the `website-copy` repository.
Take a look at their [contributing guidelines][contributing-website-copy].

## Documentation

There is quite a bit of student-facing documentation, which can be found in the [`docs`][file-docs] folder.
You may improve these files by making the required changes and opening a new Pull Request.

## Tools

You'll need Julia 1.0 or higher in order to contribute to the _code_ in this respository.

### Fetch configlet

If you'd like to download [configlet][configlet], you can use the [`fetch-configlet`][bin-fetch-configlet] scripts.
They will run on Linux, Mac OSX and Windows, and download `configlet` to your local drive.
Find more information about [configlet here][configlet].

### Scripts

We have various scripts for you in order to aid with maintaining and contributing to this repository.
You can find them in the `bin/` directory.

[configlet]: https://github.com/exercism/docs/blob/master/language-tracks/configuration/configlet.md
[bin-fetch-configlet]: https://github.com/exercism/julia/blob/master/bin/fetch-configlet
[web-exercism]: https://exercism.io
[file-config]: https://github.com/exercism/julia/blob/master/config.json
[file-docs]: https://github.com/exercism/julia/blob/master/docs
[issue-open]: https://github.com/exercism/julia/issues
[issue-discussion]: https://github.com/exercism/julia/labels/discussion%20%3Aspeech_balloon%3A
[issue-new-exercise]: https://github.com/exercism/julia/issues?q=is%3Aopen+is%3Aissue+label%3A%22%3Asparkles%3A+new+exercise%22
[list-of-exercises]: https://tracks.exercism.io/julia/master/unimplemented
[contributing-generic]: https://github.com/exercism/docs/tree/master/contributing-to-language-tracks
[contributing-website-copy]: https://github.com/exercism/website-copy#contributing
[contributing-git-basics]: https://github.com/exercism/docs/blob/master/contributing/git-basics.md
[contributing-pr-guidelines]: https://github.com/exercism/docs/blob/master/contributing/pull-request-guidelines.md
[doc-readme]: https://github.com/exercism/docs/blob/master/language-tracks/exercises/anatomy/readmes.md
[problem-specifications]: https://github.com/exercism/problem-specifications
[coc]: ./CODE_OF_CONDUCT.md
[mentor-notes]: https://github.com/exercism/website-copy/tree/master/tracks/julia/exercises
