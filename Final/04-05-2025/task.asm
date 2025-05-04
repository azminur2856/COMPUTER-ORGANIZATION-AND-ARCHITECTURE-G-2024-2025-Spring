.MODEL SMALL
.STACK 100H
.DATA
    MSG_INPUT     DB 'Enter a digit (0-9): $'
    MSG_GT7       DB ' is GREATER than 7.$'
    MSG_EQ7       DB ' is EQUAL to 7.$'
    MSG_LT7       DB ' is LESS than 7.$'
    NEWLINE       DB 0DH, 0AH, '$'
    INPUT         DB ?              

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV CX, 5          

READ_INPUT:
    MOV AH, 9
    LEA DX, MSG_INPUT
    INT 21H

    MOV AH, 1
    INT 21H
    MOV INPUT, AL

    MOV AH, 9
    LEA DX, NEWLINE
    INT 21H

    MOV DL, INPUT
    MOV AH, 2
    INT 21H

    MOV AL, INPUT
    CMP AL, '7'
    JE EQUAL_TO_7
    JG GREATER_THAN_7
    JL LESS_THAN_7

EQUAL_TO_7:
    MOV AH, 9
    LEA DX, MSG_EQ7
    INT 21H
    JMP NEXT

GREATER_THAN_7:
    MOV AH, 9
    LEA DX, MSG_GT7
    INT 21H
    JMP NEXT

LESS_THAN_7:
    MOV AH, 9
    LEA DX, MSG_LT7
    INT 21H

NEXT:
    MOV AH, 9
    LEA DX, NEWLINE
    INT 21H

    LOOP READ_INPUT

    MOV AH, 4CH
    INT 21H
MAIN ENDP
END MAIN
