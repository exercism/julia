function cleanupname(name)
    strip(replace(name, "-" => " "))
end

firstletter = string ∘ first ∘ cleanupname

function initial(name)
    name |> firstletter |> uppercase |> init-> *(init, ".")
end

function couple(name1, name2)
    "\u2764 $(initial(name1))  +  $(initial(name2)) \u2764"
end
