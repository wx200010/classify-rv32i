.globl argmax

.text
# =================================================================
# FUNCTION: Maximum Element First Index Finder
#
# Scans an integer array to find its maximum value and returns the
# position of its first occurrence. In cases where multiple elements
# share the maximum value, returns the smallest index.
#
# Arguments:
#   a0 (int *): Pointer to the first element of the array
#   a1 (int):  Number of elements in the array
#
# Returns:
#   a0 (int):  Position of the first maximum element (0-based index)
#
# Preconditions:
#   - Array must contain at least one element
#
# Error Cases:
#   - Terminates program with exit code 36 if array length < 1
# =================================================================
argmax:
    li t6, 1
    blt a1, t6, handle_error

    lw t0, 0(a0)        # t0 is the maximum value (initial as first element)
    addi t2, a0, 4      # t2 is index , which is used to extract the element from array  (arr[index])
    li a0, 0            # a0 is the position of maximum value (initial as first position)
    beq a1, t3, final   # if len(arr) == 1, then it is done, go to return

    li t3, 1            # t3 is the loop counter  (i = 1)
loop_start:     
    # TODO: Add your own implementation
    lw t4, 0(t2)            # tmp = arr[index]
    ble t4, t0, loop_check  # If arr[index] <= max, continue to next loop
    mv a0, t3               # Update the position of maximum
    mv t0, t4               # Update the value of maximum
loop_check:
    addi t3, t3, 1          # i++
    addi t2, t2, 4          # index++ (to extract the next element)
    bne t3, a1, loop_start  # Loop when i != len(arr)
final:
    ret
handle_error:
    li a0, 36
    j exit
