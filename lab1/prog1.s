        .arch armv8-a
//      res=((a+b)^2-(c-d)^2)/(a+e^3-c)
        .data
        .align  3
res:
        .skip   8
a:
        .short  -14
b:
        .short  1
c:
        .short  4
d:
        .short  2
e:
        .short  2
        .text
        .align  2
        .global _start
        .type   _start, %function
_start:
        // load operands
        adr     x0, a
        ldrsh   w1, [x0]
        adr     x0, b
        ldrsh   w2, [x0]
        adr     x0, c
        ldrsh   w3, [x0]
        adr     x0, d
        ldrsh   w4, [x0]
        adr     x0, e
        ldrsh   w5, [x0]

        // p3 = a + e^3 - c
        mul w10, w5, w5
        smull x8, w10, w5
        add x8, x8, w1, sxtw
        sub x8, x8, w3, sxtw

        // check exeptions
        cbz x8, _bad_exit

        // p1 = (a + b)^2
        add w6, w1, w2
        smull x9, w6, w6
