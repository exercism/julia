function scores(a::AbstractArray; latest = false, top=0)
    if top > 0
        top > length(a) ? (return reverse(sort(a))) : nothing
        if top == 1
            return sort(a)[end]
        end
        return reverse(sort(a)[end-top+1:end])
    end

    latest ? (return a[end]) : return a
end
