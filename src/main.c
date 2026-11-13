#include "registers.h"

void _init(void) {}

void SystemInit(void) {}

int main(void) {
  /* enable clock access for GPIOA */
  RCC_AHB1EN_R |= GPIOAEN;

  /* configure PA5 to general-purpose output mode */
  GPIOA_MODE_R |= (1U << 10); /* set bit 10 to 1 (bitwise OR) */
  GPIOA_MODE_R &= ~(1U << 11); /* clear bit 11 to 0 (bitwise AND & NOT)*/

  for ( ;; ) {
    /* set PA5 to high (toggle LED) */
    GPIOA_OD_R |= LED_PIN;
  }

  return 0;
}
