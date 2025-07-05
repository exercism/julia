# Design

## Goal

The goal of this exercise is to introduce the student to the Dates module in Julia.

## Learning objectives

- Understand module inclusion (`import Dates` vs `using Dates`).
- Understand the scope and limitations of `Date`, `Time` and `DateTime` types.
- Understand the basics of `DateFormat`, both for parsing input and formatting output.
- Understand `Period` types, and their use in arithmetic.
- Understand that there are many other useful utility functions, available to people who ***read the manual***.

## Out of scope

- Times zones (beyond a brief mention of `TimeZones.jl`)
- Details of DateFormat syntax (students are firmly directed to the manual).

## Concepts

The Concepts this exercise unlocks are:

- `dates-times`
- We may add Time Zones later, but that needs a change to the test runner.

## Prerequisites

- `types`
