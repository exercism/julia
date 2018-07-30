# Given a DNA strand, its transcribed RNA strand is formed by replacing each nucleotide with its complement:
# G -> C, C -> G, T -> A, A -> U
function to_rna(dna::AbstractString)
    typeof(match(r"^[GCTA]+$", dna)) == Nothing && error("Invalid RNA strand")
    # Define character associations
    a_nucleotides = Dict('G'=>'C', 'C'=>'G', 'T'=>'A', 'A'=>'U')
    # Replace characters using dictionary
    map((x)->a_nucleotides[x], dna)
end
