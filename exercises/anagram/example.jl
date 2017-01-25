function is_anagram(s1::String, s2::String)
  # Anagrams are two or more words that composed of the same characters but in a different order
  s1 = lowercase(s1)
  s2 = lowercase(s2)
  if length(s1) != length(s2) || s1 == s2
    return false
  end
  chr_count = Dict()
  for c in s1
    chr_count[c] = get(chr_count, c, 0) + 1
  end
  for c in s2
    t = get(chr_count, c, 0) - 1
    if t < 0
      return false
    else
      chr_count[c] = t
    end
  end
  return all(i->(i==0), values(chr_count))
end

function detect_anagrams(subject::String, candidates::AbstractArray)
  result = []
  for candidate = candidates
    if is_anagram(subject, candidate)
      push!(result, candidate)
    end
  end
  result
end

