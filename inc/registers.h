#ifndef REGISTERS_H
#define REGISTERS_H

/*
  registers.h

  this is the main header file for this driver library, extensively 
  commenting each address as part of documenting my learning process
*/

/* PERIPHERAL BASE ADDRESS */
#define PERIPH_BASE         (0x40000000UL)

/* advanced high-performance bus offset & AHB1 base */
#define AHB1PERIPH_OFFSET   (0x00020000UL)
#define AHB1PERIPH_BASE     (PERIPH_BASE + AHB1PERIPH_OFFSET)

/* GPIO offset & GPIO base */
#define GPIOA_OFFSET        (0x00000000UL)
#define GPIOA_BASE          (AHB1PERIPH_BASE + GPIOA_OFFSET)

/* reset and clock control offset & RCC base */
#define RCC_OFFSET          (0x00003800UL)
#define RCC_BASE            (AHB1PERIPH_BASE + RCC_OFFSET)

/* AHB1 enable offset & RCC enable address */
#define AHB1EN_R_OFFSET     (0x00000030UL)
#define RCC_AHB1EN_R        (*(volatile unsigned int *) (RCC_BASE + AHB1EN_R_OFFSET))

/* GPIO port mode offset & port mode register */
#define MODE_R_OFFSET       (0x00000000UL)
#define GPIOA_MODE_R        (*(volatile unsigned int *) (GPIOA_BASE + MODE_R_OFFSET))

/* GPIO output data offset & register */
#define OD_R_OFFSET         (0x14UL)
#define GPIOA_OD_R          (*(volatile unsigned int *) (GPIOA_BASE + OD_R_OFFSET))

/* GPIOA enable bit mask */
/* pin 5 bit mask */
#define GPIOAEN             (1U << 0)
#define PIN5                (1U << 5)
#define LED_PIN             PIN5 /* alias for pin 5 */

#endif /* REGISTERS_H */
