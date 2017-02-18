assume cs:code
data segment
	db 14 dup(0),03h,04h,16 dup(0)
	DB 10 dup(0),03h,04h,6 dup(0),03h,04h,12 dup(0)
	
	db 14 dup(0),03h,04h,16 dup(0)
	DB 10 dup(0),03h,04h,6 dup(0),03h,04h,4 dup(0),03h,04h,6 dup(0)
	
	db 14 dup(0),03h,04h,10 dup(0),03h,04h,4 dup(0)
	DB 8 dup(0),03h,04h,8 dup(0),03h,04h,0,0,2 dup(03h,04h),6 dup(0)
	
	db 0,0,14 dup (03h,04h),0,0
	DB 8 dup(0),03h,04h,8 dup(0),03h,04h,03h,04h,10 dup(0)
	
	db 0,0,03h,04h,10 dup (0),03h,04h,10 dup (0),03h,04h,4 dup (0)
	DB 6 dup(0),2 dup(03h,04h),6 dup(0),2 dup(03h,04h),12 dup(0)
	
	db 0,0,03h,04h,10 dup (0),03h,04h,10 dup (0),03h,04h,4 dup (0)
	DB 2 dup(4 dup(0),03h,04h,0,0,03h,04h),12 dup(0)
	
	db 0,0,03h,04h,10 dup (0),03h,04h,10 dup (0),03h,04h,4 dup (0)
	DB 2 dup(0,0,03h,04h,4 dup (0),03h,04h),6 dup(0),03h,04h,4 dup(0)
	
	db 0,0,03h,04h,10 dup (0),03h,04h,10 dup (0),03h,04h,4 dup (0)
	DB 2 dup(8 dup(0),03h,04h),6 dup(0),03h,04h,4 dup(0)
	
	db 0,0,13 dup (03h,04h),4 dup(0)
	DB 8 dup(0),03h,04h,4 dup(0),03h,04h,4 dup(0),4 dup(03h,04h),4 dup(0)
	
	db 0,0,03h,04h,10 dup (0),03h,04h,10 dup (0),03h,04h,4 dup (0)
	DB 14 dup(0),03h,04h,16 dup(0)
	
	db 14 dup(0),03h,04h,16 dup(0)
	DB 15 dup(03h,04h),0,0
	
	db 14 dup(0),03h,04h,16 dup(0)
	DB 14 dup(0),03h,04h,16 dup(0)
	
	db 14 dup(0),03h,04h,16 dup(0)
	DB 14 dup(0),03h,04h,16 dup(0)
	
	db 14 dup(0),03h,04h,16 dup(0)
	DB 14 dup(0),03h,04h,16 dup(0)
	
	db 14 dup(0),03h,04h,16 dup(0)
	DB 14 dup(0),03h,04h,16 dup(0)
	
	db 14 dup(0),03h,04h,16 dup(0)
	DB 14 dup(0),03h,04h,16 dup(0)
data ends

code segment
	start:
		mov ax,0b800h
		mov es,ax
		mov dh,4
		mov dl,40
		mov cx,16
		mov ax,data
		mov ds,ax
		mov si,0
	s:	
		call show_str
		inc dh
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
		mov bx,ax
		push cx
		mov cx,64
	change:			
		mov al,[si]
		mov es:[bx],al
		inc si
		inc bx
		loop change
		pop cx
		ret
		
code ends
end start