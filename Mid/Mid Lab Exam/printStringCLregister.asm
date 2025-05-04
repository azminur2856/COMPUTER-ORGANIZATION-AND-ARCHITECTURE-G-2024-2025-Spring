.MODEL SMALL
.STACK 100H
.DATA
    MSG DB 'I love Bangladesh$'

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX

    MOV CL, 5

PRINT_MSG_AND_CL_VALUE:
                      LEA DX, MSG
                      MOV AH, 9
                      INT 21H
                    
                      MOV AH, 2
                      MOV DL, 0DH
                      INT 21H
                      MOV DL, 0AH
                      INT 21H
                    
                      DEC CL
                    
                      MOV AL, CL
                      ADD AL, 48
                      MOV DL, AL
                      MOV AH, 2
                      INT 21H
                    
                      CMP CL, 0
                      JE EXIT
                    
                      MOV AH, 2
                      MOV DL, 0DH
                      INT 21H
                      MOV DL, 0AH
                      INT 21H
                    
                      JMP PRINT_MSG_AND_CL_VALUE

EXIT:
    MOV AH, 4CH
    INT 21H

MAIN ENDP
END MAIN
