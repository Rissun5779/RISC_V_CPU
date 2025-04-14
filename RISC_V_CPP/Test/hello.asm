    .section .data
msg:    .asciz "Hello, RISC-V!\n"

    .section .text
    .globl _start
_start:
    li a7, 64            # 64 是 sys_write 系統調用號
    li a0, 1             # a0 是檔案描述符，1 表示標準輸出
    la a1, msg           # a1 是要寫入的資料地址
    li a2, 16            # a2 是資料長度
    ecall                # 觸發系統呼叫

    li a7, 93            # 93 是 sys_exit 系統呼叫號
    li a0, 0             # a0 是返回值，0 表示正常退出
    ecall                # 觸發系統呼叫
