assume cs:code
data segment
	db 'h12E332l@L#O*&^!88nI@cE$% %$T1O m33E44E55t y77O88u!()'
	db '?'
data ends
store segment
	db 30 dup (0)
store ends

code segment
	start:
		mov ax,store
		mov es,ax
		mov ax,data
		mov ds,ax
		mov bx,0
		mov si,0
	s:
		cmp byte ptr [bx],3fh
		je ok
		cmp byte ptr [bx],20h
		je transit
		cmp byte ptr [bx],21h
		je transit
		cmp byte ptr [bx],41h
		jb next
		cmp byte ptr [bx],7ah
		ja next
		cmp byte ptr [bx],5ah
		jna transit
		cmp byte ptr [bx],61h
		jnb transit
		
		inc bx
		loop s
		
	transit:
		push bx
		mov bx,[bx]
		mov es:[si],bx
		pop bx
		inc si
		inc bx
		jmp short s
	next:
		inc bx
		jmp short s
	ok:	
		push bx
		mov bx,[bx]
		mov es:[si],bx
		pop bx
		call string
		
		mov dh,8
		mov dl,2
		mov cl,2
		mov si,0
		
		call show_str
		mov ax,4c00h
		int 21h
	string:
		mov si,0
	s1:
		cmp byte ptr es:[si],3fh
		je okend
		and byte ptr es:[si],11011111b
		inc si
		s2:
			cmp byte ptr es:[si],20h
			je s3
			cmp byte ptr es:[si],21h
			je mark
			or byte ptr es:[si],00100000b
			s3:
				inc si
				loop s2
	okend:
		ret
	mark:
		inc si
		jmp short s1
	show_str:
		mov ax,0b800h
		mov ds,ax
		mov al,160
		mul dh
		mov dh,0
		add ax,dx
		mov bx,ax
	change:		
		cmp byte ptr es:[si],3fh
		je ok2			
		mov al,es:[si]
		mov [bx],al
		mov [bx+1],cl
		inc si
		add bx,2
		jmp short change
	ok2:		
		ret
code ends
end start