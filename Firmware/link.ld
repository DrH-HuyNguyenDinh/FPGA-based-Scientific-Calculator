/* link.ld */
MEMORY
{
    /* Gộp chung để Linker tự sắp xếp địa chỉ không chồng lấn */
    ALL (rwx) : ORIGIN = 0x00000000, LENGTH = 128K
}

SECTIONS
{
    .text : {
        *(.text.entry)
        *(.text)
        *(.rodata*)   /* Hằng số float sẽ nằm sau code */
        *(.srodata*)
    } > ALL

    .data : {
        _data_start = .;
        *(.data)
        *(.sdata)
        _data_end = .;
    } > ALL

    .bss : {
        _bss_start = .;
        *(.bss)
        *(.sbss)
        _bss_end = .;
    } > ALL

    /* Stack Pointer vẫn ở cuối Data RAM (64KB) */
    _stack_ptr = 0x00010000; 
}
