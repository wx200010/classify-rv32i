.globl mul
.text
# =======================================================
# FUNCTION: Multiply two integers without using 'mul'
# Args:
#   a0: Multiplicand
#   a1: Multiplier
# Returns:
#   a0: Product result
# =======================================================
mul: 
    # Prolouge
    addi sp, sp, -8
    sw s0, 0(sp)
    sw s1, 4(sp)
    li s0, 0             # Product result = 0
mul_loop:
    beqz a1, mul_loop_end     # if a1 is 0, then the multiplication is done
    andi s1, a1, 1       # check the LSB of a1 
    beqz s1, mul_skip_add # if LSB is 0, then skip
    add s0, s0, a0       # Product result += a0
mul_skip_add:
    srli a1, a1, 1       # a1 >>= 1
    slli a0, a0, 1       # a0 <<= 1
    j mul_loop
mul_loop_end:
    # Epilouge
    mv a0, s0
    lw s0, 0(sp)
    lw s1, 4(sp)
    addi sp, sp, 8
    jr ra