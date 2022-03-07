# The data of a three dimesnional matrix exists in one dimensional memory.
# Accessing elements "far away" from each other on the hardware can take longer than accessing two adjacent elements.
# The dimensions in the below abstract cube are the same, but time to elements along each dim varies greatly.

const data_cube = rand(Float64, (500, 500, 500))
const permuted = zeros(Float64, (500, 500, 500))

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
