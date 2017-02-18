assume cs:code
Cryptography segment
	db 'tqsfbe!zpvs!xjoht'
	db '!!cf!zpvs!nbtufs!'
Cryptography ends

PlainText segment
	db 2*17 dup(' ')
PlainText ends

code segment
	start:
		mov ax,Cryptography
		mov ds,ax
		mov ax,PlainText
		mov es,ax
		mov cx,34
		mov bx,0
	s:
		dec byte ptr ds:[bx]
		mov al,ds:[bx]
		mov es:[bx],al
		inc bx
		loop s
		
		mov bx,0
		mov ax,0b800h
		mov ds,ax
		mov si,7a0h
		mov cx,34
	s1:
		mov al,es:[bx]
		mov ds:[si],al
		mov byte ptr ds:[si+1],71h
		inc bx
		add si,2
		loop s1
		
		mov ax,4c00h
		int 21h
		
code ends
end start