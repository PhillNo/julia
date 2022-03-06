# Measuring time for functions to compile

const  x = rand(Float32, 1000)
global y = rand(1000) # global is usually used in a nested scope to refer to a var outside

println("type of x is constant. value may change but type does not. typeof(x): ", typeof(x))

println("y is not const. value and type of y can change. typeof(y): ", typeof(y))

# function loop_over_global()
#     s = 0.0
#     for i in x::Vector{Float64}
#         s += i
#     end
#     return s
# end
#
# loop_over_global()

function sum_arg(x)
    s = 0
    for (index, val) in enumerate(x) #not necessary to do it this way, but this can be convenient for loops
        s += val
    end
    return s
end

# @timed 2+2; #using time annotation for first time so it compiles

println()
println("summing values in y...")
@time sum_arg(y)

println()
println("summing values in y...")
@time sum_arg(y) # Second call is faster since the function has been compiled. So, don't take the first time too seriously.

println()
println("summing values in y...")
@time sum_arg(x) # because x is const (type is fixed) this is compiled before the script runs. Note there are not any allocations. @time did not need to perform allocations either.

println()
println("Making y a Vector{Int64} and summing values in y again...")
y = rand(Int64, 1000)
@time sum_arg(y)
