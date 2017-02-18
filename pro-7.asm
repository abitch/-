assume cs:code
data segment
	;db 5 dup(2eh,4),2ah,4,8 dup(2eh,4),2ah,4,7 dup(2eh,4)
	;db 4 dup(2eh,4),2ah,4,2 dup(2eh,4)
	db 5 dup(2eh),2ah,8 dup(2eh),2ah,7 dup(2eh)
	db 4 dup(2eh),2ah,2 dup(2eh),2ah,5 dup(2eh),2ah,2eh,2ah,6 dup(2eh)
	db 5 dup(2eh),2ah,2 dup(2eh),2ah,4 dup(2eh),2ah,2 dup(2eh),2ah,5 dup(2eh)
	db 6 dup(2eh),2 dup(2ah,2eh,2eh),3 dup(2ah,2eh),4 dup(2eh)
	db 5 dup(2eh),2ah,9 dup(2eh),2ah,6 dup(2eh)
	db 3 dup(2eh),2ah,13 dup(2eh),2ah,4 dup(2eh)
	db 2 dup (2eh),2ah,15 dup(2eh),2ah,3 dup(2eh)
	db 2eh,2ah,17 dup(2eh),2ah,2eh,2eh
	db 2ah,19 dup(2eh),2ah,2eh
	db 2ah,19 dup(2eh),2ah,2eh
	db 2 dup(2ah,5 dup(2eh)),2eh,2eh,2ah,5 dup(2eh),2ah,2eh
	db 2ah,19 dup(2eh),2ah,2eh
	db 2ah,3 dup(2eh),40h,5 dup(2eh),55h,5 dup(2eh),40h,3 dup(2eh),2ah,2eh
	db 2eh,2ah,17 dup(2eh),2ah,2eh,2eh
	db 2eh,2eh,2ah,2ah,13 dup(2eh),2ah,2ah,3 dup(2eh)
data ends

code segment
	start:
		mov cx,10
		mov bl,2
		
		sec:
			mov ax,1000h
			mov es,ax
			mov ax,data
			mov ds,ax
			mov si,0
			mov di,0
			push cx
			call translate	;将数据存放到段地址为1000处
			
			mov ax,0b800h
			mov ds,ax
			mov dh,4
			mov dl,40		
			mov cx,15
			mov si,0
			push bx
		s:	
			call show_str
			inc dh
			loop s
			push cx
			call delay
			pop cx
			pop bx
			pop cx
			inc bl
			loop sec
			
		
		mov ax,4c00h
		int 21h
	
	translate:
		mov cx,330
	s1:
		mov al,[si]
		mov es:[di],al
		mov es:[di+1],bl
		add di,2
		inc si
		loop s1
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
		mov cx,44
		
	change:			
		mov al,es:[si]
		mov [bx],al
		inc si
		inc bx
		loop change
		pop cx
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