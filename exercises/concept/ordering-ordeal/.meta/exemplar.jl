function sortquantity!(qty)
    srtperm = sortperm(qty, rev=true)
    sort!(qty, rev=true)
    srtperm
end

function sortcustomer(cust, srtperm)
    cust[srtperm]
end

function production_schedule(cust, qty)
    srtperm = sortquantity!(qty)
    sortcustomer(cust, srtperm), sortperm(srtperm)
end
