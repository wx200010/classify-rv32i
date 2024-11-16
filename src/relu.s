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
    lw t2, 0(t3)         # tmp = Input[i]
    bgez t2, continue    # if Input[i] >= 0 , just skip
    li t2, 0
    sw t2, 0(t3)

continue:
    addi t3, t3, 1       # the array index ++
    addi t1, t1, 1       # i++
    bne t1, a1, loop_start     
    li a0, 0
    j exit
    # TODO: Add your own implementation
error:
    li a0, 36          
    j exit          
