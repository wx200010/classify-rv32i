.globl relu

.text
# ==============================================================================
# FUNCTION: Array ReLU Activation
#
# Applies ReLU (Rectified Linear Unit) operation in-place:
# For each element x in array: x = max(0, x)
#
# Arguments:
#   a0: Pointer to integer array to be modified
#   a1: Number of elements in array
#
# Returns:
#   None - Original array is modified directly
#
# Validation:
#   Requires non-empty array (length ≥ 1)
#   Terminates (code 36) if validation fails
#
# Example:
#   Input:  [-2, 0, 3, -1, 5]
#   Result: [ 0, 0, 3,  0, 5]
# ==============================================================================
relu:
    li t0, 1             
    blt a1, t0, error     
    li t1, 0             # i = 0
    mv t3, a0            # t3 is used to extract the element of array

loop_start:              # for(i = 0; i < a1, ++i)
    # TODO: Add your own implementation
    lw t2, 0(t3)         # Extract the value of current element
    bgez t2, continue    # If the value of element >= 0 , continue to next loop
    li t2, 0             # Replace the negative element with 0
    sw t2, 0(t3)         # Update the element

continue:
    addi t3, t3, 4       # Increase the array index
    addi t1, t1, 1       # Increase the loop counter
    bne t1, a1, loop_start # if loop counter > number of elements, then break.
    # li a0, 0
    ret
error:
    li a0, 36          
    j exit          
