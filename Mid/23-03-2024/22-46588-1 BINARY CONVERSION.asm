.MODEL SMALL
.STACK 100H
.DATA
    A DB ?
    BIN_0 DB '0000$'
    BIN_1 DB '0001$'
    BIN_2 DB '0010$'
    BIN_3 DB '0011$'
    BIN_4 DB '0100$'
    BIN_5 DB '0101$'
    BIN_6 DB '0110$'
    BIN_7 DB '0111$'
    BIN_8 DB '1000$'
    BIN_9 DB '1001$'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX
    
    MOV AH, 01H
    INT 21H
    SUB AL, 30H
    MOV A,AL
    
    MOV AH,2
    MOV DL,10
    INT 21H
    MOV DL,13
    INT 21h 


    CMP A, 0
    JE PRINT_BIN_0
    CMP A, 1
    JE PRINT_BIN_1
    CMP A, 2
    JE PRINT_BIN_2
    CMP A, 3
    JE PRINT_BIN_3
    CMP A, 4
    JE PRINT_BIN_4
    CMP A, 5
    JE PRINT_BIN_5
    CMP A, 6
    JE PRINT_BIN_6
    CMP A, 7
    JE PRINT_BIN_7
    CMP A, 8
    JE PRINT_BIN_8
    CMP A, 9
    JE PRINT_BIN_9

    PRINT_BIN_0:
        LEA DX,BIN_0
        JMP PRINT
    PRINT_BIN_1:
        LEA DX,BIN_1
        JMP PRINT
    PRINT_BIN_2:
        LEA DX,BIN_2
        JMP PRINT
    PRINT_BIN_3:
        LEA DX,BIN_3
        JMP PRINT
    PRINT_BIN_4:
        LEA DX,BIN_4
        JMP PRINT
    PRINT_BIN_5:
        LEA DX,BIN_5
        JMP PRINT
    PRINT_BIN_6:
        LEA DX,BIN_6
        JMP PRINT
    PRINT_BIN_7:
        LEA DX,BIN_7
        JMP PRINT
    PRINT_BIN_8:
        LEA DX,BIN_8
        JMP PRINT
    PRINT_BIN_9:
        LEA DX,BIN_9
        JMP PRINT
    
    PRINT:
        MOV AH,09H
        INT 21H
        JMP EXIT
    
    EXIT:
        MOV AH,4CH
        INT 21H
    
    MAIN ENDP
END MAIN
