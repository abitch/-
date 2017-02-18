assume cs:code
data segment
	db 16 dup (0)
data ends
code segment
	start:
		mov bx,data
		mov es,bx
		mov si,1	
		
		mov ax,4
		add ax,ax 
		add ax,ax
		add ax,ax
		add ax,ax
		call dtoc
		
		mov bx,0b800h
		mov ds,bx
		mov bx,220h
		mov byte ptr [bx],34h
		mov si,2c0h
		mov byte ptr ds:[si],33h
		mov si,360h
		mov cx,5
		s:
			mov byte ptr ds:[si],'-'
			add si,2
			loop s
		mov di,400h
		mov bx,0
		mov al,es:[bx]
		mov byte ptr ds:[di],al
		mov al,es:[bx+1]
		mov byte ptr ds:[di+2],al
		mov ax,4c00h
		int 21h
		
	jieshu:
		pop ax
		add al,30h
		mov es:[si],al
		ret
	
	dtoc:
		mov cx,10
		mov dx,0
		call divdw
		push cx		;cx=6,ax=1266
		mov cx,ax	;商若为0则结束
		jcxz jieshu
		pop ax
		add al,30h
		mov es:[si],al
		dec si
		mov ax,cx
		jmp short dtoc
	
	divdw:			;dx存高位商，ax存低位商，cx存余数
		push ax		;4240h		
		mov ax,dx
		mov dx,0
		div cx		;ax=1,dx=5
		mov bx,ax	;1h
		pop ax		;ax=4240h
		div cx		;ax=86a0,dx=0h
		mov cx,dx	;余数赋值给cx
		mov dx,bx
		ret
code ends
end start