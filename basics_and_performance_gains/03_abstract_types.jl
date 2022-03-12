# Containers of abstract types are slower to iterate over.
# Real[] can contain Float32, Float64, or other types of rational numbers
# The variable "a" is thus implemented as an array of pointers.
# "b" is a raw array of Float64. Iteration & access is much faster.
# (This is similar to virtual functions being slower in C++)

a = Real[]
b = Float64[]

# Fill a and b with the same values
for i in 1:100000
    x = rand(Float64)
    push!(a, x)
    push!(b, x)
end

@timed sum(a) # running once so compilation of sum() does not distort relative time differences
@timed sum(b) # running once so compilation of sum() does not distort relative time differences

print("a: "); @time sum(a)
print("b: "); @time sum(b)
