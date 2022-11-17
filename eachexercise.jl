"""
    eachexercise(fn, test_only=[])

Call fn for each exercise in the exercises directory with (exercise_name,
exercise_type, exercise_path, example_path).

If test_only is not empty, only call fn for exercises whose slug is in
test_only.
"""
# Used by runtests.jl and runtestrunner.jl
function eachexercise(fn, test_only=[])
    for exercise_type in ("concept", "concept.wip", "practice")
        !isdir("exercises/$exercise_type") && continue
        for exercise in readdir(joinpath("exercises", exercise_type))
            # Allow only testing specified exercises
            if !isempty(test_only) && !(exercise in test_only)
                continue
            end

            exercise_path = joinpath("exercises", exercise_type, exercise)
            isdir(exercise_path) || continue

            # Concept exercises have an exemplar, practice exercises merely an example for CI purposes
            example_or_exemplar = startswith(exercise_type, "concept") ? "exemplar" : "example"
            example_path = abspath(joinpath(exercise_path, ".meta", "$example_or_exemplar.jl"))

            fn(exercise, basename(exercise_type), exercise_path, example_path)
        end
    end
end
