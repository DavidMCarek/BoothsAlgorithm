; Microsystems Homework 0
; David Carek

.model small
.586
.Stack 100h
Include PCMAC.Inc
.Data

    CRLF                DB 0Dh, 0Ah, '$'
    InputMultiplier     DB 'Enter the multiplier > ', '$'
    InputMultiplicand   DB 'Enter the multiplicand > ', '$'
    Result              DB 'Result > ', '$'

.Code
    extern GetDec : NEAR, PutDDec : NEAR
    Booth Proc

        mov     ax, @Data
        mov     ds, ax

        sPutStr InputMultiplicand
        call    GetDec
        mov     bx, ax
        sPutStr CRLF

        sPutStr InputMultiplier
        call    GetDec
        sPutStr CRLF

        mov     cx, 16
        xor     dx, dx
        clc
        
    Loop_Start:

    jc  C1
    C0:
        test    ax, 1
        jz      Shift
        sub     dx, bx
        jmp     Shift
    C1:
        test    ax, 1
        jnz     Shift
        add     dx, bx

    Shift:
        sar     dx, 1
        rcr     ax, 1
        dec     cx

        jnz     Loop_Start

        mov     bx, ax
        mov     ax, dx
        shl     eax, 10h
        mov     ax, bx

        sPutStr Result
        call PutDDec 

        _Exit 0

    Booth EndP

End Booth
