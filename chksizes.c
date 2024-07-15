/*
  https://usrmisc.wordpress.com/2012/12/27/integer-sizes-in-c-on-32-bit-and-64-bit-linux/
*/

#include <inttypes.h>
#include <stdio.h>
#include <stdint.h>

int main() {
  printf( "    short int: %zd\n" , sizeof(short int) ) ;
  printf( "          int: %zd\n" , sizeof(int) ) ;
  printf( "     long int: %zd\n", sizeof(long int) ) ;
  printf( "long long int: %zd\n", sizeof(long long int) ) ;
  printf( "       size_t: %zd\n", sizeof(size_t) ) ;
  printf( "        void*: %zd\n", sizeof(void *) ) ;
  printf( "     intptr_t: %zd\n\n", sizeof(intptr_t) ) ;


  printf( "PRIu32 usage (see source): %"PRIu32"\n" , (uint32_t) 42 ) ;
  return 0;
}
