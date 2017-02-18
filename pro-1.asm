assume cs:code
data segment
	dw 0241h
data ends

code segment
start:
	mov ax,0b800h
	mov ds,ax
	mov bx,220h
	mov ax,data
	mov es,ax
	mov ax,es:[0]
	mov [bx],ax 
	
	mov ax,4c00h
	int 21h
code ends
end start