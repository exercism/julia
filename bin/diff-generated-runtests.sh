#! /bin/bash

# Run from top-level project directory.
#
# For each generated slug listed below, this script downloads canonical-data.json and diffs
# the existing runtests.jl with a newly generated one. It does not modify existing files or
# add new files.

# Update as necessary.
slugs=(circular-buffer darts)

if ! [[ -d exercises/ ]]; then
  echo "Error: ./exercises/ does not exist." >&2; exit 1
elif ! [[ -d generators/ ]]; then
  echo "Error: ./generators/ does not exist." >&2; exit 1
fi

echo 'Generating new runtests and checking each for differences with existing runtests.jl' >&2
count=0
for slug in ${slugs[@]}; do
  (( count += 1 ))
  echo "$slug" >&2
  url="https://raw.githubusercontent.com/exercism/problem-specifications/master/exercises/$slug/canonical-data.json"
  wget -q -O - "$url" \
    | JULIA_LOAD_PATH=:generators/GeneratorUtils/ julia --project=generators/ "generators/$slug.jl" \
    | diff "exercises/$slug/runtests.jl" -

  if (( $? != 0 )); then
    echo "$slug: Generated runtests differs from existing runtests.jl." >&2
    exit 1
  fi
done

echo "All $count slugs checked and passed (no differences)." >&2
