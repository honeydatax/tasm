org 100h
jmp main
print macro txt
	mov dx,txt
	mov ah,9
	int 21h
endm
exit macro 
	xor ax,ax
	int 21h
endm
main proc
	push ds
	mov ax,offset hello
	print ax
	pop ds
	exit
end main

hello db "hello there. ",13,10,"$"
