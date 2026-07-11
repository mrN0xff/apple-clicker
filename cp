nasm -f elf64 apple_clicker.asm -o apple_clicker.o
ld -o apple_clicker apple_clicker.o
./apple_clicker
