

;  Simple 8086 Assembly Calculator
org 100h

org 100h
.model small
.data

titleMsg    db 0dh,0ah,"===== Arithmetic Operations Menu =====",0dh,0ah,'$'
menuMsg     db 0dh,0ah,"1) Add Numbers",0dh,0ah,"2) Multiply Numbers",0dh,0ah,"3) Subtract Numbers",0dh,0ah,"4) Divide Numbers",0dh,0ah,"5) Exit Program",0dh,0ah,'$'
chooseMsg   db 0dh,0ah,"Enter your choice (1–5): ",'$'
firstNumMsg db 0dh,0ah,"Please enter the first value: $"
secondNumMsg db 0dh,0ah,"Please enter the second value: $"
invalidMsg  db 0dh,0ah,"Invalid selection! Please select option 1–5.",0dh,0ah,'$'
resultMsg   db 0dh,0ah,"Calculation Result: $"
exitMsg     db 0dh,0ah,"Program completed successfully. Press any key to exit...",0dh,0ah,'$'

.code

jmp beginProgram

beginProgram:
    mov ah,9
    mov dx,offset titleMsg
    int 21h
    mov ah,9
    mov dx,offset menuMsg
    int 21h
    mov ah,9
    mov dx,offset chooseMsg
    int 21h
    mov ah,0
    int 16h

    cmp al,'1'
    je additionFunc
    cmp al,'2'
    je multiplyFunc
    cmp al,'3'
    je subtractFunc
    cmp al,'4'
    je divideFunc
    cmp al,'5'
    je exitProgram

    mov ah,9
    mov dx,offset invalidMsg
    int 21h
    mov ah,0
    int 16h
    jmp beginProgram

additionFunc:
    mov ah,9
    mov dx,offset firstNumMsg
    int 21h
    mov cx,0
    call readNumber
    push dx
    mov ah,9
    mov dx,offset secondNumMsg
    int 21h
    mov cx,0
    call readNumber
    pop bx
    add dx,bx
    push dx
    mov ah,9
    mov dx,offset resultMsg
    int 21h
    mov cx,10000
    pop dx
    call displayNumber
    jmp exitProgram

multiplyFunc:
    mov ah,9
    mov dx,offset firstNumMsg
    int 21h
    mov cx,0
    call readNumber
    push dx
    mov ah,9
    mov dx,offset secondNumMsg
    int 21h
    mov cx,0
    call readNumber
    pop bx
    mov ax,dx
    mul bx
    mov dx,ax
    push dx
    mov ah,9
    mov dx,offset resultMsg
    int 21h
    mov cx,10000
    pop dx
    call displayNumber
    jmp exitProgram

subtractFunc:
    mov ah,9
    mov dx,offset firstNumMsg
    int 21h
    mov cx,0
    call readNumber
    push dx
    mov ah,9
    mov dx,offset secondNumMsg
    int 21h
    mov cx,0
    call readNumber
    pop bx
    sub bx,dx
    mov dx,bx
    push dx
    mov ah,9
    mov dx,offset resultMsg
    int 21h
    mov cx,10000
    pop dx
    call displayNumber
    jmp exitProgram

divideFunc:
    mov ah,9
    mov dx,offset firstNumMsg
    int 21h
    mov cx,0
    call readNumber
    push dx
    mov ah,9
    mov dx,offset secondNumMsg
    int 21h
    mov cx,0
    call readNumber
    pop bx
    mov ax,bx
    mov cx,dx
    mov dx,0
    div cx
    mov bx,dx
    mov dx,ax
    push bx
    push dx
    mov ah,9
    mov dx,offset resultMsg
    int 21h
    mov cx,10000
    pop dx
    call displayNumber
    pop bx
    jmp exitProgram

readNumber:
    mov ah,0
    int 16h
    mov dx,0
    mov bx,1
    cmp al,0dh
    je buildNumber
    sub ax,30h
    call showDigit
    mov ah,0
    push ax
    inc cx
    jmp readNumber

buildNumber:
    pop ax
    push dx
    mul bx
    pop dx
    add dx,ax
    mov ax,bx
    mov bx,10
    push dx
    mul bx
    pop dx
    mov bx,ax
    dec cx
    cmp cx,0
    jne buildNumber
    ret

displayNumber:
    mov ax,dx
    mov dx,0
    div cx
    call showDigit
    mov bx,dx
    mov dx,0
    mov ax,cx
    mov cx,10
    div cx
    mov dx,bx
    mov cx,ax
    cmp ax,0
    jne displayNumber
    ret

showDigit:
    push ax
    push dx
    mov dx,ax
    add dl,30h
    mov ah,2
    int 21h
    pop dx
    pop ax
    ret

exitProgram:
    mov dx,offset exitMsg
    mov ah,9
    int 21h
    mov ah,0
    int 16h
    ret


ret





