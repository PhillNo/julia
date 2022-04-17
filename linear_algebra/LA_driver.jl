import LinearAlgebra

include("/home/administrator/Documents/GitHub/julia/linear_algebra/LA_Basics.jl")

function main()
    A = rand(Float64, (10, 10))

    @time println(LinearAlgebra.det(A))
    @time println(LA_Basics.det(A))

    """
    why so slow?
    The Julia built-in det function uses the OpenBLAS library, a C++ implementation of the
    de facto standard APIs BLAS and LAPACK. These libraries have been around for a long time
    and certainly use a different, non-recursive algorithm.
    
    But Julia is compiled so it should be pretty quick?
    The larger matrix A becomes, the greater the time delta - the discrepancy is apparently not due to compile time.
    This code is recursive, which means it makes many copies of (parts of) A, and it has to allocate
    memory each time. This function could be implemented in a more direct way, without copying, and it would 
    be faster.
    
    What about the results having different values?
    The underlying library used by Julia's LinearAlgebra module, OpenBLAS, makes optimizations for different hardware 
    it runs on. Possibly the different accuracies is due to OpenBLAS using Intel extended precision (80-bit) 
    floating point numbers. (By the way, optimizations for speed can be another reason OpenBLAS is faster, since 
    it *might* be able to use Intel single-instruction-multiple-data (SIMD) hardware on Intel chips). There might 
    also be different roundoff error due to different algorithms adding values in different orders (it's always 
    more accurate for computers to sum numbers of ascending absolute value than unsorted)
    
    If you don't want to use the open source OpenBLAS library, you might want to use a library made by the people 
    who made your Intel CPU, the Intel Math Kernel Library (MKL). 
    
    Instructions to use it: https://github.com/JuliaLinearAlgebra/MKL.jl
    
    """
end


if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
