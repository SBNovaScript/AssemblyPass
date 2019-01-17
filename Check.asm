; Steven Baumann
; 12/12/18
;Checks if the password is in it's correct format

.386
.MODEL FLAT, C
.STACK 4096

.DATA
capWordCheck DWORD 0
numCheck DWORD 0


.CODE
asmCheck PROC chArray:DWORD, chLength:DWORD ; Start of the password checking program.
	
	cmp chLength, 9 ; If the password is less than 9 chars, throw an error.
	jl error

	xor eax, eax ; Setting up memory location from C++.
	mov ebx, chArray
	dec chLength
	xor ecx, ecx

	L1: ; Main loop, looping through the char array.
	inc ecx
	mov eax, [ebx]
	movzx eax, al ; Copy over al to the eax register, zeroing out non al bits.

	cmp eax, 00000021h ; If the user typed non chars, throw an error.
	jb error
	cmp eax, 0000007Dh
	jg error

	verify: ; Verifying the two other conditions.

	cmp eax, 0000005Bh ; If the char is the letter Z or less, continue checking.
	jl nextCap
	
	continueCap:

	cmp eax, 0000003Ah ; If the char is the number 9 or less, continue checking.
	jl nextNum

	continueNum:

	inc ebx ; get the nextmemory address, and mov it's value into eax (zeroing out non char values).
	cmp ecx, chLength
	jne L1
	mov eax, [ebx]
	movzx eax, al ; only runs after loop is finished
	jmp done

	nextCap: ; If the char is a capital letter, set the capWordCheck var to 1.
	cmp eax, 00000040h
	jl continueCap
	mov capWordCheck, 1
	jmp continueCap

	nextNum: ; If the char is a num, set numCheck to 1.
	cmp eax, 0000002Fh
	jl continueNum
	mov numCheck, 1
	jmp continueNum

	error: ; If there is an error, return ~.
	mov eax, 0000007Eh
	ret

	done: 

	cmp capWordCheck, 1 ; If there are no cap words or numbers, throw an error.
	jl error
	cmp numCheck, 1
	jl error

	ret
asmCheck ENDP

END