demote(num) = 
    if typeof(num) == Float64  return ceil(UInt8, num)
    elseif num isa Integer     return convert(Int8, num)
    else                       throw(MethodError(demote, (num,)))
end

preprocess(coll) =
    if coll isa Vector   return demote.(reverse(coll))
    elseif coll isa Set  return sort!(demote.(collect(coll)), rev=true)
    else                 throw(MethodError(preprocess, (coll,)))
end
