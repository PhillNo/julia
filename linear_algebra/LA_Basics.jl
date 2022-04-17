module LA_Basics

function det(A::Matrix{<:Number}) # Matrix{<:Number} is an alias for ::Array{<:Number, 2}
    ret::Float64 = 0
    if size(A, 1) == size(A,2)
        # No need for depth of 2 as base case; the recursion down to 1 is equivalent!
        if length(A) == 1
            return A[1]
        end

        top_row = A[1, :]
        for col_index in 1:length(top_row)
            A_s = A[2:end, 1:end .!= col_index] #elementwise not equal (compares to array of bool and removes where false). This is a computationally expensive line of code!
            ret += ((-1)^(col_index + 1)) * top_row[col_index] * det(A_s) # using -1^some power to get alternating +/-
        end

    else
        throw(ArgumentError("not square matrix"))
    end
    
    return ret
end

end