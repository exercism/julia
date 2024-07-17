MATHEXPRESSION = r"-?\d+\.?\d* [-+*/] -?\d+\.?\d*"  #Regex which, for x,y ∈ R and op ∈ {+,-,/,*}, matches: "x op y" 
NUMBER = r"^-?\d+\.?\d*$"                           #Regex which matches a string consisting solely of a single n ∈ R
ENG2MATH = zip(("plus","minus","divided by","multiplied by","What is ","?"), ("+","-","/","*","",""))

function evalwordy(eq)
    expr = match(MATHEXPRESSION, eq)
    isnothing(expr) ? match(NUMBER, eq) : evalwordy(replace(eq, expr.match => (Base.eval ∘ Meta.parse)(expr.match), count=1))
end

function wordy(problem)
    foreach(op -> problem = replace(problem, first(op) => last(op)), ENG2MATH)
    answer = evalwordy(problem)
    isnothing(answer) ? throw(ArgumentError(problem)) : Meta.parse(answer.match)
end
