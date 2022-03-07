# Sorting arrays has at least two potential benefits:

# 1. To avoid accumulation of roundoff error it is best to take the summation of a set by adding smallest to largest.
#    This is because the possible numbers representable by a machine using floating pointgrows apart exponentially.
#    The spacing between all adjacent integers is 1.

#Note: It might save time to avoid sorting by using Kahan summation.

# 2. Branch prediction can be counterproductive on an unsorted array.
#    When using a loop to iterate an array, a branch check in the loop will assume to be true if the condition was true
#    many times prior. Sorting assures such a prediciton is correct and the processor doesn't not have to walk back.


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

println("Summation low to high vs high to low: ", sum_l_h(), " vs ", sum_h_l(), ". Sums should be equal")


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

print("\nTime to run sumabove on unsorted input: ")
@time sumabove_if(r)

r = sort(r)
print("Time to run sumabove on sorted input: ")
@time sumabove_if(r)
