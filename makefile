# This is the makefile that I use for most of my 
# bare metal hobbyist projects on the STM32F401RE

TARGET = main
BUILD_DIR = build
LD_SCRIPT = stm32f401re.ld
MCU_SPEC = cortex-m4

CC = arm-none-eabi-gcc
OC = arm-none-eabi-objcopy
OD = arm-none-eabi-objdump
OS = arm-none-eabi-size

# ASFLAGS = -mcpu=$(MCU_SPEC) -mthumb -Wall
# was using this for assembly startup files which i dont use at the moment 
CFLAGS = -mcpu=$(MCU_SPEC) -mthumb -Wall -g -O0 -fmessage-length=0 -fno-builtin -Iinc -MMD -MP
LFLAGS = -mcpu=$(MCU_SPEC) -mthumb -Wall \
         -nostdlib -nostartfiles -nodefaultlibs \
         -T$(LD_SCRIPT) \
         -Wl,-Map=$(BUILD_DIR)/$(TARGET).map

STARTUP_SRC = inc/startup.c
C_SRC  = src/main.c

OBJS = $(addprefix $(BUILD_DIR)/, $(STARTUP_SRC:.c=.o) $(C_SRC:.c=.o))

DEPS = $(OBJS:.o=.d)

-include $(DEPS)

.PHONY: all clean flash erase

all: $(BUILD_DIR)/$(TARGET).bin

$(BUILD_DIR)/%.o: %.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

$(BUILD_DIR)/$(TARGET).elf: $(OBJS)
	$(CC) $(OBJS) $(LFLAGS) -o $@

$(BUILD_DIR)/$(TARGET).bin: $(BUILD_DIR)/$(TARGET).elf
	$(OC) -O binary $< $@
	$(OS) $<

flash: $(BUILD_DIR)/$(TARGET).bin
	st-flash write $(BUILD_DIR)/$(TARGET).bin 0x08000000

erase:
	st-flash erase

clean:
	rm -rf $(BUILD_DIR)

