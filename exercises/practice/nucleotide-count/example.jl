function count_nucleotides(strand::AbstractString)
    counter = Dict('A' => 0, 'C' => 0, 'G' => 0, 'T' => 0)
    for sym in strand
        sym in keys(counter) || throw(DomainError(sym, "only A, C, G and T are valid nucleotides"))
        counter[sym] += 1
    end
    return counter
end
