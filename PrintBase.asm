; Prints number in binary
; Expects:	number in r8
;			1-byte buffer called BUFF
;			1 in rax
;			1 in rdx
;			1 in rdi
; Uses:		rcx, esi, r8, r9, r10, r11
; Leaves:	...

printBin:
		mov rcx, 64
		mov esi, BUFF
		mov r10, 1
		shl r10, 63						; Getting 8000'0000'0000'0000h
.next_digit:
		mov r11, r8
		and r11, r10
		shl r8, 1

		shr r11, 63
		add r11, '0'					; Now in r11 '0' or '1'
		mov [BUFF], r11b				; Placing lowest byte to buff

		mov r9, rcx
		syscall
		mov rcx, r9

		loop .next_digit
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

printOct:
		mov rcx, 21
		mov esi, BUFF
		mov r10, 111b
		shl r10, 60						; Getting 8000'0000'0000'0000h
.next_digit:
		mov r11, r8
		and r11, r10
		shl r8, 3

		shr r11, 60
		add r11, '0'
		mov [BUFF], r11b				; Placing lowest byte to buff

		mov r9, rcx
		syscall
		mov rcx, r9

		loop .next_digit
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

