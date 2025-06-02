# Instructions

In this exercise you'll be writing code to create name badges for factory employees. Employees have an ID, name, and department name. Employee badge labels are formatted as follows: `"[id] - name - DEPARTMENT"`.

## 1. Create a badge for an employee

Implement the `create_name_badge` function. It should take an ID, name, and a department. It should return the badge label, with the department name in uppercase.

```julia-repl
julia> create_name_badge(67, "Katherine Williams", "Strategic Communication")
"[67] - Katherine Williams - STRATEGIC COMMUNICATION"
```

## 2. Create a badge for a new employee

Due to a quirk in the computer system, new employees occasionally don't yet have an ID when they start working at the factory. As badges are required, they will receive a temporary badge without the ID prefix.

Extend the `create_name_badge` function. When the id is missing, it should create a badge without it.

```julia-repl
julia> create_name_badge(missing, "Robert Johnson", "Procurement")
"Robert Johnson - PROCUREMENT"
```

## 3. Create a badge for the owner

Even the factory's owner has to wear a badge at all times. However, an owner does not have a department and never will: he is above all the departments. In this case, the label should return `"OWNER"` instead of the department name.

Extend the `create_name_badge` function. When the department is `nothing`, assume the badge belongs to the company owner.

```julia-repl
julia> create_name_badge(204, "Rachel Miller", nothing)
"[204] - Rachel Miller - OWNER"
```

Note that it is possible for the owner to also be a new employee.

```julia-repl
julia> create_name_badge(missing, "Rachel Miller", nothing)
"Rachel Miller - OWNER"
```

## 4. Calculate the total salary of emplyees with no ID

As a rough metric of how well the IDs are being issued, you want to see the combined salary of employees with no ID. A high value means lots are waiting, or the problem is affecting senior people: both bad.

Implement the `salaries_no_id` function that takes a vector of IDs and a corresponding vector of salaries, and returns the sum of salaries for people with no ID yet. Both vectors are the same length.

```julia-repl
julia> ids = [204, missing, 210, 352, missing, 263]
julia> salaries  [23, 21, 47, 35, 17, 101] * 1000
julia> salaries_no_id(ids, salaries)
38,000
```
