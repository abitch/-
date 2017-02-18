assume cs:code
data segment
	db 60 dup(2eh,2)
data ends
code segment
	start:
		mov ax,data
		mov es,ax
		mov ax,0b800h
		mov ds,ax
		mov dh,8
		mov dl,80		
		mov cx,3
		mov si,0
	s:
		call show_str
		sub dl,40
		add dh,4
		loop s
		mov cx,3
		mov dh,15
		mov dl,0
	first:
		push cx
		mov cx,20	
	s1:
		call show_face
		add dl,2
		loop s1
		sub dh,4
		pop cx
		loop first
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
		push cx
		mov cx,40
		
	change:			
		mov al,es:[si]
		mov [bx],al
		inc si
		inc bx
		loop change
		pop cx
		ret
	show_face:
		mov al,160
		mul dh
		push dx
		mov dh,0	
		add ax,dx
		pop dx
		mov bx,ax	;bx存放地址
	change2:
		mov byte ptr [bx],1
		mov byte ptr [bx+1],2
		push cx
		call delay
		pop cx
		mov byte ptr [bx],0
		mov byte ptr [bx+1],0
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