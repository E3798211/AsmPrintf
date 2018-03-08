global  _start

section .text

; Here's extended printf() function from C std library. Much better of course.
; Actions sequence:
; 1. Taking string														[main()		]
; 2. Printing characters untill we see '%' 								[printLine()]
; 3. Checking next character for base									[checkBase()]
; 4. Printing one num from the stack in proper notation					[printBASE()]
; 5. Going on printing next char (returning to #2)						[printLine()]
; 6. Coming across '0' - finishing placing characters to std output		[printLine()]
; 7. Exit syscall														[main()		]

; ======================================

_start:	
		push 7770777h
		
		call printLine

; ====	Done. Quitting program. ====
		mov     eax, 60                 ; system call 60 is exit
        xor     rdi, rdi                ; exit code 0
        syscall                         ; invoke operating system to exit

; ======================================

%include "PrintLine.asm"

section .data

MESSAGE		db	"Hello, %x World", 10, 0	; note the newline at the end
MSG_LEN 	equ	$-MESSAGE		
		
BUFF		db	'0'



;			nasm -f elf64 printf.asm
;			ld printf.o -o printf
