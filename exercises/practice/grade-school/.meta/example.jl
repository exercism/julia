# The new_school() function must return something that can be used in
# all the other functions.
# Programmers are free to choose a suitable implementation.

new_school() = []

function add!(students, school)
    results = []
    for student in students
        if student.name ∈ roster(school)
            push!(results, false)
        else
            push!(school, student)
            push!(results, true)
        end
    end
    results
end

grade(num, school) = [s.name for s in school if s.grade == num] |> sort

function roster(school)
    grades = [s.grade for s in school] |> unique |> sort
    [grade(g, school) for g in grades] |> Iterators.flatten |> collect
end
