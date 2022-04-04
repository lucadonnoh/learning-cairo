%builtins output

from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.serialize import serialize_word

# Computes the product of the memory elements at even addresses:
#  arr + 0, arr + 2, ..., arr + (size - 1)
func array_even_prod(arr : felt*, size) -> (prod):
    if size == 0:
        return (prod=1)
    end

    # size is not zero.
    let (prod_of_rest) = array_even_prod(arr=arr + 2, size=size - 2)
    return (prod=[arr] * prod_of_rest)
end

func main{output_ptr : felt*}():
    const ARRAY_SIZE = 4

    # Allocate an array.
    let (ptr) = alloc()

    # Populate some values in the array.
    assert [ptr] = 3
    assert [ptr + 1] = 4
    assert [ptr + 2] = 5
    assert [ptr + 3] = 1

    # Call array_prod to compute the prod of even elements.
    let (prod) = array_even_prod(arr=ptr, size=ARRAY_SIZE)

    # Write the result to the output.
    serialize_word(prod)

    return ()
end
