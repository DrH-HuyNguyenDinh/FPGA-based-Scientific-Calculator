TARGET = calculator
SRCS = crt0.s main.c

PREFIX = riscv64-unknown-elf-
CC = $(PREFIX)gcc
OBJCOPY = $(PREFIX)objcopy
OBJDUMP = $(PREFIX)objdump

# Bare-metal RV32IF
# -ffp-contract=off: chặn fmadd/fmsub...
# -mno-relax: tắt linker relaxation để output ổn định hơn khi soi lệnh
CFLAGS = -march=rv32if -mabi=ilp32f -O2 \
         -ffreestanding -nostdlib -nostartfiles -T link.ld \
         -ffp-contract=off -mno-relax

.PHONY: all run help clean

all: instr.txt data_even.txt data_odd.txt $(TARGET).asm
	@echo "------------------------------------------------"
	@echo "Build successful! All files generated."
	@echo "Instr: instr.txt (32768 lines)"
	@echo "Data Even: data_even.txt (32768 lines)"
	@echo "Data Odd: data_odd.txt (32768 lines)"
	@echo "Asm: $(TARGET).asm (canonical disassembly, no aliases)"
	@echo "------------------------------------------------"

run: all

help:
	@echo "make run   : Build and generate all memory files"
	@echo "make clean : Remove build artifacts"

$(TARGET).elf: $(SRCS)
	$(CC) $(CFLAGS) $(SRCS) -o $(TARGET).elf -lgcc

# Dùng no-aliases để hiện lệnh canonical thay vì pseudo
# numeric để hiện x0..x31 thay vì abi names
$(TARGET).asm: $(TARGET).elf
	$(OBJDUMP) -d -M no-aliases,numeric $(TARGET).elf > $(TARGET).asm

$(TARGET).bin: $(TARGET).elf
	$(OBJCOPY) -O binary $(TARGET).elf $(TARGET).bin

# Tạo InstrMem (32-bit hex, little-endian word)
instr.txt: $(TARGET).bin
	@python3 -c "import struct; d=open('$(TARGET).bin','rb').read(); w=[struct.unpack('<I', d[i:i+4].ljust(4,b'\x00'))[0] for i in range(0,len(d),4)]; open('instr.txt','w').write(''.join([f'{x:08x}\n' for x in w] + ['00000000\n'] * (32768-len(w))))"

# Tạo DataMem Even & Odd (8-bit hex)
data_even.txt data_odd.txt: $(TARGET).bin
	@python3 -c "d=open('$(TARGET).bin','rb').read().ljust(65536,b'\x00'); open('data_even.txt','w').write(''.join([f'{b:02x}\n' for b in d[0::2]])); open('data_odd.txt','w').write(''.join([f'{b:02x}\n' for b in d[1::2]]))"

clean:
	rm -f *.elf *.bin *.txt *.asm
