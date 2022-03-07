# The data of a three dimensional is addressed in hardware using one dimension.
# For a 500^3 element cube, the elements in the first row and first column of each page are 250000 addresses apart.
# Hardware is divided into segments and there is a greater time penalty for accessing addresses on different segment than elements on the same segment.
# Each axis of the below data cube has the same depth, but the time to sum all of the elements along an axis varies due to the hardware implementation.

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
