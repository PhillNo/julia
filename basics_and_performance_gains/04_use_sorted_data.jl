# Sorting arrays has at least two potential benefits:

# 1. When summing small floating point numbers, less roundoff is accumulated because the spacing between numbers that can be represented by floats on a machine is small for small numbers. i.e. for 0.00001 it is possible to add 0.00001 and get 0.00002. But for 1e100, adding 0.00001 may return 1e100. (This is may be an exaggeration, but the point is about the spacing between machine-representable numbers).

#Note: It might save time to use Kahan Summation and avoid sorting.

# 2. Branch prediction in a processor may be countereffective depending on what you are doing and sorting arrays can mitigate this.


# =================
# Array order and roundoff
function sum_l_h()
    s::Float32 = 0
    for i in 1000000:-1:1
        s += (1 / i)
    end
    return s
end

function sum_h_l()
    s::Float32 = 0
    for i in 1:1000000
        s += (1 / i)
    end
    return s
end

print("Summation low to high vs high to low: ")
print(sum_l_h(), " ")
println(sum_h_l(), "sums are not equal")


# =================
# Branch prediction
const r = rand(0.1:256.0, 1000000)

function sumabove_if(x)
    s = 0
    for i in x
        if i ≥ 128
            s += i
        end
    end
    s
end


@timed sumabove_if(r)

print("Unsorted: ")
@time sumabove_if(r)

r = sort(r)
print("Sorted: ")
@time sumabove_if(r)

