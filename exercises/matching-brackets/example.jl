function matching_brackets(a)
	a = split(a, "")
	b,c = ["(", "[", "{"], [")", "]", "}"]
	a = filter(i -> (i in b || i in c), a)
	println("Your input: ", a, "\n")
	stack = Array{String}(undef, 0)
	global d, count, valid = Dict([("(", ")"),(")", "("), ("[", "]"), ("]", "["), ("{", "}"), ("}", "{")]), 0,1
	if length(a) % 2 != 0
		valid = 0
	else
		for i in a
			if i in b
				push!(stack, i)
				global count += 1
			elseif count == 0 # & downward: assumes i not in b
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
	if valid == 0 || count != 0
		return false
		# parantheses not balanced
	else
		return true
		# parantheses balanced
	end
end

a = readline()
matching_brackets(a)
