"""
    badge(id, name, department)

Return the employee badge label.
"""
function badge(id, name, department)
    department = isnothing(department) ? "owner" : department
    prefix = isnothing(id) ? "" : "[$id] - "

    prefix * "$name - $(uppercase(department))"
end
