assume cs:code
data segment
	db 'happy spring festival!'
	db 1,2,4,2,4,1,4,1,2
data ends
code segment
	start:
		mov ax,data
		mov es,ax
		mov ax,0b800h
		mov ds,ax
		mov cx,4
	s2:
		mov di,22
		push cx
		mov cx,3
	s1:
		push cx
		mov cx,22
		mov dl,40
		mov dh,3
		mov si,0
		
	s:
		call show_str
		inc dh
		add dl,4
		inc si
		loop s
		pop cx
		inc di
		push cx
		call delay
		pop cx
		loop s1
		pop cx
		loop s2
		
		mov ax,4c00h
		int 21h
	show_str:
		mov al,160
		mul dh
		push dx
		mov dh,0	
		add ax,dx
		pop dx
		mov bx,ax	;bx存放地址
	change:
		mov al,es:[si]
		mov [bx],al
		mov ah,es:[di]
		mov byte ptr [bx+1],ah
		mov [bx+6],al
		mov ah,es:[di+3]
		mov byte ptr [bx+7],ah
		mov [bx+12],al
		mov ah,es:[di+6]
		mov byte ptr [bx+13],ah
		ret
	delay:
		mov cx,0ffh
		fir:
			mov ax,0ffh
		rep10:
			dec ax
			cmp ax,0h
			jne rep10
			loop fir	
		ret
		
code ends
end start