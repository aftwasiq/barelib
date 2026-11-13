ENTRY(Reset_Handler)

MEMORY
{
  FLASH(rx):ORIGIN=0x08000000, LENGTH=512K,
  SRAM(rwx):ORIGIN=0x20000000, LENGTH=96K,
}

_estack = ORIGIN(SRAM) + LENGTH(SRAM);

/* setting heap and stack size accordingly */
__max_heap_size = 0x200;
__max_stack_size = 0x400;

SECTIONS 
{
  .text :
  {
   . = ALIGN(4);
   *(.isr_vector_tbl)
   *(.text)
   *(.rodata)
   . = ALIGN(4);
   _etext = .;

  }>FLASH

  .data :
  {
   . = ALIGN(4);
   _sdata = .;
   *(.data)
   . = ALIGN(4);
   _edata = .;

  /* virtual memory address and load memory address */
  }>SRAM AT> FLASH /*>(VMA) AT> (LMA)*/
  /* initial values should be stored in FLASH
   * but the section itself placed in SRAM */

  .bss :
  {
   . = ALIGN(4);
   _sbss = .;
   *(.bss)
   . = ALIGN(4);
   _ebss = .;

  }>SRAM

}
