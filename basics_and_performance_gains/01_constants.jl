#=
To fix the data type of a variable in a global scope differs from a
local scope.

In local scope, specify the data type at variable declaration.

In global scope, use the const keyword. const and specification of data
type is redundant & not implemented anyway.

NOTE: If assigning a value of a different type to x in a nested scope,
like a try block, a copy is made and the copy takes precedence in the
nested scope.
=#

# ===========================
# const in local scope
function foo_const()
    # note the "const" keyword is not used here. 
    # "LoadError: syntax: unsupported `const` declaration on local variable"
    bar::Int32 = 1
    println(bar, " ", typeof(bar))
    bar = 2
    println(bar, " ", typeof(bar))
    println("Assigned a new value to bar of same type. What about assigning 2.5?")
    bar = 2.5
    println(bar, " ", typeof(bar))
end

# assign 2.5 to an Int32
try
    foo_const()
catch e
    println("error invoking foo_const() ", e)
end


# ===========================
# const in global scope
# note that the data type of x is not specified, but the data type is fixed
const x = rand(100)
println("x: ", typeof(x), "\n")

# assignments made to const IF the assigned value is same data type
println("reassigning to x a Vector of Float64...")
x = rand(Float64, 100)
println("x: ", typeof(x))
println("Successfully assigned new value to x.", "\n")


println("Attempting to assign a random Vector of Int32...")
try
    x = rand(Int32, 100)
    println("type of x in scope of try block: ", typeof(x))
catch e
    println("Failed to assign new array of Int32 to x. ", e, "\n")
end

println("global \"copy\" of x still exists. assignment was made to local copy. ", typeof(x), "\n")

println("attempting to assign new data type to x in scope where x was declared...")
x = rand(Int32, 100)
