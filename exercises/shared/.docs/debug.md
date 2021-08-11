# Debugging

To help with debugging, you can use the fact that all console output will be captured and shown in the test results window.
You can output any value by passing it to `@show`.

`@show` shows an expression and its result, while returning its result.

```julia
julia> @show uppercase("hello")
uppercase("hello") = "HELLO"
"HELLO"
```

You can also use [`println`](https://docs.julialang.org/en/v1/base/io-network/#Base.println) or any other method that writes output to [`stdout`](https://en.wikipedia.org/wiki/Standard_streams#Standard_output_(stdout)).
