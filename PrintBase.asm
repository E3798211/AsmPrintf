; Prints number in binary
; Expects:	number in r8
;			1-byte buffer called BUFF
;			1 in rax
;			1 in rdi
; Uses:		rcx, esi, r8, r9, r10
; Leaves:	...

printBin:
		mov rcx, 64d
		mov esi, BUFF + 63d
.next_digit:
		mov r10, r8
		and r10, 1b
		shr r8, 1d

		add r10, '0'					; Now in r11 '0' or '1'
		mov [esi], r10b					; Placing lowest byte to buff
		dec esi

		loop .next_digit

		mov rdx, 64d
		mov rsi, BUFF	
		syscall

		;call flushBuff

		ret

; ======================================

; Prints number in octal
; Expects:	number in r8
;			64-byte buffer called BUFF
;			1 in rax
;			1 in rdx
;			1 in rdi
; Uses:		rcx, esi, r8, r9, r10
; Leaves:	...

printOct:
		mov rcx, 22d
		mov esi, BUFF + 63d
.next_digit:
		mov r10, r8
		and r10, 111b
		shr r8, 3d

		add r10, '0'					; Now in r11 '0'-'1'
		mov [esi], r10b					; Placing lowest byte to buff
		dec esi

		loop .next_digit

		mov rdx, 64d
		mov rsi, BUFF	
		syscall

		;call flushBuff

		ret

; =======================================

; Prints number in hex
; Expects:	number in r8
;			1-byte buffer called BUFF
;			1 in rax
;			1 in rdx
;			1 in rdi
; Uses:		rcx, esi, r8, r9, r10
; Leaves:	...

printHex:
		mov rcx, 16d
		mov esi, BUFF + 63d
.next_digit:
		mov r10, r8
		and r10, 1111b
		shr r8,  4d

		cmp r10, 9d
		jbe .just_digit
		add r10, 7d
.just_digit:
		add r10, '0'

		mov [esi], r10b				; Placing lowest byte to buff
		dec esi

		loop .next_digit

		mov rdx, 64d
		mov rsi, BUFF
		syscall

		;call flushBuff

		ret

; ======================================

; Prints number in decimal
; Expects:	number in r8
;			1 in rdi
;			1-byte buffer called BUFF
; Uses:		rcx, rdx, esi, r8, r9, r10
; Leaves:	...

printDec:
		mov rcx, 22d
		mov r10, 10d
		mov esi, BUFF + 63
.next_digit:
		mov rax, r8
		xor rdx, rdx
		div r10
		mov r8, rax

		add rdx, '0'					; Now in rdx '0' - '9'
		mov [rsi], dl					; Placing remainder to buff
		dec esi

		loop .next_digit
		
		mov rax, 1						; Printing the whole buffer
		mov rdx, 64
		mov esi, BUFF
		syscall
		
		ret

; ======================================

; Prints char
; Expects:	char in r8
;			1 in rax
;			1 in rdx
;			1 in rdi
; Uses:		rcx, rsi, r8
; Leaves:	...

printChr:
		mov [BUFF], r8b					; Placing char to buffer
		
		mov rsi, BUFF
		syscall

		ret

; ======================================

; Prints string
; Expects:	pointer to str in r8
;			1 in rax
;			1 in rdx
;			1 in rdi
; Uses:		rcx, rsi, r8
; Leaves:	...

printStr:
		mov rsi, r8
.next:									; Kinda like infinite 'while'
		cmp byte [rsi], 0
		je .exit
		syscall
		inc rsi
		jmp .next

.exit:
		ret

; =======================================

; Fills buffer with zeros
; Expects:		nothing
; Uses:			rcx, rsi
; Leaves:		..


flushBuff:
		mov rcx, 63
		xor rsi, rsi
.next:	
		mov byte [MESSAGE + esi], 0
		inc esi
		loop .next
		ret



