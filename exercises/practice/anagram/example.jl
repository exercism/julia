# Anagrams are two or more words that composed of the same characters but in a different order

function is_anagram(s1::AbstractString, s2::AbstractString)
    # Disable case sensitivity
    s1 = lowercase(s1)
    s2 = lowercase(s2)

    # Similar and different-length strings are not anagrams
    if length(s1) != length(s2) || s1 == s2
        return false
    end

    # Calculate count of every character in the first string
    chr_count = Dict()
    for c in s1
        chr_count[c] = get(chr_count, c, 0) + 1
    end

    # Reduce the count by every character from the second string
    for c in s2
        t = get(chr_count, c, 0) - 1
        if t < 0
            # Got character that not exist in the first string
            return false
        else
            chr_count[c] = t
        end
    end

    # Check all counts to be zeroes
    return all(i->(i==0), values(chr_count))
end

function detect_anagrams(subject::AbstractString, candidates::AbstractArray)
    result = []
    for candidate = candidates
        if is_anagram(subject, candidate)
            push!(result, candidate)
        end
    end
    result
end
