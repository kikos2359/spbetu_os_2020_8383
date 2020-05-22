ASSUME CS:OVERLAY_1, DS:OVERLAY_1, ES:NOTHING, SS:NOTHING
OVERLAY_1 SEGMENT

MAIN_1 PROC FAR
   push DS
	push DX
	push DI
	push AX
	mov AX, CS
	mov DS, AX
	mov BX, offset MESS
	add BX, 30			
	mov DI, BX		
	mov AX, CS			
	call WRD_TO_HEX
	mov DX, offset MESS
	call 	WRITE_STRING
	pop AX
	pop DI
	pop DX	
	pop DS
	retf
MAIN_1 ENDP

TETR_TO_HEX PROC near
    and AL,0Fh
    cmp AL,09
    jbe NEXT
    add AL,07
    NEXT: add AL,30h
    ret
TETR_TO_HEX ENDP

BYTE_TO_HEX PROC near
    push CX
    mov AH,AL
    call TETR_TO_HEX
    xchg AL,AH
    mov CL,4
    shr AL,CL
    call TETR_TO_HEX
    pop CX
    ret
BYTE_TO_HEX ENDP

WRD_TO_HEX PROC near
    push BX
    mov BH,AH
    call BYTE_TO_HEX
    mov [DI],AH
    dec DI
    mov [DI],AL
    dec DI
    mov AL,BH
    call BYTE_TO_HEX
    mov [DI],AH
    dec DI
    mov [DI],AL
    pop BX
    ret
WRD_TO_HEX ENDP

WRITE_STRING PROC near
   push AX
   mov AH, 09H
   int 21H
   pop AX
   ret
WRITE_STRING ENDP

MESS db 13,10,'Segment address overlay1:                 ',13,10,'$'

OVERLAY_1 ENDS
    END 