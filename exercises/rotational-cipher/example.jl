function rotate(n::Int, c::Char)
    if c in 'a':'z'
        c = 'a' + (c - 'a' + n) % 26
    elseif c in 'A':'Z'
        c = 'A' + (c - 'A' + n) % 26
    end
    return c
end

rotate(n::Int, s::String) = join(rotate(n, c) for c in s)

for n in 0:26
    # current_module() is necessary due to constraints of runtests.jl
    # This is not required for the user solving the exercise
    eval(current_module(), :(macro $(Symbol(:R, n, :_str))(s::String)
        :(rotate($$n, $s))
    end))
end
