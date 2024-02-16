function perceptron(points, labels)
    θ, pnts = [0, 0, 0], vcat.(1, points)
    while true
        θ_0 = θ
        foreach(i -> labels[i]*θ'*pnts[i] ≤ 0 && (θ += labels[i]*pnts[i]), eachindex(pnts))
        θ_0 == θ && return θ
    end
end
