# The data of a three dimensional vector is flattened into one dimension at the hardware level.
# Thus, for a 500^3 element cube, elements in the first row and first column of each page are 250,000 addresses apart.
# This is important to consider because there is a greater time penalty to access elements that are further apart in physical memory vs adjacent elements in physical memory. This is due to the architecture of RAM being contiguously addressable but not physically contiguous. The physical memory is broken into chunks and it is faster to make multiple reads on the same chunk.
# Each axis of the below data cube has the same depth, but the time to sum all elements along an axis greatly varies.

const depth = 500 # greater cube depth will exaggerate timing difference. Permuting a large will take much longer.

const data_cube = rand(Float64, (depth, depth, depth))
const permuted = zeros(Float64, (depth, depth, depth))

println(typeof(data_cube))

print("sum row: ")
@time sum(data_cube[:, 1, 1])
print("sum col: ")
@time sum(data_cube[1, :, 1])
print("sum pag: ")
@time sum(data_cube[1, 1, :]) # for a larger data cube the relative differences are MUCH greater

print("time to permute a 500x500x500 data cube: ")
@time permutedims!(permuted, data_cube, [3, 2, 1]) #in-place permutation not supported

println("original row sum equals permuted page sum: ", sum(data_cube[:, 1, 1]) == sum(permuted[1, 1, :]))
