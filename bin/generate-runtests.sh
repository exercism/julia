#! /bin/bash

# The problem-specifications directory should be adjacent to this project's root directory;
# otherwise you must provide its path as an argument to this script.

# For each listed slug, generate tests using /generators/$slug.jl and put them in
# /exercises/$slug/runtests.jl
slugs=(circular-buffer darts)

project_dir="$(dirname "$0")/../"
exercises_dir="$project_dir/exercises/"

if (( $# > 0 )); then
    data_dir="$1/exercises/"
else
    data_dir="$project_dir/../problem-specifications/exercises/"
fi

if ! [[ -d $exercises_dir ]]; then
    echo "Error: $exercises_dir does not exist." >&2; exit 1
elif ! [[ -d $data_dir ]]; then
    echo "Error: $data_dir does not exist." >&2; exit 1
fi

echo 'Generating runtests.jl for the following exercises:' >&2
count=0
for slug in ${slugs[@]}; do
    (( count += 1 ))
    echo "$slug" >&2
    < "$data_dir/$slug/canonical-data.json" \
        julia --project="$project_dir/generators/" "$project_dir/generators/$slug.jl" \
        > "$project_dir/exercises/$slug/runtests.jl"
done

echo "$count runtests.jl generated." >&2
