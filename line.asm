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
	mov dx,0
loop1:
	push dx
	mov bx,0
	mov cx,80
	mov ah,15

	call lines
	pop dx
	clc
	add dx,10
	cmp dx,470
	jb loop1 
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
lines:
	push ds
	push cx
	push bx
	push dx
	call colors
	mov ax,80
	xor dx,dx
	xor cx,cx
	pop bx
	clc
	mul bx
	pop bx
	clc
	add ax,bx
	mov bx,ax
	pop cx
	mov ax,0a000h
	mov ds,ax
	mov al,255
  lines1:
	ds
	mov [bx],al
	inc bx
	dec cx
	jnz lines1
	pop ds
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
