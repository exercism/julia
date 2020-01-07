function scores(a::AbstractArray; latest = false, sorted=false, top=0)
    if top > 0
        top > length(a) ? sorted ? (return sort(a)) : (return reverse(sort(a))) : nothing
        if top == 1
            return sort(a)[length(a)]
        end
        if sorted
            return (sort(a)[length(a)-top+1:length(a)])
        else
            return reverse(sort(a)[length(a)-top+1:length(a)])
        end
    end

    latest ? (return a[length(a)]) : return a
end
