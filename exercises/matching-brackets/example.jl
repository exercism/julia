function matching_brackets(inputt)
    inputt = split(inputt, "")
    open_brackets,close_brackets = ["(", "[", "{"], [")", "]", "}"]
    inputt = filter(i -> (i in union(open_brackets, close_brackets)), inputt)
    stack = Array{String}(undef, 0)
    global d = Dict([("(", ")"),(")", "("), ("[", "]"), ("]", "["), ("{", "}"), ("}", "{")]) #global
    global count, valid = 0,1 #global 
    if length(inputt) % 2 != 0
        valid = 0
    else
        for i in inputt
            if i in open_brackets
                push!(stack, i)
                global count += 1 #global
            elseif count == 0 # & downward: assumes i not in open_brackets
                valid = 0
                break
            elseif stack[end] != d[i] #& downward: assumes count != 0
                valid = 0
                break
            else # assumes stack[end] == d[i]
                pop!(stack)
                count -= 1
            end
        end
    end
    (valid == 0 || count != 0) ? (return false) : (return true)
end
