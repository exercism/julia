function print_name_badge(id, name, department)
    dept = isnothing(department) ? "OWNER" : uppercase(department)
    ismissing(id) ? "$name - $dept" : "[$(id)] - $name - $dept"
end

salaries_no_id(ids, salaries) = any(ismissing.(ids)) ?
    [salary for (id, salary) in zip(ids, salaries) if ismissing(id)] |> sum : 0
