org 100h
_start:
	mov al,12h
	call screen
	mov ah,1
	call colors
	call paint
	push es
	mov ax,cs
	mov es,ax
	mov dh,5
	mov dl,5
	mov ax,hello
	mov bp,ax
	mov cx,14
	mov bl,0ffh
	call print
	pop es
	mov ah,0
	call colors
	call key
	call cls
	call exit
exit:
	xor ax,ax
	int 21h
	ret
key:
	xor ax,ax
	int 16h
	ret
paint:
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
ret
screen:
	mov ah,0
	int 10h
ret
cls:
	mov al,3
	call screen
	ret
colors:
	mov dx,03c4h
	mov al,2
	out dx,ax
	ret
print:
	mov bh,0
	mov al,0
	mov ah,13h
	int 10h
ret

hello db "hello world..........\000"
