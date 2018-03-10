; Prints line with formatted inserts
;		%x	for		hexadecimal
;		%o	for		octal
;		%b	for		binary
;		%u	for		unsigned decimal
;		%c	for		character
;		%s	for		string
;
; Expects:	formatted line called MESSAGE with lengh MESG_LEN
;			arguments in stack in cdecl
; Uses:		rax, rbx, rcx, rdx, rsi, rdi, rbp, rsp
; Leaves:	rsi		amount of characters printed

printLine:
		push rbp
		mov  rbp, rsp					; [bp+16] - 1st argument. 24, 32, ...
		mov  rbx, 16					; Used for addressing. Next arg: bx+=8

		xor rsi, rsi
		mov esi, MESSAGE				; Loading string to ESI
		mov rcx, MSG_LEN				; Setting counter with string's length
.load:	
		mov rax, 1
        mov rdi, 1
        mov rdx, 1						; Setting print

		cmp byte [esi], 0				; Terminator
		je  .exit
		cmp byte [esi], '%'				; Analysing char
		jne .print						; Average - just print
		
		inc rsi							; Looking at the second character - must be base

		mov r8,  [rbp + rbx]			; Loading parameter
		add rbx, 8

;		SAVE COUNTER IN USELESS REGISTER
		
		cmp byte [esi], 'x'
		je  .hex
		cmp byte [esi], 'o'
		je  .oct
		cmp byte [esi], 'b'
		je  .bin
		cmp byte [esi], 'u'
		je  .dec
		cmp byte [esi], 'c'
		je  .chr
		cmp byte [esi], 's'
		je  .str

		nop								; Unexpected specificator
;		CRY LIKE A BITCH ABOUT THE FAULT
		jmp .end_processing

.end_processing:
		inc rsi
;		RESTORE COUNTER


.print:	
		mov r15, rcx
		syscall							; Writing one character
		mov rcx, r15
		inc rsi							; Pointing to the next character

		loop .load

; ======================================
;
; Processing is here
;

.hex:
		mov r15, rcx
		mov r14, rsi
		call printHex
		mov rsi, r14
		mov rcx, r15
		mov rdx, 1
		jmp .end_processing
.oct:
		mov r15, rcx
		mov r14, rsi
		call printOct
		mov rsi, r14
		mov rcx, r15
		mov rdx, 1
		jmp .end_processing
.bin:
		mov r15, rcx
		mov r14, rsi
		call printBin
		mov rsi, r14
		mov rcx, r15
		mov rdx, 1
		jmp .end_processing
.dec:
		mov r15, rcx
		mov r14, rsi
		call printDec
		mov rsi, r14
		mov rcx, r15
		mov rdx, 1
		jmp .end_processing
.chr:
		mov r14, rsi
		call printChr
		mov rsi, r14
		jmp .end_processing
.str:
		mov r14, rsi
		call printStr
		mov rsi, r14
		jmp .end_processing

; ======================================

.exit:
		pop rbp
		ret

; ======================================

%include "PrintBase.asm"


