assume cs:code
data segment
	db 'ABCDEFGHIJKLMNOPQRSTUVWXYZ123456789ABCDE'
data ends

code segment
	start:
		mov ax,data
		mov es,ax
		mov ax,0b800h
		mov ds,ax
		mov cx,25
		mov dh,0
		mov byte ptr es:[42],24		
	s:
		mov si,0	
		mov dl,0
		call show_str
		call s1
		dec byte ptr es:[42]
		inc dh
		call delay
		loop s
		
		mov dh,0
		mov dl,80
		mov byte ptr es:[43],18
		mov cx,8
		call zuoxie
		mov cx,6
		dec dh
		add dl,4
		call heng
		inc dh
		sub dl,4
		mov cx,10
		call zuoxie
		mov cx,10
		dec dh
		add dl,4
		call heng
		mov cx,7
	s2:
		inc dh
		call show_tree
		call delay
		loop s2
		mov cx,3
		call heng
		mov cx,7
	s3:
		dec dh
		call show_tree
		call delay
		loop s3
		mov cx,10
		call heng
		mov cx,10
		call youxie
		mov cx,6
		call heng
		mov cx,7
		call youxie
		
		mov ax,4c00h
		int 21h
	
	youxie:
		dec dh
		sub dl,4
		call show_tree
		call delay	
		inc byte ptr es:[43]
		
		loop youxie
		ret
	zuoxie:
		call show_tree
		call delay
		inc dh
		inc byte ptr es:[43]
		sub dl,4
		loop zuoxie
		ret
	heng:
		add dl,4
		call show_tree
		call delay
		inc byte ptr es:[43]
		loop heng
		ret
	
	show_tree:
		mov al,160
		mul dh
		push dx
		mov dh,0	
		add ax,dx
		pop dx
		mov bx,ax	;bx存放地址
	change1:
		mov byte ptr [bx],1
		mov al,es:[43]
		mov byte ptr [bx+1],al
		ret
	s1:
		push dx
		mov dh,es:[42]
		mov dl,4
		mov si,1
		call show_str
		pop dx
		ret
	show_str:
		mov al,160
		mul dh
		push dx
		mov dh,0	
		add ax,dx
		pop dx
		mov bx,ax	;bx存放地址
		push cx
		mov cx,20
	change:
		mov al,es:[si]
		mov [bx],al
		mov byte ptr [bx+1],2
		add si,2
		add bx,8
		loop change
		pop cx
		ret	
	delay:
		push cx
		mov cx,0ffh
		fir:
			mov ax,0ffh
		rep10:
			dec ax
			cmp ax,0h
			jne rep10
			loop fir
		pop cx
		ret
code ends
end start