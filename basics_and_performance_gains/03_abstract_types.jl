# Comparing iteration over an abstract container Real[] (which can hold Float32, Float64, etc. This is implemented as an array of pointer, versus a concrete container Float64[], which is implemented as a raw array.

a = Real[]
b = Float64[]

for i in 1:1000
    x = rand(Float64)
    push!(a, x)
    push!(b, x)
end

function sum_arg(x)
    s = 0.0
    for i in x
        s += i
    end
    return s
end;

@timed sum_arg(a) # running once so compilation doesnt distort relative times
@timed sum_arg(b) # running once so compilation doesnt distort relative times

print("a: ")
@time sum_arg(a)
print("\nb: ")
@time sum_arg(b)

println("\nBecause b is not an abstract type, it is not implemented as an array of pointers and runs much faster!")

