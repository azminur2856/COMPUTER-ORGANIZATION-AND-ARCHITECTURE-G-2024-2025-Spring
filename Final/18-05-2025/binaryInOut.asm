.MODEL SMALL
.STACK 100H

.DATA
  INPUT DB "Input the Binary Number:$"
  OUTPUT DB "Output:$"
  NEW_LINE DB 0AH, 0DH, '$'

.CODE

MAIN PROC
  MOV AX, @DATA
  MOV DS, AX
  XOR BX, BX         ; Clear BX (will store binary input)
  MOV CX, 16         ; Max 16 bits input

  MOV AH, 9
  LEA DX, INPUT
  INT 21H

INPUT_LOOP:
  MOV AH, 1          ; Read a character
  INT 21H
  CMP AL, 0DH        ; If Enter pressed (carriage return)
  JE OUTPUT_LOOP

  AND AL, 0FH        ; Convert ASCII to binary (AL = 0 or 1)
  SHL BX, 1          ; Shift BX left to make space
  OR BL, AL          ; Store new bit at LSB
  LOOP INPUT_LOOP

OUTPUT_LOOP:
  MOV AH, 9
  LEA DX, NEW_LINE
  INT 21H

  ; Print output label
  MOV AH, 9
  LEA DX, OUTPUT
  INT 21H

  ; Print binary value
  MOV CX, 16         ; 16 bits to print

PRINT_LOOP:
  SHL BX, 1          ; Shift MSB to carry
  JNC PRINT_0

  MOV AH, 2
  MOV DL, 31H
  INT 21H
  JMP NEXT

PRINT_0:
  MOV AH, 2
  MOV DL, 30H
  INT 21H

NEXT:
  LOOP PRINT_LOOP

EXIT:
  MOV AH, 4CH
  INT 21H

MAIN ENDP
END MAIN
