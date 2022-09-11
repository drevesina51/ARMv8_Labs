 #include "grey_filter.h"

 int grey_filter(unsigned char *img, unsigned char *res_img, int size)
 {
     unsigned char *pg = res_img;
     for (unsigned char *p = img; p < img + size; p += 3)
     {
         unsigned char t = *p;
         for (int i = 1; i < 3; ++i)
         {
             if (t > *(p + i))
             {
                 t = *(p + i);
             }
         }
         *pg = (int) (t);
         ++pg;
     }
     return 0;
 }
