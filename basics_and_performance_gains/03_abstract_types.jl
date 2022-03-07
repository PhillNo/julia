# Containers of abstract types are slower
# Real[] can contain Float32, Float64, or other types of rational numbers
# The variable a is thus implemented as an array of pointers.
# b is a raw array of Float64. Iteration & access is much faster.
# (This is similar to virtual functions being slower in C++)

a = Real[]
b = Float64[]

# Fill a and b with the same values
for i in 1:1000
    x = rand(Float64)
    push!(a, x)
    push!(b, x)
end

@timed sum(b) # running once so compilation of sum() does not distort relative times
@timed sum(a) # running once so compilation of sum() does not distort relative times

print("a: "); @time sum(a)
print("\nb: "); @time sum(b)
