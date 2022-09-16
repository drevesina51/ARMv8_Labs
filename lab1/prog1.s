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
 
         // p2 = (c - d)^2
         sub w7, w3, w4
         smull x10, w7, w7

         // p4 = p1 - p2
         sub x9, x9, x10

         // p5 =  p4 / p3
         sdiv x8, x9, x8

         // 0 + p5
         mov x20, #0
         add x8, x20, w8, sxtw

         // get result
         adr     x0, res
         str     x8, [x0]
         mov     x0, #0
         b _exit
         _bad_exit:
                 mov     x0, #1
         _exit:
                 mov x8, #93
                 svc     #0
         .size   _start, .-_start
