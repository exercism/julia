function onEarth(seconds::Integer)
    seconds / 31557600
end

function onMercury(seconds::Integer)
    onEarth(seconds) / 0.2408467
end

function onVenus(seconds::Integer)
    onEarth(seconds) / 0.61519726
end

function onMars(seconds::Integer)
    onEarth(seconds) / 1.8808158 
end

function onJupiter(seconds::Integer)
    onEarth(seconds) / 11.862615
end

function onSaturn(seconds::Integer)
    onEarth(seconds) / 29.447498
end

function onUranus(seconds::Integer)
    onEarth(seconds) / 84.016846
end

function onNeptune(seconds::Integer)
    onEarth(seconds) / 164.79132
end
