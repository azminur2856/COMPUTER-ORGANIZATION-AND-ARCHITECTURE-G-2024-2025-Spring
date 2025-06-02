.MODEL SMALL
.STACK 100H
.DATA
    hex1    DB 55h
    hex2    DB 55h
    sum     DB ?

    hexMsg  DB 'Sum of two hexa-decimal number: $'
    hexInd  DB 'h $'
    binMsg  DB 'Binary 8-bit of the sum (Hex)  : $'
    binInd  DB 'b $'
    newline DB 13,10, '$'
.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV AL, hex1
    ADD AL, hex2
    MOV sum, AL

    LEA DX, hexMsg
    MOV AH, 9
    INT 21H

    MOV AL, sum
    MOV AH, AL
    SHR AH, 4
    AND AH, 0Fh
    CALL PrintHexDigit

    MOV AL, sum
    AND AL, 0Fh
    MOV AH, AL
    CALL PrintHexDigit
    
    LEA DX, hexInd
    MOV AH, 9
    INT 21H

    LEA DX, newline
    MOV AH, 9
    INT 21H
    
    LEA DX, newline
    MOV AH, 9
    INT 21H

    LEA DX, binMsg
    MOV AH, 9
    INT 21H

    MOV AL, sum
    MOV BL, AL
    MOV CX, 8
    MOV BH, 10000000b

PrintBinaryLoop:
    MOV AL, BL
    AND AL, BH
    JZ PrintZero
    MOV DL, '1'
    JMP PrintBit
PrintZero:
    MOV DL, '0'
PrintBit:
    MOV AH, 2
    INT 21H
    SHR BH, 1
    LOOP PrintBinaryLoop
    
    LEA DX, binInd
    MOV AH, 9
    INT 21H

    MOV AH, 4CH
    INT 21H
MAIN ENDP

PrintHexDigit PROC
    CMP AH, 9
    JBE Print0to9
    ADD AH, 7
Print0to9:
    ADD AH, '0'
    MOV DL, AH
    MOV AH, 2
    INT 21H
    RET
PrintHexDigit ENDP

END MAIN
