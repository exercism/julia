const TEST_BIG_INTEGERS = true

function isarmstrong(n)
    d = digits(typeof(n), n)
    sum(k^length(d) for k in d) == n
end
