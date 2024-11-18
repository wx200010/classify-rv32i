# Assignment 2: Classify

## Part A: Mathematical Functions

### Task 1: ReLU
The relu function applies the ReLU transformation to an input array. **ReLU replaces each negative element in the array with zero while keeping non-negative elements unchanged**. The operation is performed in-place, meaning the input array is directly modified.

I implemented ReLU using a loop that iterates through the array. If an element is negative, it is replaced with 0

Here is the corresponding assembly code implementation:
```s 
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
```

### Task 2: ArgMax
The argmax function finds the index of the largest element in a given 1D array (vector). If multiple elements share the largest value, it returns the smallest index among them.

**I use a loop to iterate through the array, comparing each element to the current maximum value.** If an element is larger, I update the maximum value. Otherwise, I simply move to the next element. This process continues until the entire array has been checked.

The maximum is initialized with the first element, so the loop starts at position 1 instead of 0.

Here is the corresponding assembly code implementation:
```s
argmax:
    .......
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
........
```


### Task 3.1: Dot Product 
The dot function computes the dot product of two arrays. The dot product is calculated as the sum of the element-wise products of two vectors.
In my implementation, I use Egyptian Multiplication to calculate A[i] * B[i], 

Although I already have a separate `mul.s` for the multiplication part, I encountered a **CC violation** issue when using it in dot.s, which I have not yet resolved. As a temporary solution, I inlined the mul function directly within dot.s and adjusted the register parameters to eliminate the additional overhead caused by prologue and epilogue in each function call.

Here is the corresponding assembly code implementation:
```s
.......
    slli a3, a3, 2      # Because an element is 4bytes, i update the stripes to 4 * stripes
    slli a4, a4, 2      # Because an element is 4bytes, i update the stripes to 4 * stripes

    li t0, 0            # t0 is dot sum
    li t1, 0            # t1 is i
loop_start:
    # TODO: Add your own implementation
    lw t2, 0(a0)        # extract current arr0 element to t2
    lw t3, 0(a1)        # extract current arr1 element to t3
    # calculate t2 * t3
    li t4, 0            # set mul_sum = 0
    mul_loop:
        beqz t3, mul_end     # if t3 is 0, then the multiplication is done
        andi t5, t3, 1       # check the LSB of t3 
        beqz t5, mul_skip_add # if LSB is 0, then skip
        add t4, t4, t2       # mul_sum += t2
    mul_skip_add:
        srli t3, t3, 1       # t3 >>= 1
        slli t2, t2, 1       # t2 <<= 1
        j mul_loop
    mul_end:
    add t0, t0, t4
    add a0, a0, a3      # move to next arr0 element
    add a1, a1, a4      # move to next arr1 element
    addi t1, t1, 1
    blt t1, a2, loop_start
```

### Task 3.2: Matrix Multiplication

## Part B: File Operations and Main

### Task 1: Read Matrix

### Task 2: Write Matrix

### Task 3: Classification

## Result
execute `bash ./test.sh all`
```bash
PS D:\classify-rv32i> bash ./test.sh all
test_abs_minus_one (__main__.TestAbs.test_abs_minus_one) ... ok
test_abs_one (__main__.TestAbs.test_abs_one) ... ok
test_abs_zero (__main__.TestAbs.test_abs_zero) ... ok
test_argmax_invalid_n (__main__.TestArgmax.test_argmax_invalid_n) ... ok
test_argmax_length_1 (__main__.TestArgmax.test_argmax_length_1) ... ok
test_argmax_standard (__main__.TestArgmax.test_argmax_standard) ... ok
test_chain_1 (__main__.TestChain.test_chain_1) ... ok
test_classify_1_silent (__main__.TestClassify.test_classify_1_silent) ... ok
test_classify_2_print (__main__.TestClassify.test_classify_2_print) ... ok
test_classify_3_print (__main__.TestClassify.test_classify_3_print) ... ok
test_classify_fail_malloc (__main__.TestClassify.test_classify_fail_malloc) ... ok
test_classify_not_enough_args (__main__.TestClassify.test_classify_not_enough_args) ... ok
test_dot_length_1 (__main__.TestDot.test_dot_length_1) ... ok
test_dot_length_error (__main__.TestDot.test_dot_length_error) ... ok
test_dot_length_error2 (__main__.TestDot.test_dot_length_error2) ... ok
test_dot_standard (__main__.TestDot.test_dot_standard) ... ok
test_dot_stride (__main__.TestDot.test_dot_stride) ... ok
test_dot_stride_error1 (__main__.TestDot.test_dot_stride_error1) ... ok
test_dot_stride_error2 (__main__.TestDot.test_dot_stride_error2) ... ok
test_matmul_incorrect_check (__main__.TestMatmul.test_matmul_incorrect_check) ... ok
test_matmul_length_1 (__main__.TestMatmul.test_matmul_length_1) ... ok
test_matmul_negative_dim_m0_x (__main__.TestMatmul.test_matmul_negative_dim_m0_x) ... ok
test_matmul_negative_dim_m0_y (__main__.TestMatmul.test_matmul_negative_dim_m0_y) ... ok
test_matmul_negative_dim_m1_x (__main__.TestMatmul.test_matmul_negative_dim_m1_x) ... ok
test_matmul_negative_dim_m1_y (__main__.TestMatmul.test_matmul_negative_dim_m1_y) ... ok
test_matmul_nonsquare_1 (__main__.TestMatmul.test_matmul_nonsquare_1) ... ok
test_matmul_nonsquare_2 (__main__.TestMatmul.test_matmul_nonsquare_2) ... ok
test_matmul_nonsquare_outer_dims (__main__.TestMatmul.test_matmul_nonsquare_outer_dims) ... ok
test_matmul_square (__main__.TestMatmul.test_matmul_square) ... ok
test_matmul_unmatched_dims (__main__.TestMatmul.test_matmul_unmatched_dims) ... ok
test_matmul_zero_dim_m0 (__main__.TestMatmul.test_matmul_zero_dim_m0) ... ok
test_matmul_zero_dim_m1 (__main__.TestMatmul.test_matmul_zero_dim_m1) ... ok
test_read_1 (__main__.TestReadMatrix.test_read_1) ... ok
test_read_2 (__main__.TestReadMatrix.test_read_2) ... ok
test_read_3 (__main__.TestReadMatrix.test_read_3) ... ok
test_read_fail_fclose (__main__.TestReadMatrix.test_read_fail_fclose) ... ok
test_read_fail_fopen (__main__.TestReadMatrix.test_read_fail_fopen) ... ok
test_read_fail_fread (__main__.TestReadMatrix.test_read_fail_fread) ... ok
test_read_fail_malloc (__main__.TestReadMatrix.test_read_fail_malloc) ... ok
test_relu_invalid_n (__main__.TestRelu.test_relu_invalid_n) ... ok
test_relu_length_1 (__main__.TestRelu.test_relu_length_1) ... ok
test_relu_standard (__main__.TestRelu.test_relu_standard) ... ok
test_write_1 (__main__.TestWriteMatrix.test_write_1) ... ok
test_write_fail_fclose (__main__.TestWriteMatrix.test_write_fail_fclose) ... ok
test_write_fail_fopen (__main__.TestWriteMatrix.test_write_fail_fopen) ... ok
test_write_fail_fwrite (__main__.TestWriteMatrix.test_write_fail_fwrite) ... ok

----------------------------------------------------------------------
Ran 46 tests in 39.653s
```
