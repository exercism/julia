# Design

## Goal

The goal of this exercise is to teach the student the various forms of nothingness in Julia,.

## Learning objectives

- Know that `nothing` is for values that simply do not exist.
- Know that `missing` is a placeholder for values that "should" exist but are currently unknown.
- Know that `NaN` is a marker for invalid values when a number is expected.
- Kow that `Inf` and `-Inf` are valid values in Julia.
- Know that none of the above is an error, and computation will (by default) continue.
- Know that `undef` is an error state, from attempting to access a non-existent value.

## Out of scope

- Error handling, which is a later concept.

## Concepts

- `nothingness`

## Prerequisites

- `vector-operations`
