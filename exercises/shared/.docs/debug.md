# Debugging

To help with debugging, you can use the fact that all console output will be captured and shown in the test results window.
You can output any value by passing it to `@show`.

`@show` shows an expression and its result, while returning its result.

```julia
@show uppercase("hello") # HELLO will be shown as debug output
```

```julia
julia> function f(a, b)
           @show a b
           return (@show a^b) / 1000
       end
f (generic function with 1 method)

julia> f(3, 5)
a = 3
b = 5
a ^ b = 243
0.243
```

You can also use [`println`](https://docs.julialang.org/en/v1/base/io-network/#Base.println) or any other method that writes output to [`stdout`](https://en.wikipedia.org/wiki/Standard_streams#Standard_output_(stdout)).
