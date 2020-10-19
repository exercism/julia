#!/bin/bash

set -e

EXITCODE=0

function missing() {
    if test -f "$1"; then
        return 0
    else
        echo "file missing: $1"
        EXITCODE=1
    fi
}

for dir in exercises/*; do
    slug="$(basename $dir)"
    missing "./$dir/$slug.jl"
    missing "./$dir/$slug.ipynb"
    missing "./$dir/example.jl"
    missing "./$dir/runtests.jl"
done

exit $EXITCODE
