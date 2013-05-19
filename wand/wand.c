//  LED Wand by Mike Cook July 2012
//
//  How to write words in the air with an LED wand on the Raspberry-Pi
//  Example program


// Access from ARM Running Linux

#define BCM2708_PERI_BASE        0x20000000
#define GPIO_BASE                (BCM2708_PERI_BASE + 0x200000) /* GPIO controller */
#define TIMER_BASE               (BCM2708_PERI_BASE + 0x00B000) /* TIMER ARM controller */


#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <dirent.h>
#include <fcntl.h>
#include <assert.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>

#include <unistd.h>
#include "font.h"   // font definitions
#include "Matrix_graphics.h" // graphic 8 x 8 blocks

// for access to GPIO and free running timer
#define PAGE_SIZE (4*1024)
#define BLOCK_SIZE (4*1024)
// GPIO setup macros. Always use INP_GPIO(x) before using OUT_GPIO(x) or SET_GPIO_ALT(x,y)
#define INP_GPIO(g) *(gpio+((g)/10)) &= ~(7<<(((g)%10)*3))
#define OUT_GPIO(g) *(gpio+((g)/10)) |=  (1<<(((g)%10)*3))
#define SET_GPIO_ALT(g,a) *(gpio+(((g)/10))) |= (((a)<=3?(a)+4:(a)==4?3:2)<<(((g)%10)*3))

#define GPIO_SET *(gpio+7)  // sets   bits which are 1 ignores bits which are 0
#define GPIO_CLR *(gpio+10) // clears bits which are 1 ignores bits which are 0
#define GPIO_GET *(gpio+13) // get the logic level register for GPIO
// I/O access
volatile unsigned *gpio, *timer;
int  mem_fd, mem_tmr;
char *gpio_mem, *gpio_map;
char *spi0_mem, *spi0_map;
char *timer_mem, *timer_map;

// Our program global variables
// mapping of output pins to LEDs
char pins[] = { 14, 15, 18, 24, 25, 7, 23, 8 };
const int used_bits = 0x384C180; // bit mask for the bits used to drive the LEDs
int display_length = 0; // length of message in characters
int buffer_length = 0; // length of used part of the display buffer 
int display_buffer[32*6]; // buffer for LED bit image

// *** Define the message comment out all but one of these methods
//char message[] = "Raspberry Pi"; // text only message
//char message[] = {'P','a','c',' ','M','a','n',' ',143,' ', 141}; // mixed text and graphics
//char message[] = {'G','u','n',' ',145,' ',146};
char message[] = "Magic Wand on the Pi";

// ***Function pre declarations ***
void setup_io_file();
void setup_timer_file();
void delay_uS(int period);
void run1();
void setUpBuffer();
int spread(int pattern);
int ascii2font(int ascii);

/* **************** MAIN *******************/
int main(int argc, char **argv){
 int i, sensor, last_sensor;
 setup_timer_file();
 setup_io_file();

// stet up control register 0x408- free running enabled
 *(timer+(0x408>>2)) = 0xF90200; // run at 1MHz

// define direction switch as input
INP_GPIO(0);

// define LED bits as outputs
for(i=0; i<8; i++){
 INP_GPIO(pins[i]);
 OUT_GPIO(pins[i]);
 GPIO_CLR = 1<<pins[i];
}
 setUpBuffer(); // transfet the message into bits to display
 sensor = GPIO_GET & 1; // get sensor switch
 last_sensor = sensor;

// Do the wand actions
 for( ; ; ){ // repeat forever
 sensor = GPIO_GET & 1; // read the direction switch
 if( (sensor != last_sensor) && sensor == 1 ){ // change sensor == 0 for other stroke
   delay_uS(80000); // the delay after switch to allows wand to come up to speed again
   run1();  // display one run of the buffer
  }
   last_sensor = sensor;
 }
 return 0;
} 
/* **************** END of MAIN *******************/


