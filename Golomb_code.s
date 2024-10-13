.data
argument1:    .word 1
argument2:    .word 5
argument3:    .word 8
text1:        .string "The Golomb code of "
text2:        .string " is "
endl:         .string "\n"

.text
main:
    la   s0, argument1    # store data address to s0
    li   s3, 3            # amount of test data
    
golomb_1:
    lw   s1, 0(s0)          # store test data to s1
    addi s2, s1, 1
    addi t1, zero, 31       # i for clz
    addi t2, zero, 1        # 1U for clz
    addi t4, zero, 0        # counter for clz
    
clz_loop:
    sll  t3, t2, t1         # mask
    addi t1, t1, -1         # i -= 1
    and  t3, s2, t3         # using mask
    bnez t3, golomb_2
    addi t4, t4, 1          # counter += 1
    bge  t1, zero, clz_loop

golomb_2:
    sub  t4, zero, t4
    addi t4, t4, 31         # (32 - clz(x)) - 1
    mv   t5, t4
    
print:
    la   a0, text1          # print "The Golomb code of "
    li   a7, 4
    ecall
    
    mv   a0, s1             # print test data
    li   a7, 1
    ecall
    
    la   a0, text2          # print " is "
    li   a7, 4
    ecall
    li   a7, 1              # for print_prefix
    mv   a0, zero           # for print "0"
    
print_prefix:
    ecall
    addi t4, t4, -1
    bgt  t4, zero, print_prefix
    
print_suffix:               
    srl  t3, s2, t5         # mask
    andi a0, t3, 1          # using mask
    ecall
    addi t5, t5, -1
    bge  t5, zero, print_suffix
    
    la   a0, endl
    li   a7, 4
    ecall

    addi s0, s0, 4          # select next test data
    addi s3, s3, -1         # num of remainding test data
    bne  s3, zero, golomb_1
    
    li   a7, 10             # termination
    ecall
