#= 
A 3-densional Vector of with a depth of 500 elements per dimension is 
addressed at lower levels in the machine with a 1-dimensional hardware
address.

So, when that cube is flattened into 1-dimensional logical addresses 
in memory, adjacent elements along the row of a page will have a 
stride of 1*sizeof(datatype) addresses apart.

The stride between adjacent element along the columns will be 
500*sizeof(data), and (500^2)*sizeof(data) for adjacent elements along
layers.

Because of how processors implement "virtual memory", addresses "far 
away" from each other will exist on different pages in virtual memory.

The virtual memory will then have to access those different pages, 
which means multiple lookups to find the hardware address an element
resides at.

The following demonstrates the time to sum elements along a row, column, and layer of a data cube.
=#

const depth = 10clear00 # greater cube depth will exaggerate timing difference. Permuting a large cube will take much longer.

# TODO: different behavior observed when using Float32 vs Float64
@time const data_cube = rand(Int64, (depth, depth, depth)) #since addings Ints is faster this won't dominate element access time as much

println(typeof(data_cube))

print("sum row: ")
@time sum(data_cube[:, 1, 1])
print("sum col: ")
@time sum(data_cube[1, :, 1])
print("sum layer: ")
@time sum(data_cube[1, 1, :]) # for a larger data cube the relative differences are more exaggerated

println("\nWhy is sum cols sometimes slower than sum layers? A 3-D vector may not be implmeneted as a contiguous chunk of memory with different stride length for accessing row, column, layer elements, as I had assumed. Instead, it might be an array of arrays. This still means accessing elements in the same row is quicker since they will usually be on the same page in virtual memory, but access time in the column or layer direction may be the same.\nSomething to note: Julia arrays are colum-major ordered whereas C++ arrays are row-major ordered.")

# ===========================
# Uncomment the below to see how long it takes to rotate the data cube (consider decreasing "depth" so you have enough memory)

# const permuted = zeros(Float64, (depth, depth, depth))
# print("time to permute a 500x500x500 data cube: ")
# @time permutedims!(permuted, data_cube, [3, 2, 1]) #in-place permutation not supported
#
# println("original row sum equals permuted page sum: ", sum(data_cube[:, 1, 1]) == sum(permuted[1, 1, :]))