// *** Other functions ***
void setUpBuffer(){
int j, currentChar=0;
  display_length = strlen(message);
  while(message[currentChar] != 0){ // for each letter in message
 if(message[currentChar] >=0x80) { // if it is a graphics character
 // enter as a graphics block
  for(j=0; j<8; j++) { // for each column
   display_buffer[buffer_length] = spread(graphics[message[currentChar]-0x80][j]);
   buffer_length++; // move to next entry in the buffer
   }
 } else {
 // enter text character
   for(j=0; j<6; j++) { // for each column
     display_buffer[buffer_length] = spread(matrixFont[ascii2font(message[currentChar])][j]);  // build up bit pattern
     buffer_length++; // move to next entry in the buffer
    }
  }
  currentChar ++;
 }
  display_buffer[buffer_length] = 0; // blank out last entry
}


int spread(int pattern) { // spreads the bits to display positions
 int display = 0, i;
  for(i=0; i<8; i++){
   if( (pattern & (1<< i)) != 0 ) display |= 1 << pins[i];
 }
  return display;
}


int ascii2font(int ascii){ // convert ASCII into character font number
 if(ascii > 0x60) ascii -= 0x26; else ascii -= 0x20;
return ascii;
}


void run1(){ // display the buffer
int i;
  for(i=0; i<buffer_length; i++){
     GPIO_SET = display_buffer[i]; // display next column of LEDs
     delay_uS(500); // sets the width of each character 
     GPIO_CLR = used_bits; // blank out all LEDs
  } 
}


void delay_uS(int period){ // delay using the free running counter
unsigned count_at_start, current_count;
 count_at_start =  *(timer+(0x420>>2)); // the value of free running counter
 current_count = count_at_start; 
 while( (current_count - count_at_start) < (unsigned)period ) { 
    current_count = *(timer+(0x420>>2));
    } // hold until the time is up
}


// Set up a memory region to access GPIO
// Standard GPIO stuff
void setup_io_file()
{

   /* open /dev/mem */
   if ((mem_fd = open("/dev/mem", O_RDWR|O_SYNC) ) < 0) {
      printf("can't open /dev/mem \n");
      exit (-1);
   }

   /* mmap GPIO */

   // Allocate MAP block
   if ((gpio_mem = malloc(BLOCK_SIZE + (PAGE_SIZE-1))) == NULL) {
      printf("allocation error \n");
      exit (-1);
   }

   // Make sure pointer is on 4K boundary
   if ((unsigned long)gpio_mem % PAGE_SIZE)
     gpio_mem += PAGE_SIZE - ((unsigned long)gpio_mem % PAGE_SIZE);

   // Now map it
  // gpio_map = (unsigned char *)mmap(
   gpio_map = ( char *)mmap(
      (caddr_t)gpio_mem,
      BLOCK_SIZE,
      PROT_READ|PROT_WRITE,
      MAP_SHARED|MAP_FIXED,
      mem_fd,
      GPIO_BASE
   );

   if ((long)gpio_map < 0) {
      printf("mmap error GPIO %d\n", (int)gpio_map);
      exit (-1);
   }

   // Always use volatile pointer!
   gpio = (volatile unsigned *)gpio_map;
} // setup_io end


// Access to the ARM timer
void setup_timer_file(){
   /* open /dev/mem */
   if ((mem_tmr = open("/dev/mem", O_RDWR|O_SYNC) ) < 0) {
      printf("can't open /dev/mem \n");
      exit (-1);
   }

   /* mmap TIMER */

   // Allocate MAP block
   if ((timer_mem = malloc(BLOCK_SIZE + (PAGE_SIZE-1))) == NULL) {
      printf("allocation error \n");
      exit (-1);
   }

   // Make sure pointer is on 4K boundary
   if ((unsigned long)timer_mem % PAGE_SIZE)
     timer_mem += PAGE_SIZE - ((unsigned long)timer_mem % PAGE_SIZE);

   // Now map it
   timer_map = ( char *)mmap(
      (caddr_t)timer_mem,
      BLOCK_SIZE,
      PROT_READ|PROT_WRITE,
      MAP_SHARED|MAP_FIXED,
      mem_tmr,
      TIMER_BASE
   );

   if ((long)timer_map < 0) {
      printf("mmap error timer %d\n", (int)timer_map);
      exit (-1);
   }

   // Always use volatile pointer!
   timer = (volatile unsigned *)timer_map;
} // setup_timer end
