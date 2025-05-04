.model small
.stack 100h
.data
.code
main proc

    mov ax, @data
    mov ds, ax

    ; Read first number
    mov ah, 1
    int 21h
    sub al, 30h  ; Convert ASCII to number
    mov bl, al   ; Store first number in BL

    ; Print newline (CR + LF)
    mov ah, 2
    mov dl, 13   ; Carriage Return
    int 21h
    mov dl, 10   ; Line Feed
    int 21h

    ; Read second number
    mov ah, 1
    int 21h
    sub al, 30h  ; Convert ASCII to number
    mov bh, al   ; Store second number in BH

    ; Print newline (CR + LF)
    mov ah, 2
    mov dl, 13   ; Carriage Return
    int 21h
    mov dl, 10   ; Line Feed
    int 21h

    ; Subtract first - second
    mov al, bl   ; Load first number into AL
    sub al, bh   ; Subtract second number
    add al, 30h  ; Convert back to ASCII

    ; Display result
    mov ah, 2
    mov dl, al
    int 21h

    ; Exit program
    mov ah, 4ch
    int 21h

main endp
end main
