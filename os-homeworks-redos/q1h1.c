#include <stdio.h>

int low;
 int high;
  int    main(int argc, char *argv[])
 {
      int *theSum;
int i;
 low=-10;
 high=+10;
        theSum=malloc(sizeof(int));
        *theSum=0;
       for (i=1;i<argc;i++) *theSum+=limit(low,high,argv[i]);
       printf("Sum is %d\n",*theSum);
 }
