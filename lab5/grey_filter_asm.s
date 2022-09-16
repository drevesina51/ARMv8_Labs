    .arch   armv8-a
    .data
    .text
    .align  2
    .global grey_filter_asm
    .type   grey_filter_asm, %function
grey_filter_asm:
    stp     x29, x30, [sp, #-16]!

    //x0 - old img
    //x1 - new img
    //x2 - size
    //x4 - SIZE

    add     x4, x0, x2
0:
    cmp     x0, x4
    beq     end
    ldrb    w5, [x0]
    mov     x6, #0
search_max:
    cmp     x6, #3
    beq     min
    ldrb    w7, [x0, x6]
    add     x6, x6, #1
    cmp     x5, x7
    ble     search_max
    mov     x5, x7
    b       search_max
min:
    ldrb    w15, [x0]
    mov     x16, #0
search_min:
    cmp     x16, #3
    beq     average
    ldrb    w17, [x0, x16]
    add     x16, x16, #1
    cmp     x15, x17
    ble     search_min
    mov     x15, x17
    b       search_min
average:
        mov w9, #2 
        add w5, w5, w15
        sdiv w5, w5, w9
1:
    strb    w5, [x1]
    add     x0, x0, #3
    add     x1, x1, #1
    b       0b
end:
    ldp     x29, x30, [sp], #16
    mov     x0, #0
    ret
    .size   grey_filter_asm, .-grey_filter_asm
