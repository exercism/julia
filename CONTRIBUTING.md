# Contributing

This is the Julia track, one of the many tracks on [exercism.io][web-exercism].
It holds all the _exercises_ that are currently implemented and available for students to complete.
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

## Concepts and concept exercises

These have been moved into `.wip` directories to make `configlet lint` helpful again.

To make configlet see them again:

```bash
mv concepts{.wip,}
mv exercises/concept{.wip,}
jq -s '.[0] * .[1]' config.json concepts.wip/config.json > tmp && mv tmp config.json
```

To hide them again:

```bash
mv concepts{,.wip}
mv exercises/concept{,.wip}
jq '{concepts: .concepts, exercises: {concept: .exercises.concept}}' config.json > concepts.wip/config.json
jq '.concepts=[]|.exercises.concept=[]' config.json > tmp && mv tmp config.json
```

## Exercises

Before contributing code to any existing exercise or any new exercise, please have a thorough look at the current exercises and dive into [open issues][issue-open].

### New exercise

There are two ways to implement new exercises.

1. Pick one from [the list of exercises][list-of-exercises]
2. Create a new, track-specific exercise from scratch.

#### Implementing an existing exercise for Julia

Let's say you want to implement a new exercise, from the list of exercises, because you've noticed that this track could benefit from this exercise, really liked it in another track, or just because you find this interesting; the first step is to [check for an open issue][issue-new-exercise].
If it's there, make sure no one is working on it, and most of all that there is not an open Pull Request towards this exercise.

If there is no such issue, you may open one. The baseline of work is as follows:

1. Optionally open a new issue, we'll label it with `new exercise ✨`
2. We'll assign the issue to you, so you get to work on this exercise
3. Read the documentation for [practice][docs-practice-exercise] or [concept][docs-concept-exercise] exercises.

You will need to create a runtests.jl file. You may be able to generate this from the information in the problem-specifications repo using the script in the bin directory of this repo.
You should try to solve the exercise. Once you have a solution that passes the tests (it doesn't need to be perfect!) move it to .meta/example.jl

The final step is opening a Pull Request.
Make sure the tests pass and the config linter doesn't complain.
They will run automatically on your PR.

#### Creating a track-specific exercise

The steps for a track-specific exercise are similar to those of implementing an established, existing exercise. The differences are:

- You'll have to write the instructions and test-suite from scratch
- You'll have to come up with a unique _slug_.
- You may want to assign an icon
- Generate a UUID, for example using [configlet][configlet].

Open a new issue with your proposal, and we'll make sure all these steps are correctly taken.
Don't worry!
You're not alone in this.

### Exercise structure

After following the steps above, your exercise should contain _at least_ the following files:

- `.docs/` - The problem description and other information that is presented to the student. Generated using `configlet`.
- `example.jl` - Contains an example solution that proves the test suite works.
- `$slug.jl` - The file that the student will write their solution in. May contain stubs or be empty depending on the exercise.
- `runtests.jl` - The test suite for the exercise. Contains a standardized comment referring to the canonical data version and tests. It must only `include` `$slug.jl`, not `example.jl`.

Further, an entry in `config.json` was added for the exercise.

It may contain further files, e.g. to add additional information or provide extra code. This is the bare minimum. See `README.md` for further formatting standards.

Take a look at the `exercise/` directory or commit history for examples, or at this [example](https://github.com/exercism/julia/pull/560) of what a PR adding a new exercise should look like.

### Existing exercises

There are always improvements possible on existing exercises. 

#### Improving the exercise instructions

The files in .docs define the exercise instructions.
Read more about what they're supposed to contain and where to edit them [here][doc-readme].

There are some generic instructions that appear for every exercise. If you want to edit those, just search the repo for the text you saw on the website and wanted to edit.

#### Syncing the exercise

Syncing an exercise with _canonical data_: There is a [problem-specifications][problem-specifications] repository that holds test data and exercise instructions in a standardised format.
These files are occasionally fixed, improved, added, removed or otherwise changed.
Syncing an exercise consists of:

  - rerunning the test generator script (and then re-adding and julia-specific tests)
  - check that the `example.jl` still works with the new tests. If it doesn't, have a think about whether we want the new tests or want to opt out, maybe open an issue.
  - sync the instructions and introduction files in .docs. Make sure that any changes we've made specifically for the Julia track are maintained
  - think about whether synchronising the exercise has actually improved the track, if it hasn't, maybe open a PR on problem-specifications to improve the content there first, or open an issue here to let us know.

#### Improving or adding dig-deeper pages and mentor notes

We like to include detailed information about expert solutions to exercises. You can find this information in the .approaches directory for exercises. Please feel free to open a PR or an issue if you'd like to make a change. Tag @cmcaine because they wrote most of these docs :)

This content was mostly pulled from the mentoring notes in the `exercism/website-copy` repository, but for maintenance ease we only update the "approaches" files now. Most of the content from the old mentoring notes has been adapted into the approaches files now (see https://github.com/exercism/julia/issues/644 for any remaining conversions).

## Documentation

There is quite a bit of student-facing documentation, which can be found in the [`docs`][file-docs] folder.
You may improve these files by making the required changes and opening a new Pull Request.

## Tools

You'll need the latest LTS release of Julia (or any newer version) in order to contribute to the _code_ in this repository.

### Fetch configlet

If you'd like to download [configlet][configlet], you can use the [`fetch-configlet`][bin-fetch-configlet] scripts.
They will run on Linux, Mac OSX and Windows, and download `configlet` to your local drive.
Find more information about [configlet here][configlet].

### Scripts

We have various scripts for you in order to aid with maintaining and contributing to this repository.
You can find them in the `bin/` directory.

[configlet]: https://github.com/exercism/configlet
[bin-fetch-configlet]: https://github.com/exercism/julia/blob/master/bin/fetch-configlet
[web-exercism]: https://exercism.org
[file-config]: https://github.com/exercism/julia/blob/master/config.json
[file-docs]: https://github.com/exercism/julia/blob/master/docs
[issue-open]: https://github.com/exercism/julia/issues
[issue-discussion]: https://github.com/exercism/julia/labels/discussion%20%3Aspeech_balloon%3A
[issue-new-exercise]: https://github.com/exercism/julia/issues?q=is%3Aopen+is%3Aissue+label%3A%22%3Asparkles%3A+new+exercise%22
[list-of-exercises]: https://tracks.exercism.io/julia/master/unimplemented
[contributing-generic]: https://exercism.org/docs/building/tracks
[contributing-website-copy]: https://github.com/exercism/website-copy#contributing
[contributing-git-basics]: https://exercism.org/docs/building/github
[contributing-pr-guidelines]: https://exercism.org/docs/building/github/contributors-pull-request-guide
[doc-readme]: https://exercism.org/docs/building/tracks/practice-exercises
[problem-specifications]: https://github.com/exercism/problem-specifications
[coc]: ./CODE_OF_CONDUCT.md
[mentor-notes]: https://github.com/exercism/website-copy/tree/master/tracks/julia/exercises
[docs-practice-exercise]: https://exercism.org/docs/building/tracks/practice-exercises
[docs-concept-exercise]: https://exercism.org/docs/building/tracks/concept-exercises
