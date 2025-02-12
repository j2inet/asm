
ExitProcess PROTO
WriteConsoleA PROTO
WriteConsoleW PROTO
GetStdHandle PROTO

.data
myText db 'HelloWorld', 10, 14, 10, 14
myTextLength EQU ($ - myText)
myExtendedText dW "H","e", "l", "l", "o", "W", "o", "r", "l", "d", 10, 14, 10, 14
myExtendedTextLength EQU ($ - myExtendedText)
OutputHandle DQ 0

bytesWritten DD 0
myList DWORD 2, 3, 5, 8

.code
  main PROC
  push rbp			;	save caller's rbp
  mov rbp, rsp		;	set rbp to point to start of stack frame
  sub rsp, 20h	

  mov rcx, -11           ; STD_OUTPUT_HANDLE
  call GetStdHandle
  mov OutputHandle, rax

  mov rcx, rax
  LEA rdx,  myText
  mov r8, myTextLength
  lea r9, bytesWritten
  call WriteConsoleA

  mov rcx, OutputHandle
  LEA rdx,  myExtendedText
  mov r8, myExtendedTextLength
  lea r9, bytesWritten
  call WriteConsoleW

  xor rcx, rcx
  call ExitProcess

  mov rsp, rbp		;	restore stack pointer
	pop rbp				;	restore old (caller's) rbp
	ret
main ENDP

END
