#include "registers.h"

int main(void) {
  /* enable clock access for GPIOA */
  RCC_AHB1EN_R |= GPIOAEN;
  
  /* configure PA5 to general-purpose output mode */
  GPIOA_MODE_R |= (1U << 10); /* set bit 10 to 1 */
  GPIOA_MODE_R &= ~(1U << 11); /* set bit 11 to 0 */

  while( ;; ) {
    /* set PA5 to high (trigger LED) */
    GPIOA_OD_R |= LED_PIN;
  }
}
