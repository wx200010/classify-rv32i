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

### Task 3.2: Matrix Multiplication

## Part B: File Operations and Main

### Task 1: Read Matrix

### Task 2: Write Matrix

### Task 3: Classification

## Result
execute `bash ./test.sh all`
