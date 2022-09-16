         .arch armv8-a
         //sorting rows of matrix by min elements
         .data
         .align 2
 n:
         .word 5
 m:
         .word 4
 matrix:
         .word 1, 3, 4, 5
         .word 0, -2, 14, 1
         .word 7, 7, 4, -20
         .word 3, 6, 4, 0
         .word 2, -10, -6, 1
 new_matrix:
         .skip 80
         //.skip 160
 index: //vector of indexes
         .skip 20
         //.skip 40
 mins:
         .skip 20
         //.skip 40
         .text
         .align 2
         .global _start
         .type _start, %function
 _start:
         adr x0, n
         ldr w0, [x0]
         adr x1, m
         ldr w1, [x1]
         adr x2, matrix
         adr x11, index
         adr x12, new_matrix
         adr x3, mins
         mov w4, #0 // row number
         mov w6, #0
         mov w13, #1
 L0:
         //find smallest elements in a row
         cmp w4, w0
         bge L3
         mov w5, #0 //column number
         ldr w7, [x2, x6, lsl #2]
  L1:
         add w5, w5, #1
         cmp w5, w1
         bge L2
         add w6, w6, #1
         ldr w8, [x2, x6, lsl #2]
         cmp w7, w8
         ble L1
         mov w7, w8 //x7- smallest element in row
         b L1
 L2:
         str w7, [x3, x4, lsl #2]
         str w4, [x11, x4, lsl #2] //index saving
         add w4, w4, #1
         add w6, w6, #1
         b L0 //smallest element in row is founded

 // shaker sort
 L3:
         mov w4, #0 //left index
         sub w5, w0, #1 //right index
         mov w6, #1 //flag
 L4:
         cbz w6, L20 //quit
         cmp w4, w5
         bge L20
         mov w6, #0
         mov w7, w4
 L5:
         cmp w7, w5
         bge L7
         ldr w8, [x3, x7, lsl #2] //current element
         add w10, w7, #1
         ldr w9, [x3, x10, lsl #2] //next element
         cmp w8, w9

 .ifndef REVERSE
         blt L6
 .else
         bgt L6
 .endif

          add w7, w7, #1
          b L5
   L6:
         //swap in vector of min elements
         str w8, [x3, x10, lsl #2]
         str w9, [x3, x7, lsl #2]
         //swap in vector of indexes
         ldr w9, [x11, x7, lsl #2]
         ldr w8, [x11, x10, lsl #2]
         str w8, [x11, x7, lsl #2]
         str w9, [x11, x10, lsl #2]
         mov w6, #1
         add w7, w7, #1
         b L5
 L7:
         sub w5, w5, #1
         mov w7, w5
         b L8
 L8:
         cmp w7, w4
         ble L10
         ldr w8, [x3, x7, lsl #2] //current element
         sub w10, w7, #1
         ldr w9, [x3, x10, lsl #2] //prev element
         cmp w8, w9

 .ifndef REVERSE
         bgt L9
 .else
         blt L9
 .endif

         sub w7, w7, #1
         b L8
 L9:
         //swap in vector of min elements
         str w8, [x3, x10, lsl #2]
         str w9, [x3, x7, lsl #2]
         //swap in vector of indexes
         ldr w9, [x11, x7, lsl #2]
         ldr w8, [x11, x10, lsl #2]
         str w8, [x11, x7, lsl #2]
         str w9, [x11, x10, lsl #2]
         mov w6, #1
         sub w7, w7, #1
         b L8
 L10:
         add w4, w4, #1
         b L4
 // making new matrix
 L20:
         mov w4, #0
 L21:
         cmp w4, w0
         bge L24
         mov w5, #0
         ldr w6, [x11, x4, lsl #2] //index of row in matrix
         mul w10, w4, w1
         add x7, x12, x10, lsl #2 //position of 1st row element in new_matrix
         mul w14, w6, w1
         add w8, w2, w14, lsl #2 //position of 1st row element in matrix
 L22:
         cmp w5, w1
         bge L23
         ldr x9, [x8]
         str x9, [x7]
         add w7, w7, w13, lsl #2
         add w8, w8, w13, lsl #2
         add w5, w5, #1
         b L22
 L23:
         add w4, w4, #1
         b L21
 L24:
         mov x0, #0
         mov x8, #93
         svc #0
         .size _start, .-_start
