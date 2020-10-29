org 100h
jmp main
the macro
	main
endm
exit macro 
	xor ax,ax
	int 21h
endm

key macro 
	xor ax,ax
	int 16h
endm

paint macro 
	push ds
	mov cx,65535
	mov ax,0a000h
	mov ds,ax
	mov dx,0ffh
	mov bx,0
  paint1:
	ds
	mov [bx],dl
	inc bx
	dec cx
	cmp cx,0
	jnz paint1
	pop ds
endm

screen macro v1
	mov al,v1
	mov ah,0
	int 10h
endm

cls macro 
	screen 3
endm

colors  macro color
	mov ah,color
	mov dx,03c4h
	mov al,2
	out dx,ax
endm

print macro value,color,x,y,size
	mov dh,x
	mov dl,y
	mov bh,0
	mov ax,value
	mov bp,ax
	mov cx,size
	mov al,0
	mov ah,13h
	mov bl,color
	int 10h
endm



printchr macro value,color,x,y,size
	print value,color,x,y,1
	mov di,size
	mov si,value
	
printchr1:
	ds
	mov al,[si]	
	mov ah,9
	mov cx,1
	mov bl,color
	mov bh,0
	int 10h
	inc si
	dec di
	cmp di,0
	jnz printchr1
endm


main proc
	screen 12h
	colors 1
	paint
	push es
	mov ax,cs
	mov es,ax
	print offset hello,0ffh,5,5,14
	pop es
	colors 0
	key
	cls
	exit
end main
hello db "hello there...................... "
