#! /bin/bash

# The problem-specifications directory shoud be adjacent to this project's root directory;
# otherwise you must provide its path as an argument to this script.
#
# For each generated slug listed below, this script downloads canonical-data.json and diffs
# the existing runtests.jl with a newly generated one. It does not modify existing files or
# add new files.

# Update as necessary.
slugs=(circular-buffer darts)

project_dir="$(dirname "$0")/../"

if (( $# > 0 )); then
    data_dir="$1/exercises/"
else
    data_dir="$project_dir/../problem-specifications/exercises/"
fi

if ! [[ -d $data_dir ]]; then
    echo "Error: $data_dir does not exist." >&2; exit 1
fi

echo 'Generating new runtests and diffing each with the existing runtests.jl.' >&2
count=0
for slug in ${slugs[@]}; do
    (( count += 1 ))
    echo "$slug" >&2
    < "$data_dir/$slug/canonical-data.json" \
        julia --project="$project_dir/generators/" "$project_dir/generators/$slug.jl" \
        | diff "$project_dir/exercises/$slug/runtests.jl" -

    if (( $? != 0 )); then
        echo "$slug: Generated runtests differs from existing runtests.jl." >&2
        exit 1
    fi
done

echo "All $count slugs checked and passed (no differences)." >&2
