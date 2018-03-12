; Prints number in binary
; Expects:	number in r8
;			1-byte buffer called BUFF
;			1 in rax
;			1 in rdi
; Uses:		rcx, esi, r8, r9, r10, r11
; Leaves:	...

;printBin:
;		mov rcx, 64
;		mov esi, BUFF
;		mov r10, 1
;		shl r10, 63						; Getting 8000'0000'0000'0000h
;.next_digit:
;		mov r11, r8
;		and r11, r10
;		shl r8, 1
;
;		shr r11, 63
;		add r11, '0'					; Now in r11 '0' or '1'
;		mov [BUFF], r11b				; Placing lowest byte to buff
;
;		mov r9, rcx
;		syscall
;		mov rcx, r9
;
;		loop .next_digit
;		ret

printBin:
		mov rcx, 64
		mov esi, BUFF + 63
		mov r10, 1
.next_digit:
		mov r11, r8
		and r11, r10
		shr r8, 1

		add r11, '0'					; Now in r11 '0' or '1'
		mov [esi], r11b					; Placing lowest byte to buff
		dec esi

		loop .next_digit

		mov rdx, 64
		mov rsi, BUFF	
		syscall

		ret

; ======================================


; DOESN'T LOOK ON THE FIRST BIT NOW!


; Prints number in octal
; Expects:	number in r8
;			1-byte buffer called BUFF
;			1 in rax
;			1 in rdx
;			1 in rdi
; Uses:		rcx, esi, r8, r9, r10, r11
; Leaves:	...

;printOct:
;		mov rcx, 21
;		mov esi, BUFF
;		mov r10, 111b
;		shl r10, 60						; Getting 8000'0000'0000'0000h
;.next_digit:
;		mov r11, r8
;		and r11, r10
;		shl r8, 3
;
;		shr r11, 60
;		add r11, '0'
;		mov [BUFF], r11b				; Placing lowest byte to buff
;
;		mov r9, rcx
;		syscall
;		mov rcx, r9
;
;		loop .next_digit
;		ret

printOct:
		mov rcx, 22
		mov esi, BUFF + 63
		mov r10, 111b
.next_digit:
		mov r11, r8
		and r11, r10
		shr r8, 3

		add r11, '0'					; Now in r11 '0' or '1'
		mov [esi], r11b					; Placing lowest byte to buff
		dec esi

		loop .next_digit

		mov rdx, 64
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
; Uses:		rcx, esi, r8, r9, r10, r11
; Leaves:	...

printHex:
		mov rcx, 16
		mov esi, BUFF
		mov r10, 1111b
		shl r10, 60						; Getting F000'0000'0000'0000h
.next_digit:
		mov r11, r8
		and r11, r10
		shl r8, 4

		shr r11, 60
		cmp r11, 9
		jbe .just_digit
		add r11, 7
.just_digit:
		add r11, '0'

		mov [BUFF], r11b				; Placing lowest byte to buff

		mov r9, rcx
		syscall
		mov rcx, r9

		loop .next_digit
		ret

; ======================================

; DOESN'T LOOK ON THE FIRST BIT NOW!

; Prints number in decimal
; Expects:	number in r8
;			1 in rdi
;			1-byte buffer called BUFF
; Uses:		rcx, rdx, esi, r8, r9, r10, r11
; Leaves:	

printDec:
		mov rcx, 64
		mov r10, 10

		mov esi, BUFF + 63

.next_digit:
		mov rax, r8
		xor rdx, rdx
		div r10
		mov r8, rax

		add rdx, '0'					; Now in rdx '0' - '9'
		mov [rsi], dl					; Placing lowest byte to buff
		dec esi

		loop .next_digit
		
		mov rax, 1						; Printing the whole buffer
		mov rdx, 64
		mov esi, BUFF
		syscall
		
		ret

; ======================================
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

; Fills buffer with zeros
; Expects:		nothing
; Uses:			rcx, rsi
; Leaves:		..


flushBuff:
		mov rcx, 63d
		mov rsi, 0
.next:	
		mov byte [BUFF + esi], 0
		inc rsi
		loop .next
		
		ret




