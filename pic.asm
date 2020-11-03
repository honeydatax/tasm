org 100h
_start:
	mov al,12h
	call screen
	mov ah,1
	call colors
	call paint
	mov ah,14
	call colors
	mov cx,40
	mov dx,80
	mov bx,ships
	call picture
	mov ah,0
	call colors
	call key
	call cls
exit:
	xor ax,ax
	int 21h
	ret
key:
	xor ax,ax
	int 16h
	ret
box:
	push bp
	push ax;6 color w
	push cx;4 h
	push bx;2 x
	push dx;0 y
	mov bp,sp
   box1:	
	mov cx,0
	mov cl,[bp+6] 
	mov bx,[bp+2]
	mov dx,[bp+0]
	mov ah,[bp+7]
	push bp
	call lines
	pop bp
	mov cx,[bp+0]
	inc cx
	mov [bp+0],cx
	mov cx,[bp+4]
	dec cx
	mov [bp+4],cx
	cmp cx,0
	jnz box1
	clc
	add sp,8
	pop bp
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
clearbox:
	push bp
	push ax;6 color w
	push cx;4 h
	push bx;2 x
	push dx;0 y
	mov bp,sp
   clearbox1:	
	mov cx,0
	mov cl,[bp+6] 
	mov bx,[bp+2]
	mov dx,[bp+0]
	mov ah,[bp+7]
	push bp
	call clearlines
	pop bp
	mov cx,[bp+0]
	inc cx
	mov [bp+0],cx
	mov cx,[bp+4]
	dec cx
	mov [bp+4],cx
	cmp cx,0
	jnz clearbox1
	clc
	add sp,8
	pop bp
ret

clearlines:
	push ds
	push cx
	push bx
	push dx
	mov ah,15
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
	mov al,0
  clearlines1:
	ds
	mov [bx],al
	inc bx
	dec cx
	jnz clearlines1
	pop ds
ret
picture:
	push ds
	push bx
	push cx
	push dx
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
	pop si
	cs
	mov cx,[si]
	inc si
	mov ax,ds
	mov di,ax
	mov ax,0a000h
	mov ds,ax
   picture1:
	cs
	mov al,[si]
	ds
	mov [bx],al
	clc
	add bx,80
	inc si
	dec cx
	cmp cx,0
	jnz picture1 
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


hello db "hello world..........\000$$$"
ships dw 8
db	00011100b 
db	00110110b 
db	00110110b 
db	01100011b 
db	01111111b 
db	01100011b 
db	01100011b 
db	01100011b 
