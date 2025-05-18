demote(num) = 
    if typeof(num) == Float64  return ceil(UInt8, num)
    elseif num isa Integer     return convert(Int8, num)
    else                       return "MethodError: no method matching preprocess(::$(typeof(x)))"
end

preprocess(coll) =
    if coll isa Vector   return demote.(reverse(coll))
    elseif coll isa Set  return sort!(demote.(collect(coll)), rev=true)
    else                 return "MethodError: no method matching preprocess(::$(typeof(coll)))"
end
