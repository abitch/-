assume cs:code
code segment
	start:
		mov ax,0b800h
		mov ds,ax
		mov dl,120
		mov cx,127
		mov si,0
	restart:
		sub dl,10
		mov dh,3
		mov di,1
	s:
		cmp di,20
		je restart
		call show_str
		push cx
		call delay
		pop cx
		inc dh
		inc si
		inc di
		loop s
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
		mov ax,si
		mov [bx],al
		mov byte ptr [bx+1],2
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