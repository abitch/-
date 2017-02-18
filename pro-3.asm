assume cs:code
Calculate segment
	db '1. 3/1=         '
	db '2. 5+3=         '
	db '3. 9-3=         '
	db '4. 4+5=         '
Calculate ends
stack segment
	dw 0,0,0,0,0,0,0,0
stack ends
code segment
	start:
		mov ax,stack
		mov ss,ax
		mov sp,16
		mov ax,Calculate
		mov ds,ax
		mov cx,4
		mov bx,4
	s:
		push cx
		mov al,[bx]
		mov ah,0
		sub ax,2bh
		mov cx,ax
		jcxz jia
		mov al,[bx]
		mov ah,0
		sub ax,2dh
		mov cx,ax
		jcxz jian
		mov al,[bx]
		mov ah,0
		sub ax,2fh
		mov cx,ax
		jcxz chu
		
	jian:
		mov al,[bx-1]
		mov ah,[bx+1]
		sub al,30h
		sub ah,30h
		sub al,ah
		add al,30h
		mov [bx+3],al
		pop cx
		add bx,16
		loop s
		mov ax,4c00h
		int 21h
	chu:
		mov al,[bx-1]
		mov ah,0
		mov dl,[bx+1]
		sub ax,30h
		sub dl,30h
		div dl
		add al,30h
		mov [bx+3],al
		pop cx
		add bx,16
		loop s
		mov ax,4c00h
		int 21h
	jia:
		mov al,[bx-1]
		mov ah,[bx+1]
		sub al,30h
		sub ah,30h
		add al,ah
		add al,30h
		mov [bx+3],al
		pop cx
		add bx,16
		loop s
		mov bx,3
		mov cx,5
		mov ax,0b800h
		mov es,ax
		mov si,220h
	s1:
		mov al,[bx]
		mov es:[si],al
		mov byte ptr es:[si+1],71h
		mov al,[bx+16]
		mov es:[si+0a0h],al
		mov byte ptr es:[si+0a0h+1],71h
		mov al,[bx+32]
		mov es:[si+140h],al
		mov byte ptr es:[si+140h+1],71h
		mov al,[bx+48]
		mov es:[si+1e0h],al
		mov byte ptr es:[si+1e0h+1],71h
		inc bx
		add si,2
		loop s1
		
		mov ax,4c00h
		int 21h
code ends
end start