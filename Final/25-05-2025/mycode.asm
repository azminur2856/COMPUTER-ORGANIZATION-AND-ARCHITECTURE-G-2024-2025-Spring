.model small
.stack 100h
.data
a db 0          ; count zeros
b db 0          ; count ones
msg0 db 'Count of zeros: $'
msg1 db 'Count of ones: $'
msgp db 'Parity Flag (PF): $'
newline db 0Dh,0Ah,'$' 
evenmsg db 'Even parity',0Dh,0Ah,'$'
oddmsg db 'Odd parity',0Dh,0Ah,'$'

.code
main proc
    mov ax,@data
    mov ds,ax
    
    xor bx,bx        ; will store the bits input as a word
    mov cx,16        ; max 16 bits
    
input_start:
    mov ah,01h       ; read char from stdin, no echo
    int 21h
    
    cmp al,0Dh       ; Enter key = done input
    je process_bits
    
    cmp al,'0'
    je count_zero
    cmp al,'1'
    je count_one
    ; if not 0 or 1, ignore and repeat
    jmp input_start
    
count_zero:
    inc a            ; increment zero count
    ; store bit 0 in bx (shift bx left and add 0)
    shl bx,1
    ; no need to set bit because it is 0
    loop input_start
    jmp input_start

count_one:
    inc b            ; increment one count
    shl bx,1
    or bx,1          ; set LSB to 1
    loop input_start
    jmp input_start
    
process_bits:
    ; after input done, show results
    
    ; Display count zeros
    mov dx, offset msg0
    mov ah,09h
    int 21h
    
    mov al, a
    add al, '0'       ; convert count to ASCII digit (works for counts <10)
    mov dl, al
    mov ah,02h
    int 21h
    
    mov dx, offset newline
    mov ah,09h
    int 21h
    
    ; Display count ones
    mov dx, offset msg1
    mov ah,09h
    int 21h
    
    mov al, b
    add al, '0'
    mov dl, al
    mov ah,02h
    int 21h
    
    mov dx, offset newline
    mov ah,09h
    int 21h
    
    ; Now display parity flag (PF) of the last shifted bx
    ; Parity flag counts parity of the low byte (AL), so check AL
    
    mov ax,bx
    mov al, bl         ; low byte of BX
    
    ; PF is set if even parity (even number of 1 bits in AL)
    ; we can test PF by doing TEST or just relying on parity flag after xor 0
    
    ; Clear CF and OF for safety
    xor ah, ah
    
    ; parity flag set after xor al, al will be set (even parity)
    xor al, al
    ; parity flag now set for zero (which is even parity)
    ; This is no good, so instead:
    
    ; So we want to test parity of BL, do: 
    ; Use the parity flag after mov al, bl
    mov al, bl
    ; PF is now set automatically for AL
    
    ; We can jump on parity flag by jp (jump parity even) or jnp (jump parity odd)
    
    mov dx, offset msgp
    mov ah, 09h
    int 21h
    
    jp pf_even
    jmp pf_odd
    
pf_even:
    mov dx, offset evenmsg
    mov ah, 09h
    int 21h
    jmp done
    
pf_odd:
    mov dx, offset oddmsg
    mov ah, 09h
    int 21h
    jmp done
    
done:
    mov ah,4ch
    int 21h

main endp


end main
