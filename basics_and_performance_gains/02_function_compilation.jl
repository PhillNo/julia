# Measuring time for functions to compile
# Because of multiple dispatch, compilation happens for each invocation using new arg types.

const  x = rand(Float32, 1000)
global y = rand(1000) # global is usually used in a nested scope to refer to a var outside

println("type of x is constant. value may change but type does not. typeof(x): ", typeof(x))
println("y is not const. value and type of y can change. typeof(y): ", typeof(y))

function sum_arg(x)
    s = 0

    #not necessary to enumerate, but this can be convenient in other cases. enumerate a decorator coroutine
    for (index, val) in enumerate(x)
        s += val
    end

    return s
end

println("\nsumming values in y...")
@time sum_arg(y) # according to docs, @time needs to compile as well, but that is not included in this measurement

println("\nsumming values in y...")
@time sum_arg(y) # Second call is faster since the function has been compiled. Insignificant compile time in this case

println("\nsumming values in y...")
@time sum_arg(x) # x is a different data type BUT because the type is fixed this was compiled ahead of runtime

println("\nMaking y a Vector{Int64} and summing values in y again...")
y = rand(Int64, 1000)
@time sum_arg(y)
