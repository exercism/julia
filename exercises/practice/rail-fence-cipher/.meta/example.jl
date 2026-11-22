encode(msg, rails) = msg[zigzag(msg, rails)]
decode(msg, rails) = msg[invperm(zigzag(msg, rails))]

zigzag(msg, rails) = sortperm(collect(Iterators.take(Iterators.cycle([1:rails; (rails-1):-1:2]), length(msg))))
